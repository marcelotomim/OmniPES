within OmniPES.Circuit.Interfaces;

connector PositivePin
  import Modelica.Units.SI;
  SI.ComplexPerUnit v(re(start = 1.0), im(start = 0.0)) "Positive node voltage";
  flow SI.ComplexPerUnit i "Sum of currents flowing into node";
  annotation(
    Documentation(info = "<html><p>Positive terminal connector for AC network elements in OmniPES. Carries complex per-unit voltage <code>v</code> and flow current <code>i</code> (positive sign into the connector). </p></html>"),
    defaultComponentName = "pin_p",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Text(origin = {0, 70}, textColor = {26, 95, 180}, extent = {{-150, 30}, {150, -30}}, textString = "%name")}));
end PositivePin;