
from ode_solver import Integrator


class ModifiedEuler(Integrator):

    def __init__(self, initialized_fmu, h, tend, atol=1e-5, rtol=1e-2):
        super().__init__(initialized_fmu, h, tend, atol=1e-5, rtol=1e-2)
        self.hist = self.x_prev + 0.5 * self.dt * self.der_x_prev

    def predictor(self):
        self.x = self.x_prev + self.dt * self.der_x_prev
        self.fmu.continuous_states = self.x[:]

    def step(self):
        # Estimate states by means of the trapezoidal rule
        self.der_x = self.fmu.get_derivatives()
        self.x = self.hist + 0.5 * self.dt * self.der_x
        self.fmu.continuous_states = self.x[:]

    def update_history(self):
        self.x_prev = self.x[:]
        self.der_x_prev = self.der_x[:]
        self.hist = self.x_prev + 0.5 * self.dt * self.der_x_prev
