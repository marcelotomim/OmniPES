within OmniPES.SteadyState.Sources;

model PVSource_Qlim_discrete
  extends Interfaces.Partial_VSource_Qlim_discrete(S(re(start = Psp/data.Sbase), im(start = 0)));
equation
  S.re = (Psp + dpsp)/data.Sbase;
  annotation( Icon(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "PV
Qlim", horizontalAlignment = TextAlignment.Left)}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end PVSource_Qlim_discrete;