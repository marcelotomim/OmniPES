within OmniPES.SteadyState.Sources;

model PVSource_Qlim_sigmoid
  extends Interfaces.Partial_VSource_Qlim_sigmoid(S(re(start = Psp/data.Sbase), im(start = 0)));
equation
  S.re = (Psp + dpsp)/data.Sbase;
  annotation( Icon(graphics = {Text(visible=useExternalVoltageSpec,origin = {30, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "V"),Text(visible=useExternalPowerSpec, origin = {-60, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "P"), Text(origin = {70, 54}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PV\nQlim")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end PVSource_Qlim_sigmoid;