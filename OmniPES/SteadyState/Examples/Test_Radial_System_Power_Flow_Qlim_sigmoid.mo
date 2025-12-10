within OmniPES.SteadyState.Examples;

model Test_Radial_System_Power_Flow_Qlim_sigmoid
  extends Test_Radial_System_Power_Flow_Qlim_discrete(redeclare OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid pVSource_Qlim);
  annotation(
    experiment(StartTime = 0, StopTime = 6, Tolerance = 1e-6, Interval = 0.01),
      Documentation(info="<html>
  <h3>Radial System with Sigmoid Reactive Power Limits (PVSource_Qlim_sigmoid)</h3>

  <p>
  This model is derived from the discrete-limit variant 
  <a href=\"modelica://OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow_Qlim_discrete\">Test_Radial_System_Power_Flow_Qlim_discrete</a>,
  and changes only the reactive power limits handling by using smooth (sigmoid) enforcement in 
  <a href=\"modelica://OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid\">PVSource_Qlim_sigmoid.mo</a>. It demonstrates how the object-oriented
  nature of Modelica enables building new test cases by redeclaring sources and reusing the same network topology, parameters, and signals with minimal modifications.
  </p>
  <p>
  See also the discrete counterpart: 
  <a href=\"modelica://OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow_Qlim_discrete\">Test_Radial_System_Power_Flow_Qlim_discrete</a>.
  </p>
  </body></html>"));

end Test_Radial_System_Power_Flow_Qlim_sigmoid;