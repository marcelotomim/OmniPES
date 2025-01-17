within OmniPES.Transient.Examples;

model IEEE9bus_pf
  Circuit.Interfaces.Bus B2 annotation(
    Placement(transformation(origin = {-180, 119}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Interfaces.Bus B7 annotation(
    Placement(transformation(origin = {-100, 119}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Interfaces.Bus B8 annotation(
    Placement(transformation(origin = {0, 119}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Interfaces.Bus B9 annotation(
    Placement(transformation(origin = {100, 119}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Interfaces.Bus B3 annotation(
    Placement(transformation(origin = {180, 119}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Interfaces.Bus B5 annotation(
    Placement(transformation(origin = {-90, 21}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Circuit.Interfaces.Bus B6 annotation(
    Placement(transformation(origin = {90, 21}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Circuit.Interfaces.Bus B4 annotation(
    Placement(transformation(origin = {-1, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Circuit.Interfaces.Bus B1 annotation(
    Placement(transformation(origin = {-1, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Circuit.Basic.TLine L_7_8(r = 0.0085, x = 0.072, Q = 2*7.45)  annotation(
    Placement(transformation(origin = {-50, 114}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Basic.TLine L_8_9(r = 0.0119, x = 0.1008, Q = 2*10.45)  annotation(
    Placement(transformation(origin = {50, 114}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Basic.TLine L_7_5(r = 0.032, x = 0.161, Q = 2*15.3)  annotation(
    Placement(transformation(origin = {-85, 61}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Circuit.Basic.TLine L_6_9(r = 0.039, x = 0.170, Q = 2*17.9)  annotation(
    Placement(transformation(origin = {87, 61}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Circuit.Basic.TLine L_4_5(r = 0.010, x = 0.085, Q = 2*8.8)  annotation(
    Placement(transformation(origin = {-87, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Circuit.Basic.TLine L_4_6(r = 0.017, x = 0.092, Q = 2*7.9)  annotation(
    Placement(transformation(origin = {87, -14}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  Circuit.Basic.TwoWindingTransformer tf_2(x = 0.0625)  annotation(
    Placement(transformation(origin = {-140, 117}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Basic.TwoWindingTransformer tf_3(x = 0.0586)  annotation(
    Placement(transformation(origin = {140, 117}, extent = {{10, -10}, {-10, 10}})));
  Circuit.Basic.TwoWindingTransformer tf_1(x = 0.0576)  annotation(
    Placement(transformation(origin = {1, -79}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  inner SystemData data annotation(
    Placement(transformation(origin = {-223, -126}, extent = {{-30, -30}, {30, 30}})));
  Loads.ZIPLoad load_A(Psp = 125, Qsp = 50)  annotation(
    Placement(transformation(origin = {-125, -15}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  Loads.ZIPLoad load_B(Psp = 90, Qsp = 30) annotation(
    Placement(transformation(origin = {134, -16}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  Loads.ZIPLoad load_C(Psp = 100, Qsp = 35) annotation(
    Placement(transformation(origin = {0, 65}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  SteadyState.Sources.VTHSource G1(magnitude = 1.040)  annotation(
    Placement(transformation(origin = {1, -130}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  SteadyState.Sources.PVSource G2(Psp = 163, Vsp = 1.025)  annotation(
    Placement(transformation(origin = {-207, 117}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  SteadyState.Sources.PVSource G3(Psp = 85, Vsp = 1.025)  annotation(
    Placement(transformation(origin = {209, 116}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(tf_2.p, B2.p) annotation(
    Line(points = {{-151, 117}, {-180, 117}}, color = {0, 0, 255}));
  connect(tf_2.n, B7.p) annotation(
    Line(points = {{-129, 117}, {-100, 117}}, color = {0, 0, 255}));
  connect(L_7_8.p, B7.p) annotation(
    Line(points = {{-61, 117}, {-100, 117}}, color = {0, 0, 255}));
  connect(L_7_8.n, B8.p) annotation(
    Line(points = {{-39, 117}, {0, 117}}, color = {0, 0, 255}));
  connect(L_8_9.p, B8.p) annotation(
    Line(points = {{39, 117}, {0, 117}}, color = {0, 0, 255}));
  connect(L_8_9.n, B9.p) annotation(
    Line(points = {{61, 117}, {100, 117}}, color = {0, 0, 255}));
  connect(tf_3.n, B9.p) annotation(
    Line(points = {{129, 117}, {100, 117}}, color = {0, 0, 255}));
  connect(tf_3.p, B3.p) annotation(
    Line(points = {{151, 117}, {180, 117}}, color = {0, 0, 255}));
  connect(L_7_5.n, B7.p) annotation(
    Line(points = {{-88, 72}, {-88, 117}, {-100, 117}}, color = {0, 0, 255}));
  connect(L_7_5.p, B5.p) annotation(
    Line(points = {{-88, 50}, {-88, 21}}, color = {0, 0, 255}));
  connect(L_4_5.n, B5.p) annotation(
    Line(points = {{-90, -3}, {-88, -3}, {-88, 21}}, color = {0, 0, 255}));
  connect(L_4_5.p, B4.p) annotation(
    Line(points = {{-90, -25}, {-89, -25}, {-89, -35}, {1, -35}, {1, -48}}, color = {0, 0, 255}));
  connect(L_6_9.n, B9.p) annotation(
    Line(points = {{90, 72}, {91, 72}, {91, 117}, {100, 117}}, color = {0, 0, 255}));
  connect(L_6_9.p, B6.p) annotation(
    Line(points = {{90, 50}, {92, 50}, {92, 21}}, color = {0, 0, 255}));
  connect(L_4_6.n, B6.p) annotation(
    Line(points = {{90, -3}, {92, -3}, {92, 21}}, color = {0, 0, 255}));
  connect(L_4_6.p, B4.p) annotation(
    Line(points = {{90, -25}, {90, -36}, {1, -36}, {1, -48}}, color = {0, 0, 255}));
  connect(tf_1.p, B1.p) annotation(
    Line(points = {{1, -90}, {1, -108}}, color = {0, 0, 255}));
  connect(tf_1.n, B4.p) annotation(
    Line(points = {{1, -68}, {1, -48}}, color = {0, 0, 255}));
  connect(load_A.p, B5.p) annotation(
    Line(points = {{-125, 3}, {-125, 9}, {-88, 9}, {-88, 21}}, color = {0, 0, 255}));
  connect(load_B.p, B6.p) annotation(
    Line(points = {{134, 2}, {133, 2}, {133, 11}, {92, 11}, {92, 21}}, color = {0, 0, 255}));
  connect(load_C.p, B8.p) annotation(
    Line(points = {{0, 83}, {0, 117}}, color = {0, 0, 255}));
  connect(G1.p, B1.p) annotation(
    Line(points = {{1, -120}, {1, -108}}, color = {0, 0, 255}));
  connect(G2.p, B2.p) annotation(
    Line(points = {{-197, 117}, {-180, 117}}, color = {0, 0, 255}));
  connect(G3.p, B3.p) annotation(
    Line(points = {{199, 116}, {180, 116}, {180, 117}}, color = {0, 0, 255}));

annotation(
    Diagram(coordinateSystem(extent = {{-250, -150}, {250, 150}}, grid = {1, 1})),
    Icon(coordinateSystem(extent = {{-250, -150}, {250, 150}}, grid = {1, 1})));
end IEEE9bus_pf;