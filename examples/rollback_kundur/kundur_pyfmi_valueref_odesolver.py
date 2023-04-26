# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

import os
import pyfmi
from pyfmi.fmi import FMUModelCS2, FMUModelME2
import tqdm
import matplotlib.pyplot as plt
import numpy as np
import DyMat
from scipy.linalg import solve
from copy import deepcopy
import pandas as pd

from modified_euler import ModifiedEuler

from numpy.random import random

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print(os.getcwd())

    model_name = "OmniPES.QuasiSteadyState.Examples.Kundur_Two_Area_System"

    #    Importa as FMUS
    # fmu_ = pyfmi.load_fmu(f'FMU/{model_name}.fmu', log_level=2, kind='me')
    fmu_ = FMUModelME2(f'FMU/{model_name}.fmu', log_level=2)
    # print(fmu_.get_capability_flags())

    fmu_.instantiate()
    tf = 10.
    dt = 1e-3
    fmu_.setup_experiment(tolerance=1e-6, start_time=0, stop_time=tf+dt)

    # Testes de alterações de parâmetros da simulação
    fmu_.enter_initialization_mode()
    fmu_.set("fault.R", 1e-6)
    fmu_.set("fault.X", 0.01)
    print(f"Initialization finished.")
    fmu_.exit_initialization_mode()

    t = 0.0
    time = [t]
    variables = ["G1.electrical.delta",
                 "G2.electrical.delta",
                 "G3.electrical.delta",
                 "G4.electrical.delta",
                 "G1.avr.Efd",
                 "bus8.V"]
    vref = [fmu_.get_variable_valueref(v) for v in variables]
    sol = [fmu_.get_real(vref)]

    its = [0]

    # assert(False)
    integrator = ModifiedEuler(fmu_, dt, tf)
    integrator.init_events()

    fmu_.enter_continuous_time_mode()

    pbar = tqdm.tqdm(total=tf+dt, unit='s', delay=0)
    trigger_event = False
    while t < tf and not fmu_.get_event_info().terminateSimulation:

        interface_error = 1.0
        step_iter = 0
        doNextIter = True

        integrator.predictor()
        fmu_.time = t + dt
        stop_time = False

        while doNextIter:

            # Integra modelo de máquina
            integrator.step()
            has_converged = integrator.check_convergence()

            # Se erro maior que a tolerância, realizar nova interação
            doNextIter = not has_converged # or step_iter < 5
            step_iter += 1

        # Avançar o tempo
        t = fmu_.time

        terminate = integrator.complete_integration_step()
        if terminate:
            print("Ops!!!")
            exit(1)

        integrator.update_history()

        # Armazenando de resultados
        time += [t]
        sol += [fmu_.get_real(vref)]
        its.append(step_iter)

        active_event_mode = integrator.enter_event_handling()
        if active_event_mode:
            # Armazenando de resultados após eventos
            time += [t]
            sol += [fmu_.get_real(vref)]
            its.append(step_iter)
            integrator.exit_event_handling()

        pbar.update(dt)

    pbar.close()

    solv = np.array(sol)

    fig = plt.figure(figsize=(10, 5))
    ax = fig.subplots(nrows=4, sharex=True)
    ax[0].grid(ls=':')
    ax[0].plot(time, solv[:, 0] - solv[:, 3], label='$\delta_{14}(t)$', markevery=int(len(time)/15))
    ax[0].plot(time, solv[:, 1] - solv[:, 3], label='$\delta_{24}(t)$', markevery=int(len(time) / 15))
    ax[0].plot(time, solv[:, 2] - solv[:, 3], label='$\delta_{34}(t)$', markevery=int(len(time) / 15))
    ax[0].set_ylabel('$\delta$ [rad]')
    ax[0].legend()

    ax[1].grid(ls=':')
    ax[1].plot(time, solv[:, 4], '-bo', label='$E_{fd}(t)$', markevery=int(len(time)/15))
    # ax[1].plot(t_, efd_, '-rs', label='$E_{fd}(t) (mat)$', markevery=int(len(t_) / 10))
    ax[1].set_ylabel('$E_{fd}(t)$ [pu]')
    ax[1].legend()

    ax[2].grid(ls=':')
    ax[2].plot(time, solv[:, 5], '-bo', label='$V_{8}(t)$', markevery=int(len(time)/15))
    ax[2].set_ylabel('$V_{8}(t)$ [pu]')
    ax[2].legend()

    ax[3].grid(ls=':')
    ax[3].plot(time, its, '-bo', label='iterations', markevery=int(len(time) / 15))
    ax[3].set_ylabel(u'iterations')
    ax[3].legend(loc='upper right')

