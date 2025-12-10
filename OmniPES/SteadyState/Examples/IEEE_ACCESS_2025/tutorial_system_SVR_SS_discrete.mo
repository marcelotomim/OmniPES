within OmniPES.SteadyState.Examples.IEEE_ACCESS_2025;

model tutorial_system_SVR_SS_discrete
  extends tutorial_system_SVR_SS_sigmoid(redeclare OmniPES.SteadyState.Sources.VTHSource_Qlim_sigmoid G1, redeclare OmniPES.SteadyState.Sources.PVSource_Qlim_discrete G2);
  annotation(
    experiment(StartTime = 0, StopTime = 119.5, Tolerance = 1e-06, Interval = 0.001),
    Documentation(info="<html><body>TODO</body></html>"));
end tutorial_system_SVR_SS_discrete;