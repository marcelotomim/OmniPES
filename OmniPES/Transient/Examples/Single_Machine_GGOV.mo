within OmniPES.Transient.Examples;

model Single_Machine_GGOV
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {-77, 79}, extent = {{-17, -17}, {17, 17}})));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data_1(D = 0, H = 6.5, MVAb = 3e7, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(transformation(origin = {28, 38}, extent = {{-10, -10}, {10, 10}})));
  //
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine G1(redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare IEEE_GGOV1 sreg, smData = gen_data_1, specs = gen1_specs, avr_on = true, sreg_on = true, pss_on = true, redeclare PSS_1 pss) annotation(
    Placement(transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData gen1_specs(Psp = 2.5e7, Vsp = 1.030, theta_sp = 0) annotation(
    Placement(transformation(origin = {-28, 38}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(transformation(origin = {-16, 0}, extent = {{-6, -6}, {6, 6}})));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(transformation(origin = {-54, 0}, extent = {{-6, -6}, {6, 6}})));

  model IEEE_AC4A
    extends OmniPES.Transient.Controllers.Interfaces.PartialAVR;
    Modelica.Blocks.Math.Add3 add(k1 = -1, k2 = +1, k3 = +1) annotation(
      Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter limiter(strict = false, u(start = 1), uMax = 4, uMin = 0) annotation(
      Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.FirstOrder filter(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
      Placement(visible = true, transformation(origin = {-54, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 200) annotation(
      Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant zero(k = 0.0) annotation(
      Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression VCTRL(y = Vctrl) annotation(
      Placement(transformation(origin = {-109, 60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.RealExpression VSAD(y = Vsad) annotation(
      Placement(transformation(origin = {-109, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.RealExpression EFD(y = limiter.y) annotation(
      Placement(transformation(origin = {174, 90}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(Vref.y, add.u2) annotation(
      Line(points = {{-33, 0}, {-10, 0}}, color = {0, 0, 127}));
    connect(gain.y, limiter.u) annotation(
      Line(points = {{51, 0}, {64, 0}}, color = {0, 0, 127}));
    connect(add.y, gain.u) annotation(
      Line(points = {{13, 0}, {28, 0}}, color = {0, 0, 127}));
    connect(zero.y, Vref.u) annotation(
      Line(points = {{-69, 0}, {-56, 0}}, color = {0, 0, 127}));
    connect(filter.y, add.u1) annotation(
      Line(points = {{-42, 60}, {-20, 60}, {-20, 8}, {-10, 8}}, color = {0, 0, 127}));
    connect(VCTRL.y, filter.u) annotation(
      Line(points = {{-98, 60}, {-66, 60}}, color = {0, 0, 127}));
    connect(VSAD.y, add.u3) annotation(
      Line(points = {{-98, -40}, {-20, -40}, {-20, -8}, {-10, -8}}, color = {0, 0, 127}));
    connect(EFD.y, Efd) annotation(
      Line(points = {{185, 90}, {210, 90}}, color = {0, 0, 127}));
  end IEEE_AC4A;

  model PSS_1
    extends OmniPES.Transient.Controllers.Interfaces.PartialPSS;
    parameter Real Tw = 10.0;
    parameter Real T1 = 0.05;
    parameter Real T2 = 0.02;
    parameter Real T3 = 3.0;
    parameter Real T4 = 5.4;
    parameter Real Kstab = 20.0;
    Modelica.Blocks.Continuous.TransferFunction Washout(a = {Tw, 1}, b = {Tw, 0}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
      Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.TransferFunction LeadLag1(a = {T2, 1}, b = {T1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.TransferFunction LeadLag2(a = {T4, 1}, b = {T3, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
      Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = Kstab) annotation(
      Placement(transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 0.2, uMin = -0.2) annotation(
      Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression SPEED(y = omega) annotation(
      Placement(transformation(origin = {-130, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.RealExpression VSAD(y = limiter.y) annotation(
      Placement(transformation(origin = {169, 90}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(gain.y, Washout.u) annotation(
      Line(points = {{-67, 0}, {-50, 0}}, color = {0, 0, 127}));
    connect(Washout.y, LeadLag1.u) annotation(
      Line(points = {{-27, 0}, {-12, 0}}, color = {0, 0, 127}));
    connect(LeadLag1.y, LeadLag2.u) annotation(
      Line(points = {{11, 0}, {28, 0}}, color = {0, 0, 127}));
    connect(LeadLag2.y, limiter.u) annotation(
      Line(points = {{52, 0}, {68, 0}}, color = {0, 0, 127}));
    connect(SPEED.y, gain.u) annotation(
      Line(points = {{-118, 0}, {-90, 0}}, color = {0, 0, 127}));
    connect(VSAD.y, Vsad) annotation(
      Line(points = {{180, 90}, {210, 90}}, color = {0, 0, 127}));
  end PSS_1;

  Circuit.Sources.VoltageSource voltageSource annotation(
    Placement(transformation(origin = {88, -2}, extent = {{-10, -10}, {10, 10}})));

  model IEEE_GGOV1
    extends OmniPES.Transient.Controllers.Interfaces.PartialSpeedRegulator;
    Modelica.Blocks.Sources.Constant wref(k = 1.0) annotation(
      Placement(transformation(origin = {-74, 62}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.Integrator Pref(initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
      Placement(transformation(origin = {-159, 9}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant dPref(k = 0) annotation(
      Placement(transformation(origin = {-191, 9}, extent = {{-10, -10}, {10, 10}})));

    model SpeedRegulator
      Modelica.Blocks.Interfaces.RealInput wref annotation(
        Placement(transformation(origin = {-218, 78}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 100}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealInput w annotation(
        Placement(transformation(origin = {-218, -2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput fsrn annotation(
        Placement(transformation(origin = {208, -8}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {112, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Gain gain(k = 0.04) annotation(
        Placement(transformation(origin = {-68, -37}, extent = {{-14, -14}, {14, 14}})));
      Modelica.Blocks.Math.Add add annotation(
        Placement(transformation(origin = {-12, -2}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.RealInput Pref annotation(
        Placement(transformation(origin = {-220, -80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Math.Add add1(k1 = +1, k2 = -1) annotation(
        Placement(transformation(origin = {-90, 4}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.RealInput fsr annotation(
        Placement(transformation(origin = {-91, -92}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {1, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      Modelica.Blocks.Math.Add add2 annotation(
        Placement(transformation(origin = {152, -8}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.Integrator integrator(k = 2/10, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
        Placement(transformation(origin = {28, -92}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Feedback feedback annotation(
        Placement(transformation(origin = {-26, -92}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Add add3(k2 = -1) annotation(
        Placement(transformation(origin = {-128, -37}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.RealInput Pe annotation(
        Placement(transformation(origin = {-220, -124}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -100}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 0.05) annotation(
        Placement(transformation(origin = {32, -2}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Gain KPGOV(k = 10) annotation(
        Placement(transformation(origin = {81, -2}, extent = {{-12, -12}, {12, 12}})));
    equation
      connect(wref, add1.u1) annotation(
        Line(points = {{-218, 78}, {-128, 78}, {-128, 10}, {-102, 10}}, color = {0, 0, 127}));
      connect(w, add1.u2) annotation(
        Line(points = {{-218, -2}, {-102, -2}}, color = {0, 0, 127}));
      connect(add2.y, fsrn) annotation(
        Line(points = {{163, -8}, {208, -8}}, color = {0, 0, 127}));
      connect(fsr, feedback.u1) annotation(
        Line(points = {{-91, -92}, {-35, -92}}, color = {0, 0, 127}));
      connect(feedback.y, integrator.u) annotation(
        Line(points = {{-17, -92}, {16, -92}}, color = {0, 0, 127}));
      connect(integrator.y, add2.u2) annotation(
        Line(points = {{39, -92}, {104, -92}, {104, -14}, {140, -14}}, color = {0, 0, 127}));
      connect(feedback.u2, integrator.y) annotation(
        Line(points = {{-26, -100}, {-26, -126}, {72, -126}, {72, -92}, {39, -92}}, color = {0, 0, 127}));
      connect(add1.y, add.u1) annotation(
        Line(points = {{-79, 4}, {-24, 4}}, color = {0, 0, 127}));
      connect(add3.y, gain.u) annotation(
        Line(points = {{-117, -37}, {-85, -37}}, color = {0, 0, 127}));
      connect(Pe, add3.u2) annotation(
        Line(points = {{-220, -124}, {-166, -124}, {-166, -43}, {-140, -43}}, color = {0, 0, 127}));
      connect(gain.y, add.u2) annotation(
        Line(points = {{-53, -37}, {-44, -37}, {-44, -8}, {-24, -8}}, color = {0, 0, 127}));
      connect(add.y, limiter.u) annotation(
        Line(points = {{-1, -2}, {20, -2}}, color = {0, 0, 127}));
      connect(limiter.y, KPGOV.u) annotation(
        Line(points = {{43, -2}, {67, -2}}, color = {0, 0, 127}));
      connect(KPGOV.y, add2.u1) annotation(
        Line(points = {{94, -2}, {140, -2}}, color = {0, 0, 127}));
      connect(Pref, add3.u1) annotation(
        Line(points = {{-220, -80}, {-182, -80}, {-182, -30}, {-140, -30}}, color = {0, 0, 127}));
      annotation(
        Diagram(coordinateSystem(extent = {{-200, -150}, {200, 100}})),
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(fillColor = {153, 193, 241}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}, textString = "%name")}));
    end SpeedRegulator;

    SpeedRegulator RV annotation(
      Placement(transformation(origin = {-13, 2}, extent = {{-16, -16}, {16, 16}})));
    Modelica.Blocks.Math.Add add annotation(
      Placement(transformation(origin = {-118, -4}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y = if time < 2 then 0.0 else 0.1) annotation(
      Placement(transformation(origin = {-176, -22}, extent = {{-10, -10}, {10, 10}})));

    model AccelarationControl
      Modelica.Blocks.Interfaces.RealInput w annotation(
        Placement(transformation(origin = {-172, 30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-109, -1}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Blocks.Interfaces.RealInput aset annotation(
        Placement(transformation(origin = {-172, -30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {1, 109}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
      Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
        Placement(transformation(origin = {-16, -24}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.TransferFunction transferFunction(b = {1, 0}, a = {0.1, 1}, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0) annotation(
        Placement(transformation(origin = {-92, 30}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Add add1 annotation(
        Placement(transformation(origin = {101, -31}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.RealInput fsr annotation(
        Placement(transformation(origin = {-91, -77}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-1, -109}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Interfaces.RealOutput fsra annotation(
        Placement(transformation(origin = {162, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.LimIntegrator limIntegrator(k = 10, outMax = 1, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 1) annotation(
        Placement(transformation(origin = {42, -24}, extent = {{-10, -10}, {10, 10}})));
    equation
      connect(w, transferFunction.u) annotation(
        Line(points = {{-172, 30}, {-104, 30}}, color = {0, 0, 127}));
      connect(transferFunction.y, add.u1) annotation(
        Line(points = {{-80, 30}, {-50, 30}, {-50, -18}, {-28, -18}}, color = {0, 0, 127}));
      connect(aset, add.u2) annotation(
        Line(points = {{-172, -30}, {-28, -30}}, color = {0, 0, 127}));
      connect(add1.y, fsra) annotation(
        Line(points = {{112, -30}, {126, -30}, {126, 0}, {162, 0}}, color = {0, 0, 127}));
      connect(fsr, add1.u2) annotation(
        Line(points = {{-90, -76}, {72, -76}, {72, -36}, {90, -36}}, color = {0, 0, 127}));
      connect(add.y, limIntegrator.u) annotation(
        Line(points = {{-4, -24}, {30, -24}}, color = {0, 0, 127}));
      connect(limIntegrator.y, add1.u1) annotation(
        Line(points = {{54, -24}, {90, -24}}, color = {0, 0, 127}));
      annotation(
        Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
        Icon(graphics = {Rectangle(fillColor = {249, 240, 107}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-98, 60}, {98, -60}}, textString = "%name")}),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end AccelarationControl;

    model LowLevelSelect
      Modelica.Blocks.Interfaces.RealInput u[3] annotation(
        Placement(transformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation(
        Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {112, 0}, extent = {{-10, -10}, {10, 10}})));
    equation
      y = min(u);
      annotation(
        Diagram(graphics),
        Icon(graphics = {Rectangle(fillColor = {181, 131, 90}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-100, 60}, {100, -60}}, textString = "%name")}));
    end LowLevelSelect;

    LowLevelSelect MIN annotation(
      Placement(transformation(origin = {35, -107}, extent = {{-15, -15}, {15, 15}})));
    AccelarationControl ACCEL annotation(
      Placement(transformation(origin = {-122, -188}, extent = {{-16, -16}, {16, 16}})));
    Modelica.Blocks.Sources.Constant aset(k = 1000.01) annotation(
      Placement(transformation(origin = {-150, -152}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain T2S(k = 30/100) annotation(
      Placement(transformation(origin = {134, 90}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain S2T(k = 100/30) annotation(
      Placement(transformation(origin = {-75, -4}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Nonlinear.Limiter FSR(uMax = 1.0, uMin = 0.15) annotation(
      Placement(transformation(origin = {78, -106}, extent = {{-10, -10}, {10, 10}})));

    model FuelSystem
      Modelica.Blocks.Interfaces.RealInput fsr annotation(
        Placement(transformation(origin = {-119, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 0}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Blocks.Math.Feedback feedback annotation(
        Placement(transformation(origin = {-64, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.RealOutput Wf annotation(
        Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Gain one_over_Tact(k = 1/0.5) annotation(
        Placement(transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.Integrator integrator(k = 1, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
        Placement(transformation(origin = {64, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Nonlinear.Limiter valve_limiter(uMax = 0.1, uMin = -0.1) annotation(
        Placement(transformation(origin = {22, 0}, extent = {{-10, -10}, {10, 10}})));
    equation
      connect(fsr, feedback.u1) annotation(
        Line(points = {{-118, 0}, {-72, 0}}, color = {0, 0, 127}));
      connect(feedback.y, one_over_Tact.u) annotation(
        Line(points = {{-54, 0}, {-34, 0}}, color = {0, 0, 127}));
      connect(one_over_Tact.y, valve_limiter.u) annotation(
        Line(points = {{-10, 0}, {10, 0}}, color = {0, 0, 127}));
      connect(valve_limiter.y, integrator.u) annotation(
        Line(points = {{34, 0}, {52, 0}}, color = {0, 0, 127}));
      connect(integrator.y, Wf) annotation(
        Line(points = {{76, 0}, {110, 0}}, color = {0, 0, 127}));
      connect(feedback.u2, integrator.y) annotation(
        Line(points = {{-64, -8}, {-64, -32}, {84, -32}, {84, 0}, {76, 0}}, color = {0, 0, 127}));
      annotation(
        Diagram(graphics),
        Icon(graphics = {Rectangle(fillColor = {220, 138, 221}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-98, 60}, {98, -60}}, textString = "%name")}));
    end FuelSystem;

    FuelSystem FUEL annotation(
      Placement(transformation(origin = {129, -106}, extent = {{-19, -19}, {19, 19}})));

    model Conversion
      Modelica.Blocks.Interfaces.RealInput fsr annotation(
        Placement(transformation(origin = {-119, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 0}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Blocks.Math.Feedback feedback annotation(
        Placement(transformation(origin = {-64, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.RealOutput Pconv annotation(
        Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Gain Kturb(k = 1.5) annotation(
        Placement(transformation(origin = {-4, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.TransferFunction transferFunction(b = {1}, a = {0.1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
        Placement(transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant Wfnl(k = 0.2) annotation(
        Placement(transformation(origin = {-80, -36}, extent = {{-10, -10}, {10, 10}})));
    equation
      connect(fsr, feedback.u1) annotation(
        Line(points = {{-118, 0}, {-72, 0}}, color = {0, 0, 127}));
      connect(feedback.y, Kturb.u) annotation(
        Line(points = {{-54, 0}, {-16, 0}}, color = {0, 0, 127}));
      connect(Kturb.y, transferFunction.u) annotation(
        Line(points = {{8, 0}, {42, 0}}, color = {0, 0, 127}));
      connect(transferFunction.y, Pconv) annotation(
        Line(points = {{66, 0}, {110, 0}}, color = {0, 0, 127}));
      connect(Wfnl.y, feedback.u2) annotation(
        Line(points = {{-68, -36}, {-64, -36}, {-64, -8}}, color = {0, 0, 127}));
      annotation(
        Diagram(graphics),
        Icon(graphics = {Rectangle(fillColor = {255, 190, 111}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-98, 60}, {98, -60}}, textString = "%name")}));
    end Conversion;

    Conversion PMECH annotation(
      Placement(transformation(origin = {114, 20}, extent = {{20, -20}, {-20, 20}})));

    model TemperatureControl
      Modelica.Blocks.Interfaces.RealInput Wf annotation(
        Placement(transformation(origin = {-199, 18}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 0}, extent = {{-11, -11}, {11, 11}})));
      Modelica.Blocks.Interfaces.RealOutput fsrt annotation(
        Placement(transformation(origin = {210, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.TransferFunction transferFunction(b = {4, 1}, a = {5, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
        Placement(transformation(origin = {-150, 18}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant Wfnl(k = 0.2) annotation(
        Placement(transformation(origin = {-166, -26}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(k = 1, T = 3, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
        Placement(transformation(origin = {-106, 18}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
        Placement(transformation(origin = {-24, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Add add1(k1 = +1, k2 = +1) annotation(
        Placement(transformation(origin = {-61, -31}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Gain gain(k = 1/1.5) annotation(
        Placement(transformation(origin = {-104, -64}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant Ldref(k = 1) annotation(
        Placement(transformation(origin = {-164, -65}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Gain Kpload(k = 2) annotation(
        Placement(transformation(origin = {25, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.RealInput fsr annotation(
        Placement(transformation(origin = {-28, -53}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {8, -121}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      Modelica.Blocks.Continuous.Integrator integrator(initType = Modelica.Blocks.Types.Init.SteadyState, k = 0.67/2) annotation(
        Placement(transformation(origin = {53, -53}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Feedback feedback annotation(
        Placement(transformation(origin = {9, -53}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Add add11(k1 = +1, k2 = +1) annotation(
        Placement(transformation(origin = {115, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = -99) annotation(
        Placement(transformation(origin = {166, 0}, extent = {{-10, -10}, {10, 10}})));
    equation
      connect(Wf, transferFunction.u) annotation(
        Line(points = {{-199, 18}, {-163, 18}}, color = {0, 0, 127}));
      connect(transferFunction.y, firstOrder.u) annotation(
        Line(points = {{-139, 18}, {-119, 18}}, color = {0, 0, 127}));
      connect(firstOrder.y, add.u1) annotation(
        Line(points = {{-95, 18}, {-37, 18}}, color = {0, 0, 127}));
      connect(Wfnl.y, add1.u1) annotation(
        Line(points = {{-155, -26}, {-122, -26}, {-122, -25}, {-74, -25}}, color = {0, 0, 127}));
      connect(gain.y, add1.u2) annotation(
        Line(points = {{-93, -64}, {-81, -64}, {-81, -36}, {-73, -36}}, color = {0, 0, 127}));
      connect(add1.y, add.u2) annotation(
        Line(points = {{-50, -31}, {-44, -31}, {-44, 5}, {-36, 5}}, color = {0, 0, 127}));
      connect(add.y, Kpload.u) annotation(
        Line(points = {{-12, 12}, {13, 12}}, color = {0, 0, 127}));
      connect(fsr, feedback.u1) annotation(
        Line(points = {{-28, -53}, {1, -53}}, color = {0, 0, 127}));
      connect(feedback.y, integrator.u) annotation(
        Line(points = {{18, -53}, {41, -53}}, color = {0, 0, 127}));
      connect(feedback.u2, integrator.y) annotation(
        Line(points = {{9, -61}, {9, -87}, {89, -87}, {89, -53}, {64, -53}}, color = {0, 0, 127}));
      connect(Kpload.y, add11.u1) annotation(
        Line(points = {{36, 12}, {80, 12}, {80, 6}, {104, 6}}, color = {0, 0, 127}));
      connect(integrator.y, add11.u2) annotation(
        Line(points = {{64, -53}, {64, -52}, {90, -52}, {90, -4}, {104, -4}, {104, -6}}, color = {0, 0, 127}));
      connect(add11.y, limiter.u) annotation(
        Line(points = {{126, 0}, {154, 0}}, color = {0, 0, 127}));
      connect(limiter.y, fsrt) annotation(
        Line(points = {{178, 0}, {210, 0}}, color = {0, 0, 127}));
      connect(Ldref.y, gain.u) annotation(
        Line(points = {{-153, -65}, {-142, -65}, {-142, -64}, {-116, -64}}, color = {0, 0, 127}));
      annotation(
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        Icon(graphics = {Rectangle(fillColor = {143, 240, 164}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-98, 60}, {98, -60}}, textString = "%name")}));
    end TemperatureControl;

    Modelica.Blocks.Math.Gain S2T1(k = 100/30) annotation(
      Placement(transformation(origin = {-167, -63}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(k = 1, T = 1, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
      Placement(transformation(origin = {-116, -63}, extent = {{-10, -10}, {10, 10}})));
    TemperatureControl TEMP annotation(
      Placement(transformation(origin = {88, -240}, extent = {{26, 26}, {-26, -26}})));
    Modelica.Blocks.Sources.RealExpression WCTRL(y = wctrl) annotation(
      Placement(transformation(origin = {-168, -188}, extent = {{-12, -11}, {12, 11}})));
    Modelica.Blocks.Sources.RealExpression SIG1(y = FSR.y) annotation(
      Placement(transformation(origin = {62, -185}, extent = {{-12, -10}, {12, 10}})));
    Modelica.Blocks.Sources.RealExpression SIG11(y = FSR.y) annotation(
      Placement(transformation(origin = {-31, -42}, extent = {{-12, -10}, {12, 10}})));
    Modelica.Blocks.Sources.RealExpression SIG12(y = FSR.y) annotation(
      Placement(transformation(origin = {-155, -221}, extent = {{-14, -10}, {14, 10}})));
    Modelica.Blocks.Sources.RealExpression WCTRL1(y = wctrl) annotation(
      Placement(transformation(origin = {-77, 23}, extent = {{-13, -10}, {13, 10}})));
  equation
    connect(dPref.y, Pref.u) annotation(
      Line(points = {{-180, 9}, {-171, 9}}, color = {0, 0, 127}));
    connect(aset.y, ACCEL.aset) annotation(
      Line(points = {{-139, -152}, {-122, -152}, {-122, -171}}, color = {0, 0, 127}));
    connect(add.y, S2T.u) annotation(
      Line(points = {{-107, -4}, {-87, -4}}, color = {0, 0, 127}));
    connect(MIN.y, FSR.u) annotation(
      Line(points = {{51.8, -107}, {65.8, -107}, {65.8, -106}}, color = {0, 0, 127}));
    connect(S2T1.y, firstOrder.u) annotation(
      Line(points = {{-156, -63}, {-128, -63}}, color = {0, 0, 127}));
    connect(WCTRL.y, ACCEL.w) annotation(
      Line(points = {{-155, -188}, {-140, -188}}, color = {0, 0, 127}));
    connect(SIG12.y, ACCEL.fsr) annotation(
      Line(points = {{-140, -221}, {-122, -221}, {-122, -206}}, color = {0, 0, 127}));
    connect(PMECH.Pconv, T2S.u) annotation(
      Line(points = {{92, 20}, {56, 20}, {56, 90}, {122, 90}}, color = {0, 0, 127}));
    connect(signalBus.TerminalActivePower, S2T1.u) annotation(
      Line(points = {{-210, 70}, {-212, 70}, {-212, -63}, {-179, -63}}, color = {0, 0, 127}));
    connect(T2S.y, Pm) annotation(
      Line(points = {{146, 90}, {210, 90}}, color = {0, 0, 127}));
    connect(Pref.y, add.u1) annotation(
      Line(points = {{-148, 10}, {-138, 10}, {-138, 2}, {-130, 2}}, color = {0, 0, 127}));
    connect(realExpression.y, add.u2) annotation(
      Line(points = {{-164, -22}, {-142, -22}, {-142, -10}, {-130, -10}}, color = {0, 0, 127}));
    connect(wref.y, RV.wref) annotation(
      Line(points = {{-62, 62}, {-48, 62}, {-48, 18}, {-32, 18}}, color = {0, 0, 127}));
    connect(WCTRL1.y, RV.w) annotation(
      Line(points = {{-63, 23}, {-56, 23}, {-56, 8}, {-32, 8}}, color = {0, 0, 127}));
    connect(S2T.y, RV.Pref) annotation(
      Line(points = {{-64, -4}, {-32, -4}}, color = {0, 0, 127}));
    connect(firstOrder.y, RV.Pe) annotation(
      Line(points = {{-104, -62}, {-46, -62}, {-46, -14}, {-32, -14}}, color = {0, 0, 127}));
    connect(SIG11.y, RV.fsr) annotation(
      Line(points = {{-18, -42}, {-12, -42}, {-12, -18}}, color = {0, 0, 127}));
    connect(RV.fsrn, MIN.u[1]) annotation(
      Line(points = {{4, 2}, {10, 2}, {10, -106}, {18, -106}}, color = {0, 0, 127}));
    connect(ACCEL.fsra, MIN.u[2]) annotation(
      Line(points = {{-104, -188}, {-64, -188}, {-64, -106}, {18, -106}}, color = {0, 0, 127}));
    connect(TEMP.fsrt, MIN.u[3]) annotation(
      Line(points = {{59, -240}, {10, -240}, {10, -106}, {18, -106}}, color = {0, 0, 127}));
    connect(SIG1.y, TEMP.fsr) annotation(
      Line(points = {{75, -185}, {86, -185}, {86, -208}}, color = {0, 0, 127}));
    connect(TEMP.Wf, FUEL.Wf) annotation(
      Line(points = {{116, -240}, {176, -240}, {176, -106}, {150, -106}}, color = {0, 0, 127}));
    connect(FSR.y, FUEL.fsr) annotation(
      Line(points = {{90, -106}, {108, -106}}, color = {0, 0, 127}));
    connect(PMECH.fsr, FUEL.Wf) annotation(
      Line(points = {{136, 20}, {176, 20}, {176, -106}, {150, -106}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -300}, {200, 100}})),
      Icon(coordinateSystem(extent = {{-200, -300}, {200, 100}})),
      experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-06, Interval = 0.001));
  end IEEE_GGOV1;

  Circuit.Basic.TwoWindingTransformer twoWindingTransformer(x = 0.1) annotation(
    Placement(transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Basic.TLine tLine(x = 0.1, Q = 5e7, r = 0) annotation(
    Placement(transformation(origin = {22, 8}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Basic.TLine_switched tLine_switched(x = 0.1, Q = 5e7, r = 0, t_open_p = 100.3, t_open_n = 100.3) annotation(
    Placement(transformation(origin = {22, -10}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Switches.Fault fault(t_on = 100.2, t_off = 100.3) annotation(
    Placement(transformation(origin = {-12, -36}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(bus1.p, twoWindingTransformer.p) annotation(
    Line(points = {{-54, 0}, {-45, 0}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.n, bus2.p) annotation(
    Line(points = {{-23, 0}, {-16, 0}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus3.p) annotation(
    Line(points = {{78, -2}, {60, -2}}, color = {0, 0, 255}));
  connect(tLine.n, bus3.p) annotation(
    Line(points = {{34, 12}, {46, 12}, {46, -2}, {60, -2}}, color = {0, 0, 255}));
  connect(tLine_switched.n, bus3.p) annotation(
    Line(points = {{34, -6}, {46, -6}, {46, -2}, {60, -2}}, color = {0, 0, 255}));
  connect(bus2.p, tLine.p) annotation(
    Line(points = {{-16, 0}, {-6, 0}, {-6, 12}, {12, 12}}, color = {0, 0, 255}));
  connect(tLine_switched.p, bus2.p) annotation(
    Line(points = {{12, -6}, {-6, -6}, {-6, 0}, {-16, 0}}, color = {0, 0, 255}));
  connect(G1.terminal, bus1.p) annotation(
    Line(points = {{-72, 0}, {-54, 0}}, color = {0, 0, 255}));
  connect(fault.T, bus2.p) annotation(
    Line(points = {{-12, -26}, {-12, 0}, {-16, 0}}, color = {0, 0, 255}));
protected
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(transformation(origin = {59, -3}, extent = {{-6, -6}, {6, 6}})));
  annotation(
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Single_Machine_GGOV;