within OmniPES.SteadyState.Sources;

model PVSource_Qlim_discrete
  extends Interfaces.Partial_VSource_Qlim_discrete(S(re(start = Psp/data.Sbase), im(start = 0)));
equation
  S.re = (Psp + dpsp)/data.Sbase;
  annotation( Icon(graphics = {Text(visible=useExternalVoltageSpec,origin = {30, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "V"),Text(visible=useExternalPowerSpec, origin = {-60, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "P"), Text(origin = {1, 80}, rotation = 180, extent = {{-97, 28}, {100, -19}}, textString = "PV
Qlim", fontSize = 8, horizontalAlignment = TextAlignment.Right)}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end PVSource_Qlim_discrete;