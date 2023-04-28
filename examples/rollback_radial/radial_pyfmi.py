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

    model_name = "OmniPES.CoSimulation.Examples.Test_Classical_Machine"

    #    Importa as FMUS
    # fmu_ = pyfmi.load_fmu(f'{model_name}.fmu', log_level=2, kind='me')
    # fmu_ = FMUModelCS2(path_fmus + f'./{model_name}.fmu', log_level=2)
    fmu_ = FMUModelME2(f'./FMU/{model_name}.fmu', log_level=2)
    print(fmu_.get_capability_flags())

    fmu_.instantiate()
    tf = 10
    dt = 1e-3
    fmu_.setup_experiment(tolerance=1e-4, start_time=0, stop_time=tf + dt)

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

    fmu_.set("Vr", Vt.real)
    fmu_.set("Vi", Vt.imag)
    fmu_.set("gen1_specs.Qesp", Qesp * Sbase)

    Zg = fmu_.get("gen1_data.convData.Ra")[0] + 1j * fmu_.get("gen1_data.convData.X1d")[0]
    t = 0.0

    # Cálculo da interface com a rede (Eq. de Norton)
    Iar = -fmu_.get("SM.electrical.terminal.i.re")[0]
    Iai = -fmu_.get("SM.electrical.terminal.i.im")[0]
    Ia = Iar + 1j * Iai
    E2 = Vt + Zg * Ia
    It = E2 / Zg

    Vt_vec = np.zeros(2, dtype=complex)
    Vt_vec[0] = Vt
    Vt_vec[1] = Vt

    Vt_ext = np.zeros(2, dtype=complex)
    Vt_ext[0] = Vt
    Vt_ext[1] = Vt

    print(f"Initialization finished.")
    fmu_.exit_initialization_mode()

    integrator = ModifiedEuler(fmu_, dt, tf, atol=1e-4, rtol=1e-2)
    integrator.init_events()

    fmu_.enter_continuous_time_mode()
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

    pbar = tqdm.tqdm(total=tf + dt)
    trigger_event = False
    while t < tf and not fmu_.get_event_info().terminateSimulation:

        interface_error = 1.0
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

            Vt_vec[0] = Vt
            Vt_vec[1] = Vt

            fmu_.time = t + dt
            stop_time = False
        else:
            stop_time = True
            trigger_event = False

        while doNextIter:

            # Integra modelo de máquina
            if not stop_time:
                # Definição da tensão terminal da máquina
                fmu_.set("Vr", Vt.real)
                fmu_.set("Vi", Vt.imag)

                integrator.step()
                has_x_converged = integrator.check_convergence()

                # Cálculo da interface com a rede (Eq. de Norton)
                Er = fmu_.get("SM.electrical.E1.re")[0]
                Ei = fmu_.get("SM.electrical.E1.im")[0]
                It = (Er + 1j * Ei) / Zg

            else:
                has_x_converged = True
                # der_x = fmu_.get_derivatives()

            # Cálculo da rede
            if stop_time:
                af = event_fcn[0](t)
                cf = event_fcn[1](t)
            else:
                af = event_fcn[0](t)
                cf = event_fcn[1](t)

            Vt = calNet(fmu_.time, It, Zg, af, cf)
            Vt_vec[1] = Vt_vec[0]
            Vt_vec[0] = Vt

            # Erro de interface
            if stop_time:
                interface_error = 0

                # Definição da tensão terminal da máquina
                fmu_.set("Vr", Vt.real)
                fmu_.set("Vi", Vt.imag)
                fmu_.get_derivatives()
            else:
                interface_error = abs(Vt_vec[0] - Vt_vec[1])

            # Se erro maior que a tolerância, realizar nova interação
            doNextIter = interface_error > 1e-4 and not has_x_converged  # or step_iter < 5
            step_iter += 1

        # Avançar o tempo
        t = fmu_.time
        if stop_time:
            Vt_ext[1] = Vt
            Vt_ext[0] = Vt

        terminate = integrator.complete_integration_step()
        if terminate:
            print("Ops!!!")
            exit(1)

        integrator.update_history()

        active_event_mode = integrator.enter_event_handling()
        if active_event_mode:
            # Armazenando de resultados após eventos
            time += [t]
            sol += [fmu_.get_real(vref)]
            its.append(step_iter)
            integrator.exit_event_handling()

        events_prev = events[:]

        pbar.update(t - time[-1])

        # Armazenando estatísticas do prcessos iterativo
        its.append(step_iter)
        error.append(interface_error)

        # Armazenando de resultados
        time += [t]
        sol += [fmu_.get_real(vref)]

    pbar.close()
    #

    solv = np.array(sol)

    # Carraganto resultados do OMEdit para comparação

    d = DyMat.DyMatFile('results/Radial_res.mat')
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
    ax = fig.subplots(nrows=6, sharex=True)
    ax[0].grid(ls=':')
    ax[0].plot(time, solv[:, 0], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[0].plot(time_delta_om, delta_om, '--b', label='OMEdit')
    ax[0].set_ylabel('$\delta(t)$ [rad]')
    ax[0].legend(loc='upper right')

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

    ax[4].grid(ls=':')
    ax[4].plot(time, error, '-bo', label='v_error', markevery=int(len(time) / 15))
    ax[4].set_ylabel('error')
    ax[4].legend(loc='upper right')

    ax[5].grid(ls=':')
    ax[5].plot(time, its, '-bo', label='iterations', markevery=int(len(time) / 15))
    ax[5].set_ylabel(u'iterations')
    # ax[5].legend(loc='upper right')

    ax[-1].set_xlabel('time [s]')
    plt.tight_layout()
    plt.savefig('radial.pdf', dpi=300)

