within OmniPES.Circuit.Basic;

model Shunt_Reactor
  outer SystemData data;
  parameter Units.ReactivePower NominalPower;
  extends Circuit.Basic.ShuntAdmittance(g = 1e-5, b = -NominalPower/data.Sbase);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end Shunt_Reactor;