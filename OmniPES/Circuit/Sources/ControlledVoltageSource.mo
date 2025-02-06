within OmniPES.Circuit.Sources;

model ControlledVoltageSource
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import OmniPES.Math.polar2cart;
  Modelica.Units.SI.ComplexPerUnit S "generate apparent power";
  Modelica.ComplexBlocks.Interfaces.ComplexInput u annotation(
    Placement(transformation(origin = {-62, -48}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {75, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  v = u;
  S = -v*conj(i);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end ControlledVoltageSource;