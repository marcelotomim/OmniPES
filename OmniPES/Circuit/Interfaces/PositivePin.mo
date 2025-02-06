within OmniPES.Circuit.Interfaces;

connector PositivePin
  import Modelica.Units.SI;
  SI.ComplexPerUnit v(re(start = 1.0), im(start = 0.0)) "Positive node voltage";
  flow SI.ComplexPerUnit i(re(start = 1e-6), im(start = 1e-6)) "Sum of currents flowing into node";
  annotation(
    defaultComponentName = "pin_p",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Text(origin = {0, 72}, textColor = {26, 95, 180}, extent = {{-100, 30}, {100, -30}}, textString = "%name", fontSize = 8)}));
end PositivePin;