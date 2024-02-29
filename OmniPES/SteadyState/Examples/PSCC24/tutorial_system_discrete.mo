within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system_discrete
  extends tutorial_system(redeclare OmniPES.SteadyState.Sources.VTHSource_Qlim_discrete G1, redeclare OmniPES.SteadyState.Sources.PVSource_Qlim_discrete G2);
  annotation(
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-6, Interval = 0.001));
end tutorial_system_discrete;