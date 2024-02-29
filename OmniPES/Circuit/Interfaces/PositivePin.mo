within OmniPES.Circuit.Interfaces;

connector PositivePin
  Modelica.Units.SI.ComplexPerUnit v(re(start = 1.0), im(start = 0.0)) "Positive node voltage";
  flow Modelica.Units.SI.ComplexPerUnit i(re(start = 1e-6), im(start = 1e-6)) "Sum of currents flowing into node";
  annotation(
    defaultComponentName = "pin_p",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-160, 110}, {40, 50}}, lineColor = {0, 0, 255}, textString = "%name")}));
end PositivePin;