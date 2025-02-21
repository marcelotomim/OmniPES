within OmniPES.Circuit.Interfaces;

connector NegativePin
  import Modelica.Units.SI;
  SI.ComplexPerUnit v(re(start = 1.0), im(start = 0.0)) "Negative node voltage";
  flow SI.ComplexPerUnit i(re(start = 1e-6), im(start = 1e-6)) "Sum of currents flowing into node";
  annotation(
    defaultComponentName = "pin_n",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Text(origin = {0, 70}, textColor = {26, 95, 180}, extent = {{-150, 30}, {150, -30}}, textString = "%name")}));
end NegativePin;