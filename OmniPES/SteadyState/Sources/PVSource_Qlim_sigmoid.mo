within OmniPES.SteadyState.Sources;

model PVSource_Qlim_sigmoid
  extends Interfaces.Partial_VSource_Qlim_sigmoid(S(re(start = Psp/data.Sbase), im(start = 0)));
equation
  S.re = (Psp + dpsp)/data.Sbase;
annotation(
    Icon(graphics = {Text(origin = {1, 80}, rotation = 180, extent = {{-97, 28}, {100, -19}}, textString = "PV
Qlim", fontSize = 8, horizontalAlignment = TextAlignment.Right)}));
end PVSource_Qlim_sigmoid;