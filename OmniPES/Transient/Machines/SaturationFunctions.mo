within OmniPES.Transient.Machines;

package SaturationFunctions model
  Exponential_2
  extends OmniPES.Transient.Machines.Interfaces.PartialSaturationFunction;
    import Modelica.Math.exp;
    parameter Real A = 0.015;
    parameter Real B = 9.60;
    parameter Real C = 0.90;
  equation
    y = A*exp(B*(u - C));
    annotation(
      Icon(graphics = {Line(origin = {-7.86, -28.86}, points = {{-72.1371, -51.1371}, {-32.1371, -51.1371}, {19.8629, -45.1371}, {59.8629, 8.8629}, {79.8629, 100.863}}, color = {0, 0, 255}, thickness = 1, smooth = Smooth.Bezier)}));  end Exponential_2
  ;
end SaturationFunctions;