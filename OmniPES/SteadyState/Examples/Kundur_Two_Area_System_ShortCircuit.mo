within OmniPES.SteadyState.Examples;

model Kundur_Two_Area_System_ShortCircuit
  inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
    Placement(visible = true, transformation(origin = {-25, 71}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus7 annotation(
    Placement(visible = true, transformation(origin = {-108, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus8 annotation(
    Placement(visible = true, transformation(origin = {-30, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.TLine tLine(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {-66, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine1(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine2(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {16, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine3(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {18, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus9 annotation(
    Placement(visible = true, transformation(origin = {64, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine4(Q = 0.175*10, r = 0.0001*10, x = 0.001*10) annotation(
    Placement(visible = true, transformation(origin = {88, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine5(Q = 0.175*25, r = 0.0001*25, x = 0.001*25) annotation(
    Placement(visible = true, transformation(origin = {132, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(visible = true, transformation(origin = {108, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus11 annotation(
    Placement(visible = true, transformation(origin = {154, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine6(Q = 0.175*10, r = 0.0001*10, x = 0.001*10) annotation(
    Placement(visible = true, transformation(origin = {-128, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine7(Q = 0.175*25, r = 0.0001*25, x = 0.001*25) annotation(
    Placement(visible = true, transformation(origin = {-168, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus5 annotation(
    Placement(visible = true, transformation(origin = {-196, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus6 annotation(
    Placement(visible = true, transformation(origin = {-150, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance trafo(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {-214, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {176, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {-168, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {130, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-230, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-186, -6}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {198, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus4 annotation(
    Placement(visible = true, transformation(origin = {150, -18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource G3(angle = 0.0, magnitude = 1.00) annotation(
    Placement(visible = true, transformation(origin = {262, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource G4(angle = 0.0, magnitude = 1.00) annotation(
    Placement(visible = true, transformation(origin = {212, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource G1(angle = 0.0, magnitude = 1.00) annotation(
    Placement(visible = true, transformation(origin = {-280, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Sources.VoltageSource G2(angle = 0.0, magnitude = 1.00) annotation(
    Placement(visible = true, transformation(origin = {-250, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Sources.CurrentSource currentSource(magnitude = 0) annotation(
    Placement(visible = true, transformation(origin = {-96, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance(r = 0.0025*100/900, x = 0.25*100/900) annotation(
    Placement(visible = true, transformation(origin = {-216, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance1(r = 0.0025*100/900, x = 0.25*100/900) annotation(
    Placement(visible = true, transformation(origin = {-248, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance2(r = 0.0025*100/900, x = 0.25*100/900) annotation(
    Placement(visible = true, transformation(origin = {226, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance3(r = 0.0025*100/900, x = 0.25*100/900) annotation(
    Placement(visible = true, transformation(origin = {176, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor(NominalPower = 200) annotation(
    Placement(visible = true, transformation(origin = {-118, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor1(NominalPower = 350) annotation(
    Placement(visible = true, transformation(origin = {68, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(tLine.p, bus7.p) annotation(
    Line(points = {{-77, 27}, {-88, 27}, {-88, 20}, {-108, 20}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine2.n, bus9.p) annotation(
    Line(points = {{27, 27}, {56, 27}, {56, 18}, {64, 18}, {64, 16}}, color = {0, 0, 255}));
  connect(tLine4.n, bus10.p) annotation(
    Line(points = {{99, 15}, {108, 15}, {108, 14}}, color = {0, 0, 255}));
  connect(tLine5.p, bus10.p) annotation(
    Line(points = {{121, 15}, {108, 15}, {108, 14}}, color = {0, 0, 255}));
  connect(bus9.p, tLine4.p) annotation(
    Line(points = {{64, 16}, {76, 16}, {76, 15}, {77, 15}}, color = {0, 0, 255}));
  connect(tLine5.n, bus11.p) annotation(
    Line(points = {{143, 15}, {154, 15}, {154, 14}}, color = {0, 0, 255}));
  connect(tLine6.n, bus7.p) annotation(
    Line(points = {{-117, 17}, {-108, 17}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine6.p, bus6.p) annotation(
    Line(points = {{-139, 17}, {-150, 17}, {-150, 16}}, color = {0, 0, 255}));
  connect(tLine7.n, bus6.p) annotation(
    Line(points = {{-157, 19}, {-150, 19}, {-150, 16}}, color = {0, 0, 255}));
  connect(tLine7.p, bus5.p) annotation(
    Line(points = {{-179, 19}, {-196, 19}, {-196, 16}}, color = {0, 0, 255}));
  connect(trafo.n, bus5.p) annotation(
    Line(points = {{-204, 18}, {-196, 18}, {-196, 16}}, color = {0, 0, 255}));
  connect(bus11.p, impedance.p) annotation(
    Line(points = {{154, 14}, {166, 14}}, color = {0, 0, 255}));
  connect(impedance1.n, bus6.p) annotation(
    Line(points = {{-158, -8}, {-158, 0}, {-150, 0}, {-150, 16}}, color = {0, 0, 255}));
  connect(impedance2.p, bus10.p) annotation(
    Line(points = {{120, -20}, {108, -20}, {108, 14}}, color = {0, 0, 255}));
  connect(trafo.p, bus1.p) annotation(
    Line(points = {{-224, 18}, {-230, 18}}, color = {0, 0, 255}));
  connect(impedance1.p, bus2.p) annotation(
    Line(points = {{-178, -8}, {-186, -8}}, color = {0, 0, 255}));
  connect(impedance2.n, bus4.p) annotation(
    Line(points = {{140, -20}, {150, -20}}, color = {0, 0, 255}));
  connect(impedance.n, bus3.p) annotation(
    Line(points = {{186, 14}, {198, 14}}, color = {0, 0, 255}));
  connect(tLine1.p, bus7.p) annotation(
    Line(points = {{-77, 1}, {-92, 1}, {-92, 12}, {-108, 12}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus8.p) annotation(
    Line(points = {{-54, 28}, {-40, 28}, {-40, 20}, {-30, 20}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine1.n, bus8.p) annotation(
    Line(points = {{-54, 2}, {-40, 2}, {-40, 12}, {-30, 12}, {-30, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine2.p, bus8.p) annotation(
    Line(points = {{6, 28}, {-18, 28}, {-18, 20}, {-30, 20}, {-30, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine3.p, bus8.p) annotation(
    Line(points = {{8, -2}, {-14, -2}, {-14, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine3.n, bus9.p) annotation(
    Line(points = {{30, -2}, {54, -2}, {54, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(currentSource.p, bus7.p) annotation(
    Line(points = {{-96, -20}, {-96, 16}, {-108, 16}}, color = {0, 0, 255}));
  connect(G2.p, seriesImpedance.p) annotation(
    Line(points = {{-240, -8}, {-226, -8}}, color = {0, 0, 255}));
  connect(seriesImpedance.n, bus2.p) annotation(
    Line(points = {{-206, -8}, {-186, -8}}, color = {0, 0, 255}));
  connect(G1.p, seriesImpedance1.p) annotation(
    Line(points = {{-270, 18}, {-258, 18}}, color = {0, 0, 255}));
  connect(seriesImpedance1.n, bus1.p) annotation(
    Line(points = {{-238, 18}, {-230, 18}}, color = {0, 0, 255}));
  connect(G3.p, seriesImpedance2.p) annotation(
    Line(points = {{252, 14}, {236, 14}}, color = {0, 0, 255}));
  connect(seriesImpedance2.n, bus3.p) annotation(
    Line(points = {{216, 14}, {198, 14}}, color = {0, 0, 255}));
  connect(G4.p, seriesImpedance3.p) annotation(
    Line(points = {{202, -20}, {185.8, -20}}, color = {0, 0, 255}));
  connect(seriesImpedance3.n, bus4.p) annotation(
    Line(points = {{166, -20}, {150, -20}}, color = {0, 0, 255}));
  connect(shunt_Capacitor.p, bus7.p) annotation(
    Line(points = {{-118, -16}, {-118, 4}, {-108, 4}, {-108, 16}}, color = {0, 0, 255}));
  connect(shunt_Capacitor1.p, bus9.p) annotation(
    Line(points = {{68, -12}, {64, -12}, {64, 16}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
end Kundur_Two_Area_System_ShortCircuit;