within OmniPES.Transient.Loads;

model ZIPLoad
   extends Interfaces.Partial_ZIPLoad;
equation
dp = 0;
dq = 0;
annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end ZIPLoad;