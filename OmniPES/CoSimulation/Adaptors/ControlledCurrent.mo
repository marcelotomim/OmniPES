within OmniPES.CoSimulation.Adaptors;

model ControlledCurrent
  extends OmniPES.Circuit.Interfaces.ShuntComponent;
  Modelica.Blocks.Interfaces.RealInput Ir annotation(
    Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput Ii annotation(
    Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput Vr annotation(
    Placement(visible = true, transformation(origin = {-112, -6}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput Vi annotation(
    Placement(visible = true, transformation(origin = {-112, -20}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Modelica.Blocks.Interfaces.RealOutput dVr annotation(
  //    Placement(visible = true, transformation(origin = {-112, -66}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //Modelica.Blocks.Interfaces.RealOutput dVi annotation(
  //    Placement(visible = true, transformation(origin = {-112, -80}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  v = Complex(Vr, Vi);
  i = Complex(Ir, Ii);
//dVr = der(v.re);
//dVi = der(v.im);
  annotation(
    Icon(graphics = {Ellipse(extent = {{-50, 50}, {50, -50}}, endAngle = 360), Line(origin = {-75, 0}, points = {{25, 0}, {-25, 0}, {-25, 0}}), Line(origin = {65, 0}, points = {{-15, 0}, {15, 0}, {15, 0}}), Rectangle(origin = {-0.00942045, 0.0664522}, extent = {{-100.009, 100.066}, {100.009, -100.066}}), Line(points = {{40, 0}, {-40, 0}}, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10), Line(origin = {81.5, 0}, points = {{-1.2, 20}, {-1.2, -20}}), Line(origin = {87.5, 0}, points = {{-1.2, 15}, {-1.2, -15}}), Line(origin = {93.5, 0}, points = {{-1.2, 10}, {-1.2, -10}})}));
end ControlledCurrent;