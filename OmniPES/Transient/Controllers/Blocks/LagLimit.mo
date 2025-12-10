within OmniPES.Transient.Controllers.Blocks;

model LagLimit
  extends Modelica.Blocks.Interfaces.SISO(y(start=1));
  import Modelica.Units.SI;
  parameter SI.PerUnit k "constant gain";
  parameter SI.Time T "time constant";
  parameter SI.PerUnit ymax "maximum limit";
  parameter SI.PerUnit ymin "minimum limit";
  Boolean is_normal(start=true) "normal operation state";
  Boolean hit_max(start=false) "maximum limit operation state"; 
  Boolean hit_min(start=false) "minimum limit operation state"; 
  Real e "signal to be integrated";
initial equation
der(y) = 0;
equation
  T*e = k*u - y;
  der(y) = if is_normal then e else 0;
algorithm
  hit_max := (y > ymax) or (pre(hit_max) and e > 0);
  hit_min := (y < ymin) or (pre(hit_min) and e < 0);
  is_normal := (y >= ymin and y <= ymax) or (hit_max and e < 0) or (hit_min and e > 0);
  annotation(
    Diagram,
  Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid,lineThickness = 0.5, extent = {{-98, 98}, {98, -98}}), Line(origin = {1, 1}, points = {{-85, 1}, {85, 1}}, thickness = 0.5), Text(origin = {0, 50}, extent = {{-100, 40}, {100, -40}}, textString = "k"), Text(origin = {0, -50}, extent = {{-100, 40}, {100, -40}}, textString = "1+sT"), Line(origin = {32.21, -9}, points = {{-160, -110}, {-100, -110}, {60, 130}, {100, 130}}, thickness = 0.5)}));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

 end LagLimit;