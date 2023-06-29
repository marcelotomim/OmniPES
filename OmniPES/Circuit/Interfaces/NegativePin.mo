within OmniPES.Circuit.Interfaces;

connector NegativePin
  Units.CPerUnit v(re(start = 1.0), im(start = 0.0)) "Negative node voltage";
  flow Units.CPerUnit i(re(start = 1e-6), im(start = 1e-6)) "Sum of currents flowing into node";
  annotation(
    defaultComponentName = "pin_n",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, 110}, {160, 50}}, textString = "%name", lineColor = {0, 0, 255})}));
end NegativePin;