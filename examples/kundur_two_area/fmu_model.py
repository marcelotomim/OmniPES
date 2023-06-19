
from pyfmi.fmi import FMUModelME2
from modified_euler import ModifiedEuler
import numpy as np

class Generator():

    def __init__(self, gen_data, tf = 10, dt=1e-3, atol=1e-4, rtol=1e-3, MVAb=100.):
        self.data = gen_data.copy()
        self.MVAb = MVAb
        self.fmu = FMUModelME2(f'./FMU/OmniPES.CoSimulation.Examples.Generic_Machine_Kundur.fmu', log_level=0)

        self.fmu.instantiate()
        self.fmu.setup_experiment(tolerance=1e-6, start_time=0, stop_time=tf + dt)

        self.integrator = None
        self.has_x_converged = False

        self.dt = dt
        self.tf = tf
        self.rtol = rtol
        self.atol = atol

        self.Vt = complex(0, 0)
        self.Inorton = complex(0, 0)
        self.Zeq = complex(0, 0)

        self.variables = ["SM.inertia.delta",
                          "SM.inertia.omega",
                          "SM.electrical.Pe",
                          "SM.electrical.Efd"]
        self.vref = [self.fmu.get_variable_valueref(v) for v in self.variables]

    def initialize(self, Vt, St):

        self.fmu.enter_initialization_mode()
        self.fmu.set("data.Sbase", self.MVAb)

        for key, val in self.data.items():
            self.fmu.set(f"gen1_data.{key}", val)

        self.Zeq = self.fmu.get("gen1_data.convData.Ra")[0] + 1j * self.fmu.get("gen1_data.convData.X2d")[0]

        self.fmu.set("gen1_specs.Pesp", St.real*self.MVAb)
        self.fmu.set("gen1_specs.Qesp", St.imag*self.MVAb)
        self.fmu.set("Vr", Vt.real)
        self.fmu.set("Vi", Vt.imag)

        self.fmu.exit_initialization_mode()

        self.Vt = Vt
        self.calc_norton()

        self.init_integrator()

        self.sol = [self.fmu.get_real(self.vref)]

    def init_integrator(self):
        if self.integrator == None:
            self.integrator = ModifiedEuler(self.fmu, self.dt, self.tf, atol=self.atol, rtol=self.rtol)

    def enter_continuous_time_mode(self):
        self.fmu.enter_continuous_time_mode()

    def complete_integration_step(self):
        return self.integrator.complete_integration_step()

    def set_time(self, t):
        self.fmu.time = t

    def set_Vt(self, Vt):
        self.Vt = Vt
        self.fmu.set("Vr", Vt.real)
        self.fmu.set("Vi", Vt.imag)

    def calc_norton(self):

        # Cálculo da interface com a rede (Eq. de Norton)
        Iar = -self.fmu.get("SM.electrical.terminal.i.re")[0]
        Iai = -self.fmu.get("SM.electrical.terminal.i.im")[0]
        Ia = Iar + 1j * Iai
        E2 = self.Vt + self.Zeq * Ia
        self.Inorton = E2 / self.Zeq

    def step(self):
        self.integrator.step()
        self.has_x_converged = self.integrator.has_x_converged

    def update_history(self):
        self.integrator.update_history()

    def store_results(self):
        self.sol += [self.fmu.get_real(self.vref)]

    def process_results(self):
        self.results = np.array(self.sol)