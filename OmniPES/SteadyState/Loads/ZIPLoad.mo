within OmniPES.SteadyState.Loads;

model ZIPLoad
  extends Interfaces.Partial_ZIPLoad;
equation
dp = 0;
dq = 0;
  annotation(
    Icon(graphics = {Text(origin = {1, 2.84217e-14}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}));
end ZIPLoad;