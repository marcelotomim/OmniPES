within OmniPES.SteadyState.Examples;

model Test_Radial_System_Power_Flow_Qlim_sigmoid
  extends Test_Radial_System_Power_Flow_Qlim_discrete(redeclare OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid pVSource_Qlim);
  annotation(
    experiment(StartTime = 0, StopTime = 6, Tolerance = 1e-6, Interval = 0.01));

end Test_Radial_System_Power_Flow_Qlim_sigmoid;