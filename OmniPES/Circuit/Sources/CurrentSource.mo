within OmniPES.Circuit.Sources;

model CurrentSource
  extends Icons.Isource;
  extends Circuit.Interfaces.ShuntComponent;
  import OmniPES.Math.polar2cart;
  import Modelica.Units.NonSI;
  parameter Units.PerUnit magnitude = 0.0;
  parameter NonSI.Angle_deg angle = 0.0;
equation
  i = -polar2cart(magnitude, angle);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end CurrentSource;