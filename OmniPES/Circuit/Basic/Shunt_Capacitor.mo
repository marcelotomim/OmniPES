within OmniPES.Circuit.Basic;

model Shunt_Capacitor
  import Modelica.Units.SI;
  outer SystemData data;
  parameter SI.ReactivePower NominalPower(displayUnit="Mvar");
  extends Circuit.Basic.ShuntAdmittance(redeclare final parameter SI.PerUnit g = 0, redeclare final parameter SI.PerUnit b = NominalPower/data.Sbase);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {150, 100}}), graphics = {Line(origin = {-21.0002, -2.2362e-05}, points = {{-13, 0}, {13, 0}}), Line(origin = {20.9998, -2.2362e-05}, points = {{-13, 0}, {13, 0}}), Line(origin = {-8.00024, -3.00002}, points = {{0, 23}, {0, -17}}), Line(origin = {7.99976, -3.00002}, points = {{0, 23}, {0, -17}}), Text(origin = {160, 0}, rotation = 90, extent = {{-140, 30}, {140, -30}}, textString = "%NominalPower", fontSize = 8)}),
  Diagram(coordinateSystem(extent = {{-100, -100}, {150, 100}}, initialScale = 0.1)));
end Shunt_Capacitor;