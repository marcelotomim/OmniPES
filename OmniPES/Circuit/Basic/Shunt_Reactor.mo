within OmniPES.Circuit.Basic;

model Shunt_Reactor
  import Modelica.Units.SI;
  outer SystemData data;
  parameter SI.ReactivePower NominalPower(displayUnit="Mvar");
  extends Circuit.Basic.ShuntAdmittance(redeclare final parameter SI.PerUnit g = 0, redeclare final parameter SI.PerUnit b = -NominalPower/data.Sbase);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end Shunt_Reactor;