within OmniPES.SteadyState.Examples.IEEE_ACCESS_2025;

model tutorial_system_discrete
  extends tutorial_system_sigmoid(redeclare OmniPES.SteadyState.Sources.VTHSource_Qlim_discrete G1, redeclare OmniPES.SteadyState.Sources.PVSource_Qlim_discrete G2);
  annotation(
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001),
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS_V,LOG_STATS,LOG_STATS_V", s = "dassl", variableFilter = ".*"),
  Documentation(info="<html><body>TODO</body></html>"));
end tutorial_system_discrete;