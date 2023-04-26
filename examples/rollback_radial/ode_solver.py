
import numpy as np
from abc import ABC, abstractmethod


class Integrator(ABC):

    def __init__(self, initialized_fmu, h, tend, atol=1e-5, rtol=1e-2):
        self.fmu = initialized_fmu
        self.dt = h
        self.tf = tend
        self.x_prev = self.fmu.continuous_states[:]
        self.der_x_prev = self.fmu.get_derivatives()[:]
        self.x = np.zeros_like(self.fmu.continuous_states)
        self.der_x = np.zeros_like(self.fmu.continuous_states)

        self.event_ind = self.fmu.get_event_indicators()
        self.event_ind_new = self.event_ind
        self.step_event = False
        self.time_event = False
        self.state_event = False
        self.Tnext = self.tf
        self.rtol = rtol
        self.atol = atol

    @abstractmethod
    def predictor(self):
        pass

    @abstractmethod
    def step(self):
        pass

    @abstractmethod
    def update_history(self):
        pass

    def check_convergence(self):
        # Check absolute error
        abs_error = np.abs(self.fmu.continuous_states - self.x)
        abs_convergence = np.max(abs_error) < self.atol

        # Check relative error
        rel_error = abs_error - self.rtol * np.abs(self.fmu.continuous_states)
        rel_convergence = np.max(rel_error) < 1e-10

        # Save computed states
        self.fmu.continuous_states = self.x[:]

        return abs_convergence and rel_convergence

    def complete_integration_step(self):
        t = self.fmu.time

        # Get the event indicators at t = time
        self.step_event, terminate = self.fmu.completed_integrator_step()

         # Check for time and state events
        self.time_event = abs(t - self.Tnext) <= 1.e-10
        self.event_ind_new = self.fmu.get_event_indicators()
        self.state_event = True if True in ((self.event_ind_new > 0.0) != (self.event_ind > 0.0)) else False

        return terminate

    def init_events(self):

        if len(self.event_ind) > 0:
            e_info = self.fmu.get_event_info()
            e_info.newDiscreteStatesNeeded = True
            # Event iteration
            while e_info.newDiscreteStatesNeeded:
                self.fmu.enter_event_mode()
                self.fmu.event_update()
                e_info = self.fmu.get_event_info()

    def enter_event_handling(self):

        active_event_mode = False
        if len(self.event_ind) > 0:

            # Event handling
            if self.step_event or self.time_event or self.state_event:

                self.fmu.enter_event_mode()
                active_event_mode = True
                e_info = self.fmu.get_event_info()
                e_info.newDiscreteStatesNeeded = True

                # Event iteration
                # while eInfo.newDiscreteStatesNeeded:
                #     self.fmu.event_update(intermediateResult=True)  # Stops after each event iteration
                #     eInfo = self.fmu.get_event_info()
                #
                #     # Retrieve solutions (if needed)
                #     if eInfo.newDiscreteStatesNeeded:
                #         # fmu_.get_real, get_integer, get_boolean,
                #         # get_string(valueref)
                #         pass
                self.fmu.event_update(intermediateResult=False)

        return active_event_mode

    def exit_event_handling(self):

        if len(self.event_ind) > 0:

            # Event handling
            e_info = self.fmu.get_event_info()
            if self.step_event or self.time_event or self.state_event:

                # Check if the event affected the state values and if so sets them
                # if eInfo.valuesOfContinuousStatesChanged:
                #     # self.x = fmu.continuous_states
                #     # self.der_x = fmu.get_derivatives()
                #     # v8 = fmu.get("bus8.V")[0]
                #     pass

                # Get new nominal values.
                # if eInfo.nominalsOfContinuousStatesChanged:
                #     atol = 0.01 * self.rtol * self.fmu.nominal_continuous_states

                # Check for new time event
                if e_info.nextEventTimeDefined:
                    self.Tnext = min(e_info.nextEventTime, self.tf)
                else:
                    self.Tnext = self.tf

                self.fmu.enter_continuous_time_mode()

            self.event_ind = self.event_ind_new
