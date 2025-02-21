within OmniPES.SteadyState.Sources;

model PVSource_Qlim_sigmoid
  extends Interfaces.Partial_VSource_Qlim_sigmoid(S(re(start = Psp/data.Sbase), im(start = 0)));
equation
  S.re = (Psp + dpsp)/data.Sbase;
annotation(
    Icon(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "PV
Qlim", horizontalAlignment = TextAlignment.Left)}));
end PVSource_Qlim_sigmoid;