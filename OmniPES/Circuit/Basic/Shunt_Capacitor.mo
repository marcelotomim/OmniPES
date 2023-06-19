within OmniPES.Circuit.Basic;

model Shunt_Capacitor
  parameter OmniPES.Units.ReactivePower NominalPower;
  outer OmniPES.SystemData data;
  extends OmniPES.Circuit.Basic.ShuntAdmittance(g = 0, b = NominalPower/data.Sbase);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(origin = {-21.0002, -2.2362e-05}, points = {{-13, 0}, {13, 0}}), Line(origin = {20.9998, -2.2362e-05}, points = {{-13, 0}, {13, 0}}), Line(origin = {-8.00024, -3.00002}, points = {{0, 23}, {0, -17}}), Line(origin = {7.99976, -3.00002}, points = {{0, 23}, {0, -17}})}));
end Shunt_Capacitor;