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
from scipy.sparse.linalg import spsolve
from scipy.io import loadmat

from fmu_model import Generator

def time_event(t, tevent):
    return t - tevent > 0

def apply_fault():
    tf = 0.2
    def event(t):
        fun = time_event(t, tf)
        return fun

    return event

def clear_fault():
    tc = 0.3
    def event(t):
        fun = time_event(t, tc)
        return fun

    return event

def initNet(Ybus, gens):
    for k, gen in enumerate(gens):
        yg = 1 / gen.Zeq
        Ybus[k,k] += yg

has_applied_fault = False
has_cleared_fault = False
def calNet(Ybus, It, applied_fault=False, cleared_fault=False):
    global has_applied_fault
    global has_cleared_fault

    # Parâmetros calculados
    yf = 1 / 0.001j

    if applied_fault and not cleared_fault:
        if not has_applied_fault:
            Ybus[7, 7] += yf
            has_applied_fault = True

    elif applied_fault and cleared_fault:
        if not has_cleared_fault:
            ylt = -0.5*Ybus[7, 8]
            Ybus[7, 8] += ylt
            Ybus[8, 7] += ylt
            Ybus[7, 7] -= ylt
            Ybus[8, 8] -= ylt
            Ybus[7, 7] -= yf
            has_cleared_fault = True

    # Solução de tensões
    Vb = spsolve(Ybus, It)
    Vb.shape = (Vb.shape[0], 1)
    return Vb


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print(os.getcwd())

    tf = 10
    dt = 1e-3
    MVAb = 100.
    t = 0.0

    net = loadmat("net.mat")
    Ybus = net['Ybus']
    Sb = net["Sb"]
    Vb = net["Vb"]

    gen_data_1 = {'MVAs': 100,
                     'MVAb': 900,
                     'Nmaq': 1,
                     'Ra': 0.0025,
                     'Xd': 1.8,
                     'Xd': 1.7,
                     'T1d0': 8,
                     'T1q0': 0.4,
                     'T2d0': 0.03,
                     'T2q0': 0.05,
                     'X1d' : 0.3,
                     'X1q' : 0.55,
                     'X2d' : 0.25,
                     'X2q' : 0.25,
                     'Xd' : 1.8,
                     'Xl' : 0.2,
                     'Xq' : 1.7,
                     'D': 0,
                     'H': 6.5
                     }

    gen_data_2 = {'MVAs': 100,
                     'MVAb': 900,
                     'Nmaq': 1,
                     'Ra': 0.0025,
                     'Xd': 1.8,
                     'Xd': 1.7,
                     'T1d0': 8,
                     'T1q0': 0.4,
                     'T2d0': 0.03,
                     'T2q0': 0.05,
                     'X1d' : 0.3,
                     'X1q' : 0.55,
                     'X2d' : 0.25,
                     'X2q' : 0.25,
                     'Xd' : 1.8,
                     'Xl' : 0.2,
                     'Xq' : 1.7,
                     'D': 0,
                     'H': 6.175
                     }

    gens = list()
    gens.append(Generator(gen_data_1, tf = tf, dt=dt, atol=1e-6, rtol=1e-4, MVAb=MVAb))
    gens.append(Generator(gen_data_1, tf = tf, dt=dt, atol=1e-6, rtol=1e-4, MVAb=MVAb))
    gens.append(Generator(gen_data_2, tf = tf, dt=dt, atol=1e-6, rtol=1e-4, MVAb=MVAb))
    gens.append(Generator(gen_data_2, tf = tf, dt=dt, atol=1e-6, rtol=1e-4, MVAb=MVAb))

    print(f"Starting FMUs initialization.")

    Ib = np.zeros_like(Vb)
    for k, gen in enumerate(gens):
        St = Sb[k, 0]
        Vt = Vb[k, 0]
        gen.initialize(Vt, St)
        Ib[k, 0] = gen.Inorton
        gen.enter_continuous_time_mode()

    print(f"FMUs initialization finished.")

    initNet(Ybus, gens)

    print(f"Network initialization finished.")

    time = [t]
    its = [0]
    ode_its = [0]

    event_fcn = [apply_fault(), clear_fault()]
    events_prev = [f(t) for f in event_fcn]
    events = events_prev[:]

    pbar = tqdm.tqdm(total=tf + dt,
                     unit='s',
                     unit_scale=True,
                     smoothing=0,
                     bar_format='Simulation Time: |{bar}| {n_fmt}/{total_fmt} s [wall time: {elapsed}]'
                     )

    trigger_event = False
    print(f"\nStarted simulation")
    while t < tf:

        step_iter = 0
        doNextIter = True

        # Detecting event triggers
        if not trigger_event:
            events = [f(t+dt) for f in event_fcn]
            trigger_event = np.any(np.logical_xor(events, events_prev))
            if trigger_event:
                print(f"\nDetected events trigger at {t + dt: .4f} s")

            # Extrapolação
            # Vt = Vt_ext[0]*Vt_ext[0]/Vt_ext[1]

            for gen in gens:
                gen.set_time(t + dt)
                # gen.integrator.predictor()

            stop_time = False
        else:
            stop_time = True
            trigger_event = False

        while doNextIter:

            # Integra modelo de máquina
            if not stop_time:
                has_x_converged = True
                for k, gen in enumerate(gens):
                    gen.set_Vt(Vb[k, 0])
                    gen.step()
                    gen.calc_norton()
                    Ib[k, 0] = gen.Inorton
                    has_x_converged *= gen.has_x_converged
            else:
                has_x_converged = True

            # Cálculo da rede
            if stop_time:
                af = event_fcn[0](t)
                cf = event_fcn[1](t)
            else:
                af = event_fcn[0](t)
                cf = event_fcn[1](t)

            Vb_new = calNet(Ybus, Ib, af, cf)

            # Erro de interface
            if stop_time:
                has_interface_converged = True
                Vb[:, 0] = Vb_new[:, 0]

                # Definição da tensão terminal da máquina
                for k, gen in enumerate(gens):
                    gen.set_Vt(Vb[k, 0])
                    gen.fmu.get_derivatives()
            else:
                has_interface_converged = np.all(np.abs(Vb_new - Vb) < 1e-6)
                Vb[:, 0] = Vb_new[:, 0]
                # for k, gen in enumerate(gens):
                #     gen.set_Vt(Vb[k, 0])
                #     gen.update_interface()
                #     has_interface_converged *= gen.has_interface_converged

            # Se erro maior que a tolerância, realizar nova interação
            doNextIter = not (has_interface_converged and has_x_converged)
            # doNextIter = step_iter < 5
            step_iter += 1

        # Avançar o tempo
        if not stop_time:
            t += dt

        terminate = False
        for k, gen in enumerate(gens):
            terminate += gen.complete_integration_step()
            gen.set_Vt(Vb[k, 0])
            gen.update_history()
        if terminate:
            print(f"TERMINATE at {t: 6.4f} s !!!")
            exit(1)

    #
    #     active_event_mode = integrator.enter_event_handling()
    #     if active_event_mode:
    #         # Armazenando de resultados após eventos
    #         time += [t]
    #         sol += [fmu_.get_real(vref)]
    #         its.append(step_iter)
    #         integrator.exit_event_handling()
    #
        events_prev = events[:]
        pbar.update(t-time[-1])

        # Armazenando estatísticas do prcessos iterativo
        its.append(step_iter)
        # erros.append(interface_error)

        # Armazenando de resultados
        time += [t]
        for gen in gens:
            gen.store_results()

    print(f"Finished simulation at {t: 5.4f} s")
    pbar.close()

    for gen in gens:
        gen.process_results()

    #
    # Carraganto resultados do OMEdit para comparação
    #
    d = DyMat.DyMatFile('results/Kundur_Two_Area_System_res.mat')
    delta_om = d['d13']
    time_delta_om = d.abscissa('d13', valuesOnly=True)
    omega_om = d['G1.inertia.omega']
    time_omega_om = d.abscissa('G1.inertia.omega', valuesOnly=True)
    pe_om = d['G1.electrical.Pe']
    time_pe_om = d.abscissa('G1.electrical.Pe', valuesOnly=True)
    efd_om = d['G1.electrical.Efd']
    time_efd_om = d.abscissa('G1.electrical.Efd', valuesOnly=True)
    #
    # Traçado de gráficos
    fig = plt.figure(figsize=(12,6))
    ax = fig.subplots(nrows=5, sharex=True)
    ax[0].grid(ls=':')
    d13 = gens[0].results[:, 0] - gens[2].results[:, 0]
    ax[0].plot(time, d13, '-ro', label='CS', markevery=int(len(time) / 20))
    ax[0].plot(time_delta_om, delta_om, '--b', label='OMEdit')
    ax[0].set_ylabel('$\delta(t)$ [rad]')
    ax[0].legend(loc='upper right')
    ax[0].set_xlim([0, max(time)])

    ax[1].grid(ls=':')
    ax[1].plot(time, gens[0].results[:, 1], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[1].plot(time_omega_om, omega_om, '--b', label='OMEdit')
    ax[1].set_ylabel('$\omega(t)$ [pu]')
    ax[1].legend(loc='upper right')

    ax[2].grid(ls=':')
    ax[2].plot(time, gens[0].results[:, 2], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[2].plot(time_pe_om, pe_om, '--b', label='OMEdit')
    ax[2].set_ylabel('$P_e(t)$ [pu]')
    ax[2].legend(loc='upper right')
    #
    ax[3].grid(ls=':')
    ax[3].plot(time, gens[0].results[:, 3], '-ro', label='CS', markevery=int(len(time) / 20))
    ax[3].plot(time_efd_om, efd_om, '--b', label='OMEdit')
    ax[3].set_ylabel('$E_{fd}(t)$ [pu]')
    ax[3].legend(loc='upper right')
    #
    # ax[4].grid(ls=':')
    # ax[4].plot(time, erros, '-bo', label='v_error', markevery=int(len(time) / 15))
    # ax[4].set_ylabel('error')
    # ax[4].legend(loc='upper right')
    #
    ax[4].grid(ls=':')
    ax[4].plot(time, its, '-bo', label='iterations', markevery=int(len(time) / 15))
    ax[4].set_ylabel(u'iterations')
    # ax[4].legend(loc='upper right')
    #
    ax[-1].set_xlabel('time [s]')
    plt.tight_layout()
    plt.savefig('KUNDUR.pdf', dpi=300)
