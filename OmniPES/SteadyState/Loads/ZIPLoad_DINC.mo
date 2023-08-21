within OmniPES.SteadyState.Loads;

model ZIPLoad_DINC
  extends Interfaces.Partial_ZIPLoad;
  parameter Real kp = 1 "MW/s";
  parameter Real kq = 1 "Mvar/s";
  parameter Units.ActivePower DPmax = 100;
  parameter Units.ReactivePower DQmax = 100;
initial equation
  dp = 0;
  dq = 0;
equation
  der(dp) = if dp <= DPmax then kp else 0;
  der(dq) = if dq <= DQmax then kq else 0;
  annotation(
    Icon(graphics = {Text(origin = {1, 2.84217e-14}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}),
  experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-6, Interval = 1));
end ZIPLoad_DINC;