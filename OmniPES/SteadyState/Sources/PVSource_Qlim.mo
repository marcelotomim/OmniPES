within OmniPES.SteadyState.Sources;

model PVSource_Qlim
  extends Interfaces.Partial_Source_Qlim(S(re(start = Psp/data.Sbase), im(start = 0)));
  parameter Units.ActivePower Psp;
equation
  S.re = Psp/data.Sbase;
  dvsp = 0;
  annotation(Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {70, 54}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PV")}));
end PVSource_Qlim;