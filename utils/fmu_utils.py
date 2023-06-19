
import numpy as np

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
    voltages = model.get_input_list()
    currents = model.get_output_list()

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

