within OmniPES.Transient.Examples;

model IEEE9bus
  extends Modelica.Icons.Example;
  OmniPES.Circuit.Interfaces.Bus B2 annotation(
    Placement(transformation(origin = {-180, 119}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus B7 annotation(
    Placement(transformation(origin = {-100, 119}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus B8 annotation(
    Placement(transformation(origin = {0, 119}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus B9 annotation(
    Placement(transformation(origin = {100, 119}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus B3 annotation(
    Placement(transformation(origin = {180, 119}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus B5 annotation(
    Placement(transformation(origin = {-90, 21}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OmniPES.Circuit.Interfaces.Bus B6 annotation(
    Placement(transformation(origin = {90, 21}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OmniPES.Circuit.Interfaces.Bus B4 annotation(
    Placement(transformation(origin = {-1, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OmniPES.Circuit.Interfaces.Bus B1 annotation(
    Placement(transformation(origin = {-1, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OmniPES.Circuit.Basic.TLine lt_7_8(r = 0.0085, x = 0.072, Q = 2*7.45e6)  annotation(
    Placement(transformation(origin = {-50, 114}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TLine lt_8_9(r = 0.0119, x = 0.1008, Q = 2*10.45e6)  annotation(
    Placement(transformation(origin = {50, 114}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TLine lt_7_5(r = 0.032, x = 0.161, Q = 2*15.3e6)  annotation(
    Placement(transformation(origin = {-85, 61}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OmniPES.Circuit.Basic.TLine lt_6_9(r = 0.039, x = 0.170, Q = 2*17.9e6)  annotation(
    Placement(transformation(origin = {89, 61}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.TLine lt_4_5(r = 0.010, x = 0.085, Q = 2*8.8e6)  annotation(
    Placement(transformation(origin = {-87, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OmniPES.Circuit.Basic.TLine lt_4_6(r = 0.017, x = 0.092, Q = 2*7.9e6)  annotation(
    Placement(transformation(origin = {87, -14}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.TwoWindingTransformer tf_2(x = 0.0625)  annotation(
    Placement(transformation(origin = {-140, 117}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer tf_3(x = 0.0586)  annotation(
    Placement(transformation(origin = {140, 117}, extent = {{10, -10}, {-10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer tf_1(x = 0.0576)  annotation(
    Placement(transformation(origin = {1, -79}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {-223, -126}, extent = {{-30, -30}, {30, 30}})));
  OmniPES.Transient.Loads.ZIPLoad load_A(Psp = 1.25e8, Qsp = 5e7)  annotation(
    Placement(transformation(origin = {-125, -15}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  OmniPES.Transient.Loads.ZIPLoad load_B(Psp = 9e7, Qsp = 3e7) annotation(
    Placement(transformation(origin = {134, -16}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  OmniPES.Transient.Loads.ZIPLoad load_C(Psp = 1e8, Qsp = 3.5e7) annotation(
    Placement(transformation(origin = {0, 70}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine G1(smData= g1_data, specs = g1_pf_specs, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH restriction, avr_on = true, redeclare AVR_Type_I avr)  annotation(
    Placement(transformation(origin = {1, -134}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData g1_data(H = 2364/247.5, MVAb = 2.475e8, Ra = 0, T1d0 = 8.96, T1q0 = 0.0, X1d = 0.0608*(247.5/100), X1q = 0.0969*(247.5/100), Xd = 0.1460*(247.5/100), Xl = 0.0336*(247.5/100), Xq = 0.0969*(247.5/100), X2d = 0.01*(247.5/100), X2q = 0.01*(247.5/100), T2d0 = 0.0, T2q0 = 0.0, D = 0) annotation(
    Placement(transformation(origin = {30, -135}, extent = {{-10, -10}, {10, 10}})));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData g1_pf_specs(Vsp = 1.04)  annotation(
    Placement(transformation(origin = {62, -135}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine G2(smData = g2_data, specs = g2_pf_specs, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric electrical, avr_on = true, redeclare AVR_Type_I avr)  annotation(
    Placement(transformation(origin = {-208, 117}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData g2_pf_specs(Vsp = 1.025, Psp = 1.63e8) annotation(
    Placement(transformation(origin = {-210, 70}, extent = {{-10, -10}, {10, 10}})));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData g2_data(H = 640/192, MVAb = 1.92e8, Ra = 0, T1d0 = 6.0, T1q0 = 0.535, X1d = 0.1198*(192/100), X1q = 0.1969*(192/100), Xd = 0.8958*(192/100), Xl = 0.0521*(192/100), Xq = 0.8645*(192/100), T2d0 = 1e-8, T2q0 = 1e-8, X2d = 0.01*(192/100), X2q = 0.01*(192/100), D = 0) annotation(
    Placement(transformation(origin = {-210, 96}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine G3(smData = g3_data, specs = g3_pf_specs, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric electrical, avr_on = true, redeclare AVR_Type_I avr)  annotation(
    Placement(transformation(origin = {206, 117}, extent = {{-10, -10}, {10, 10}})));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData g3_data(H = 301/128, MVAb = 1.28e8, Ra = 0, T1d0 = 5.89, T1q0 = 0.60, X1d = 0.1813*(128/100), X1q = 0.2500*(128/100), Xd = 1.3125*(128/100), Xl = 0.0742*(128/100), Xq = 1.2578*(128/100), T2d0 = 1e-8, T2q0 = 1e-8, X2d = 0.01*(128/100), X2q = 0.01*(128/100), D = 0) annotation(
    Placement(transformation(origin = {210, 93}, extent = {{-10, -10}, {10, 10}})));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData g3_pf_specs(Psp = 8.5e7, Vsp = 1.025) annotation(
    Placement(transformation(origin = {210, 70}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Switches.Fault fault(R = 0.01, X = 0.01, t_on = 3, t_off = 3.1)  annotation(
    Placement(transformation(origin = {77, 93}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Units.SI.Angle d21, d31;

  model AVR_Type_I
    extends OmniPES.Transient.Controllers.Interfaces.PartialAVR;
  Modelica.Blocks.Continuous.Derivative feedback(T = 0.35, initType = Modelica.Blocks.Types.Init.SteadyState, k = 0.063, y_start = 0, x_start = 1.0) annotation(
      Placement(transformation(origin = {-22, -18}, extent = {{72, -50}, {52, -30}})));
  Modelica.Blocks.Continuous.FirstOrder filter(T = 0.001, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
      Placement(transformation(origin = {-82, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.FirstOrder Exciter(k = 1/1, T = 0.314/1, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 1.0)  annotation(
      Placement(transformation(origin = {74, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
      Placement(transformation(origin = {8, 0}, extent = {{30, 10}, {50, -10}})));

    model Sat
      extends Modelica.Blocks.Interfaces.SISO;
      parameter Real Ae=0 "First saturation function coefficient";
      parameter Real Be=1 "Second saturation function coefficient";
    equation
y = (Ae*Modelica.Math.exp(Be*abs(u)))*u;
    end Sat;

    Sat sat(Ae = 0.0039, Be = 1.555)  annotation(
      Placement(transformation(origin = {72, 44}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Math.Feedback feedback2 annotation(
      Placement(transformation(origin = {-52, 0}, extent = {{30, -10}, {50, 10}}, rotation = -0)));
  Modelica.Blocks.Math.Add3 add3(k1 = -1)  annotation(
      Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant zero(k = 0)  annotation(
      Placement(transformation(origin = {-94, 0}, extent = {{-6, -6}, {6, 6}})));
  Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 1)  annotation(
      Placement(transformation(origin = {-72, 0}, extent = {{-6, -6}, {6, 6}})));
  OmniPES.Transient.Controllers.Blocks.LagLimit amplifier(k = 20, T = 0.2, ymax = +5, ymin = -5, y(start = 1))  annotation(
      Placement(transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(feedback1.y, Exciter.u) annotation(
      Line(points = {{57, 0}, {62, 0}}, color = {0, 0, 127}));
    connect(Exciter.y, Efd) annotation(
      Line(points = {{85, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(Vctrl, filter.u) annotation(
      Line(points = {{-112, 60}, {-94, 60}}, color = {0, 0, 127}));
    connect(feedback2.u2, feedback.y) annotation(
      Line(points = {{-12, -8}, {-12, -58}, {30, -58}}, color = {0, 0, 127}));
    connect(add3.y, feedback2.u1) annotation(
      Line(points = {{-29, 0}, {-20, 0}}, color = {0, 0, 127}));
    connect(filter.y, add3.u1) annotation(
      Line(points = {{-70, 60}, {-60, 60}, {-60, 8}, {-52, 8}}, color = {0, 0, 127}));
    connect(Vsad, add3.u3) annotation(
      Line(points = {{-112, -60}, {-60, -60}, {-60, -8}, {-52, -8}}, color = {0, 0, 127}));
    connect(zero.y, Vref.u) annotation(
      Line(points = {{-88, 0}, {-80, 0}}, color = {0, 0, 127}));
    connect(Vref.y, add3.u2) annotation(
      Line(points = {{-66, 0}, {-52, 0}}, color = {0, 0, 127}));
    connect(feedback1.u2, sat.y) annotation(
      Line(points = {{48, 8}, {48, 44}, {61, 44}}, color = {0, 0, 127}));
    connect(sat.u, Exciter.y) annotation(
      Line(points = {{84, 44}, {96, 44}, {96, 0}, {85, 0}}, color = {0, 0, 127}));
    connect(feedback.u, Exciter.y) annotation(
      Line(points = {{52, -58}, {96, -58}, {96, 0}, {85, 0}}, color = {0, 0, 127}));
  connect(feedback2.y, amplifier.u) annotation(
      Line(points = {{-2, 0}, {8, 0}}, color = {0, 0, 127}));
  connect(amplifier.y, feedback1.u1) annotation(
      Line(points = {{32, 0}, {40, 0}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end AVR_Type_I;
equation
  d21 = G2.inertia.delta - G1.inertia.delta;
  d31 = G3.inertia.delta - G1.inertia.delta;
  connect(tf_2.p, B2.p) annotation(
    Line(points = {{-151, 117}, {-180, 117}}, color = {0, 0, 255}));
  connect(tf_2.n, B7.p) annotation(
    Line(points = {{-129, 117}, {-100, 117}}, color = {0, 0, 255}));
  connect(lt_7_8.p, B7.p) annotation(
    Line(points = {{-61, 117}, {-100, 117}}, color = {0, 0, 255}));
  connect(lt_7_8.n, B8.p) annotation(
    Line(points = {{-39, 117}, {0, 117}}, color = {0, 0, 255}));
  connect(lt_8_9.p, B8.p) annotation(
    Line(points = {{39, 117}, {0, 117}}, color = {0, 0, 255}));
  connect(lt_8_9.n, B9.p) annotation(
    Line(points = {{61, 117}, {100, 117}}, color = {0, 0, 255}));
  connect(tf_3.n, B9.p) annotation(
    Line(points = {{129, 117}, {100, 117}}, color = {0, 0, 255}));
  connect(tf_3.p, B3.p) annotation(
    Line(points = {{151, 117}, {180, 117}}, color = {0, 0, 255}));
  connect(lt_7_5.n, B7.p) annotation(
    Line(points = {{-88, 72}, {-88, 117}, {-100, 117}}, color = {0, 0, 255}));
  connect(lt_7_5.p, B5.p) annotation(
    Line(points = {{-88, 50}, {-88, 21}}, color = {0, 0, 255}));
  connect(lt_4_5.n, B5.p) annotation(
    Line(points = {{-90, -3}, {-88, -3}, {-88, 21}}, color = {0, 0, 255}));
  connect(lt_4_5.p, B4.p) annotation(
    Line(points = {{-90, -25}, {-89, -25}, {-89, -35}, {1, -35}, {1, -48}}, color = {0, 0, 255}));
  connect(lt_6_9.n, B9.p) annotation(
    Line(points = {{92, 72}, {92, 117}, {100, 117}}, color = {0, 0, 255}, thickness = 0.5));
  connect(lt_4_6.n, B6.p) annotation(
    Line(points = {{90, -3}, {92, -3}, {92, 21}}, color = {0, 0, 255}));
  connect(lt_4_6.p, B4.p) annotation(
    Line(points = {{90, -25}, {90, -35}, {1, -35}, {1, -48}}, color = {0, 0, 255}, thickness = 0.5));
  connect(tf_1.p, B1.p) annotation(
    Line(points = {{1, -90}, {1, -108}}, color = {0, 0, 255}));
  connect(tf_1.n, B4.p) annotation(
    Line(points = {{1, -68}, {1, -48}}, color = {0, 0, 255}));
  connect(load_A.p, B5.p) annotation(
    Line(points = {{-125, 3}, {-125, 9}, {-88, 9}, {-88, 21}}, color = {0, 0, 255}));
  connect(load_B.p, B6.p) annotation(
    Line(points = {{134, 2}, {133, 2}, {133, 11}, {92, 11}, {92, 21}}, color = {0, 0, 255}));
  connect(load_C.p, B8.p) annotation(
    Line(points = {{0, 88}, {0, 117}}, color = {0, 0, 255}, thickness = 0.5));
  connect(G1.terminal, B1.p) annotation(
    Line(points = {{1, -124}, {1, -108}}, color = {0, 0, 255}, thickness = 0.5));
  connect(G2.terminal, B2.p) annotation(
    Line(points = {{-198, 117}, {-180, 117}}, color = {0, 0, 255}));
  connect(G3.terminal, B3.p) annotation(
    Line(points = {{196, 117}, {180, 117}}, color = {0, 0, 255}));
  connect(lt_6_9.p, B6.p) annotation(
    Line(points = {{92, 50}, {92, 21}}, color = {0, 0, 255}));
  connect(fault.T, B9.p) annotation(
    Line(points = {{77, 103}, {77, 117}, {100, 117}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-250, -150}, {250, 150}}, grid = {1, 1})),
    Icon(coordinateSystem(extent = {{-250, -150}, {250, 150}}, grid = {1, 1})),
  experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.001));
end IEEE9bus;