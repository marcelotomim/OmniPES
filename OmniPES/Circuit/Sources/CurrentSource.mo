within OmniPES.Circuit.Sources;

model CurrentSource
  extends Icons.Isource;
  extends Circuit.Interfaces.ShuntComponent;
  import OmniPES.Math.polar2cart;
  import Modelica.Units.SI;
  parameter SI.PerUnit magnitude = 0.0 "current magnitude";
  parameter SI.Angle angle(displayUnit="deg") = 0.0 "current phase";
equation
  i = -polar2cart(magnitude, angle);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end CurrentSource;