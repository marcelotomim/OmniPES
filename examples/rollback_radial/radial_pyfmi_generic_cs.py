# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

import os
import pyfmi
from pyfmi.fmi import FMUModelCS2, FMUModelME2
import tqdm
import matplotlib.pyplot as plt
import matplotlib
# matplotlib.use('TkAgg')
matplotlib.use('Qt5Agg')
import numpy as np
import DyMat
from scipy.linalg import solve
np.set_printoptions(edgeitems=5, precision=4)

from modified_euler import ModifiedEuler

from numpy.random import random
def getJacobian(model):

    states = model.get_states_list()
    states_references = [s.value_reference for s in states.values()]
    derivatives = model.get_derivatives_list()
    derivatives_references = [d.value_reference for d in derivatives.values()]
    n = len(states)
    jac = np.zeros((n,n))
    v = np.zeros(n)
    for k in range(n):
        v[k] = 1.0
        jac[:, k] = model.get_directional_derivative(states_references, derivatives_references, v)
        v[k] = 0.0

    return jac


def getTerminalAdmittance(model):
    voltages = ['controlledVoltage1.Vr', 'controlledVoltage1.Vi']
    currents = ['SM.electrical.terminal.i.re', 'SM.electrical.terminal.i.im']

    voltages_references = [model.get_variable_valueref(s) for s in voltages]
    currents_references = [model.get_variable_valueref(s) for s in currents]

    n = 2
    jac = np.zeros((n,n))
    v = np.zeros(n)
    for k in range(n):
        v[k] = 1.0
        jac[:, k] = model.get_directional_derivative(voltages_references, currents_references, v)
        v[k] = 0.0

    return jac


def time_event(t, tevent):
    return t - tevent > 0

def apply_fault():
    tf = 0.1

    def event(t):
        fun = time_event(t, tf)
        return fun

    return event


def clear_fault():
    tc = 0.2

    def event(t):
        fun = time_event(t, tc)
        return fun

    return event


def calNet(t, It, Zg, applied_fault=False, cleared_fault=False):
    # Parâmetros da rede
    Zt = 0.15j
    Zlt1 = 0.5j
    Zlt2 = 0.93j
    Voo = 1.0
    Zf = 0.01j

    # Parâmetros calculados
    y12 = 1 / Zt
    y23 = 1 / Zlt1 + 1 / Zlt2
    yf = 1 / Zf
    yg = 1 / Zg

    # Matriz de admitância
    Ybb = np.matrix(np.zeros((2, 2), dtype=complex))
    Ybb[0, 0] = y12 + yg
    Ybb[0, 1] = -y12

    Ybb[1, 0] = -y12
    Ybb[1, 1] = y12 + y23

    # Vetor de correntes
    Ibb = np.matrix(np.zeros((2, 1), dtype=complex))
    Ibb[0, 0] = It

    if applied_fault and not cleared_fault:
        Ybb[1, 1] += yf
        Ibb[1, 0] = y23 * Voo
    elif applied_fault and cleared_fault:
        ylt = 1 / Zlt2
        Ybb[1, 1] -= ylt
        Ibb[1, 0] = (y23 - ylt) * Voo
    else:
        Ibb[1, 0] = y23 * Voo

    # Solução de tensões
    Vbb = solve(Ybb, Ibb)

    return Vbb[0, 0]


def initNet(Pesp, Vesp):
    # Parâmetros da rede
    Zt = 0.15j
    Zlt1 = 0.5j
    Zlt2 = 0.93j
    Voo = 1.0

    # Calculo de impedância de Thevenin
    Zth = Zt + 1 / (1 / Zlt1 + 1 / Zlt2)

    # Cálculos de regime permanente
    theta = np.arcsin(Pesp * abs(Zth) / Vesp / Voo)
    Vt = Vesp * np.exp(1j * theta)
    I = (Vt - Voo) / Zth
    S = Vt * np.conj(I)

    return Vt, S.imag


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print(os.getcwd())

    model_name = "OmniPES.CoSimulation.Examples.Generic_Machine_TL"

    #    Importa as FMUS
    # fmu_ = pyfmi.load_fmu(f'{model_name}.fmu', log_level=2, kind='CS')
    fmu_ = FMUModelCS2(f'./FMU/{model_name}.fmu', log_level=2)
    print(fmu_.get_capability_flags())

    fmu_.instantiate()
    tf = 10
    dt = 1e-4
    fmu_.setup_experiment(tolerance=1e-8, start_time=0, stop_time=tf + dt)

    # Testes de alterações de parâmetros da simulação
    fmu_.enter_initialization_mode()
    Sbase = 2220.
    fmu_.set("data.Sbase", Sbase)
    fmu_.set("gen1_data.MVAs", Sbase)
    fmu_.set("gen1_data.MVAb", Sbase)
    fmu_.set("gen1_data.H", 3.5)
    fmu_.set("gen1_data.D", 0.0)

    Vesp = 1.0
    Pesp = 1776. / Sbase
    fmu_.set("gen1_specs.Pesp", Pesp * Sbase)

    Vt, Qesp = initNet(Pesp, Vesp)

    X2d = fmu_.get("gen1_data.convData.X2d")[0]
    Zc = complex(0, X2d)

    fmu_.set("gen1_specs.Vesp", np.abs(Vt))
    fmu_.set("gen1_specs.theta_esp", np.angle(Vt))
    fmu_.set("gen1_specs.Qesp", Qesp * Sbase)
    fmu_.set("bergeronLink.Zc.re", Zc.real)
    fmu_.set("bergeronLink.Zc.im", Zc.imag)

    t = 0.0

    print(f"Initialization finished.")
    fmu_.exit_initialization_mode()

    # Cálculo da interface com a rede (Bergeron)
    Ehm = fmu_.get("bergeronLink.Ehm.re")[0] + 1j*fmu_.get("bergeronLink.Ehm.im")[0]
    Ehk_ini = fmu_.get("bergeronLink.Ehk_ini.re")[0] + 1j * fmu_.get("bergeronLink.Ehk_ini.im")[0]
    var_Ehk = complex(0)
    It = Ehm / Zc
    # Vt = calNet(0, It, Zc, False, False)

    variables = ["SM.inertia.delta",
                 "SM.inertia.omega",
                 "SM.electrical.Pe",
                 "SM.electrical.Efd"]
    vref = [fmu_.get_variable_valueref(v) for v in variables]
    sol = [fmu_.get_real(vref)]
    time = [t]
    its = [0]
    error = [0]

    event_fcn = [apply_fault(), clear_fault()]
    events_prev = [f(t) for f in event_fcn]

    pbar = tqdm.tqdm(total=tf + dt,
                     unit='s',
                     unit_scale=True,
                     smoothing=0,
                     bar_format='Simulation Time: |{bar}| {n_fmt}/{total_fmt} s [wall time: {elapsed}]'
                     )
    trigger_event = False
    while t < tf: # and not fmu_.get_event_info().terminateSimulation:

        step_iter = 0
        doNextIter = True

        # Detecting event triggers
        if not trigger_event:
            events = [f(t + dt) for f in event_fcn]
            trigger_event = np.any(np.logical_xor(events, events_prev))
            if trigger_event:
                print(f"\nDetected events trigger at {t + dt}")

            # Extrapolação
            # integrator.predictor()
            # Vt = Vt_ext[0]*Vt_ext[0]/Vt_ext[1]

            # Vt_vec[0] = Vt
            # Vt_vec[1] = Vt

            # fmu_.time = t
            stop_time = False
        else:
            stop_time = True
            trigger_event = False

        while doNextIter:

            # Integra modelo de máquina
            if not stop_time:
                # Definição da tensão terminal da máquina
                fmu_.set("var_Ehk_re", var_Ehk.real)
                fmu_.set("var_Ehk_im", var_Ehk.imag)

                status = fmu_.do_step(t, dt)
                Ehm = fmu_.get("bergeronLink.Ehm.re")[0] + 1j*fmu_.get("bergeronLink.Ehm.im")[0]

            else:
                has_x_converged = True
                # der_x = fmu_.get_derivatives()

            # Cálculo da rede
            if stop_time:
                af = event_fcn[0](t+dt)
                cf = event_fcn[1](t+dt)
            else:
                af = event_fcn[0](t)
                cf = event_fcn[1](t)

            # It = Ehm / Zc # converge mais rápido
            Vt = calNet(t, It, Zc, af, cf)
            Im = Vt / Zc - It
            Ehk = Vt + Zc*Im
            var_Ehk = Ehk - Ehk_ini
            It = Ehm / Zc # deve estar aqui

            # Se erro maior que a tolerância, realizar nova interação
            doNextIter = False
            step_iter += 1

        # Avançar o tempo
        t = fmu_.time

        events_prev = events[:]

        pbar.update(t - time[-1])

        # Armazenando estatísticas do prcessos iterativo
        its.append(step_iter)

        # Armazenando de resultados
        time += [t]
        sol += [fmu_.get_real(vref)]

    pbar.close()
    #

    solv = np.array(sol)

    # Carraganto resultados do OMEdit para comparação
    d = DyMat.DyMatFile('results/Radial_Generic_Machine_res.mat')
    delta_om = d['GS.electrical.delta']
    time_delta_om = d.abscissa('GS.electrical.delta', valuesOnly=True)
    omega_om = d['GS.inertia.omega']
    time_omega_om = d.abscissa('GS.inertia.omega', valuesOnly=True)
    pe_om = d['GS.electrical.Pe']
    time_pe_om = d.abscissa('GS.electrical.Pe', valuesOnly=True)
    efd_om = d['GS.electrical.Efd']
    time_efd_om = d.abscissa('GS.electrical.Efd', valuesOnly=True)

    # Traçado de gráficos
    fig = plt.figure(figsize=(12, 6))
    ax = fig.subplots(nrows=4, sharex=True)
    ax[0].grid(ls=':')
    ax[0].plot(time, solv[:, 0], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[0].plot(time_delta_om, delta_om, '--b', label='OMEdit')
    ax[0].set_ylabel('$\delta(t)$ [rad]')
    ax[0].legend(loc='upper right')
    ax[0].set_xlim([0, tf])

    ax[1].grid(ls=':')
    ax[1].plot(time, solv[:, 1], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[1].plot(time_omega_om, omega_om, '--b', label='OMEdit')
    ax[1].set_ylabel('$\omega(t)$ [pu]')
    ax[1].legend(loc='upper right')

    ax[2].grid(ls=':')
    ax[2].plot(time, solv[:, 2], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[2].plot(time_pe_om, pe_om, '--b', label='OMEdit')
    ax[2].set_ylabel('$P_e(t)$ [pu]')
    ax[2].legend(loc='upper right')

    ax[3].grid(ls=':')
    ax[3].plot(time, solv[:, 3], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[3].plot(time_efd_om, efd_om, '--b', label='OMEdit')
    ax[3].set_ylabel('$E_{fd}(t)$ [pu]')
    ax[3].legend(loc='upper right')

    ax[-1].set_xlabel('time [s]')
    plt.tight_layout()
    plt.savefig('radial.pdf', dpi=300)

