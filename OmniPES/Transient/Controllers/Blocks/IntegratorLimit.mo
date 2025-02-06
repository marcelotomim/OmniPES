within OmniPES.Transient.Controllers.Blocks;

model IntegratorLimit
  extends Modelica.Blocks.Interfaces.SISO;
  import Modelica.Units.SI;
  parameter SI.PerUnit k "constant gain";
  parameter SI.PerUnit ymax "maximum limit";
  parameter SI.PerUnit ymin "minimum limit";
  Boolean is_normal(start=true) "normal operation state";
  Boolean hit_max(start=false) "maximum limit operation state"; 
  Boolean hit_min(start=false) "minimum limit operation state"; 
  Real e "signal to be integrated";
initial equation
der(y) = 0;
equation
  e = k*u;
  der(y) = if is_normal then e else 0;
algorithm
  hit_max := (y > ymax) or ((hit_max) and e > 0);
  hit_min := (y < ymin) or ((hit_min) and e < 0);
  is_normal := (y >= ymin and y <= ymax) or ((hit_max) and e < 0) or ((hit_min) and e > 0);
  
  annotation(
    Diagram,
  Icon(graphics = {Line(origin = {1, 1}, points = {{-85, 1}, {85, 1}}, thickness = 0.5), Text(origin = {0, 50}, extent = {{-100, 40}, {100, -40}}, textString = "k"), Text(origin = {0, -50}, extent = {{-100, 40}, {100, -40}}, textString = "s"), Line(origin = {32.21, -9}, points = {{-160, -110}, {-100, -110}, {60, 130}, {100, 130}}, thickness = 0.5)}));
 end IntegratorLimit;