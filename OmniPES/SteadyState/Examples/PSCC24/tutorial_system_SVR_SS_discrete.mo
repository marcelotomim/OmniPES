within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system_SVR_SS_discrete
  extends tutorial_system_SVR_SS(redeclare OmniPES.SteadyState.Sources.VTHSource_Qlim_discrete G1, redeclare OmniPES.SteadyState.Sources.PVSource_Qlim_discrete G2);
  annotation(
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system_SVR_SS_discrete;