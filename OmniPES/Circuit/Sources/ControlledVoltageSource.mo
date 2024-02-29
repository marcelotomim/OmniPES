within OmniPES.Circuit.Sources;

model ControlledVoltageSource
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import OmniPES.Math.polar2cart;
  Modelica.Units.SI.ComplexPerUnit S;
  Modelica.ComplexBlocks.Interfaces.ComplexInput u annotation(
    Placement(visible = true, transformation(origin = {-62, -48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {6, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  v = u;
  S = -v*conj(i);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end ControlledVoltageSource;