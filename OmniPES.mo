package OmniPES
  class Overview
    extends Modelica.Icons.Information;
    annotation(
      Documentation(info = "<html></html>"));
  end Overview;

  package Units
    type PerUnit = Real(unit = "pu");
    operator record CPerUnit = Complex(redeclare PerUnit re, redeclare PerUnit im);
    type ActivePower = Real(final quantity = "Power", final unit = "MW");
    type ApparentPower = Real(final quantity = "Power", final unit = "MVA");
    type ReactivePower = Real(final quantity = "Power", final unit = "Mvar");
    type Voltage = Real(final quantity = "Voltage", final unit = "kV");
    type Current = Real(final quantity = "Current", final unit = "kA");
  end Units;

  model SystemData
    import Modelica.Units.SI;
    import Modelica.Constants.pi;
    parameter OmniPES.Units.ApparentPower Sbase = 100 annotation(
      Dialog(group = "Base Quantities"));
    parameter SI.Frequency fb = 60 annotation(
      Dialog(group = "Base Quantities"));
    parameter SI.AngularVelocity wb = 2*pi*fb;
    annotation(
      defaultComponentName = "data",
      defaultComponentPrefixes = "inner",
      missingInnerMessage = "The System object is missing, please drag it on the top layer of your model",
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 70}, {80, -70}}), Text(extent = {{-60, 40}, {60, -40}}, textString = "System")}),
      Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end SystemData;

  package Math
    extends Modelica.Icons.FunctionsPackage;

    function sys2qd
      extends Modelica.Icons.Function;
      input Complex A;
      input Modelica.Units.SI.Angle delta;
      output Complex Aqd;
      import Modelica.ComplexMath.j;
    algorithm
      Aqd := A*Modelica.ComplexMath.exp(-j*delta);
    end sys2qd;

    function polar2cart
      extends Modelica.Icons.Function;
      import Modelica.ComplexMath.exp;
      import Modelica.ComplexMath.j;
      import Modelica.Constants.pi;
      input Real mag "Absolute value of the complex";
      input Modelica.Units.SI.Angle phase "Phase angle of the complex";
      output Complex z "Resultant complex number";
    algorithm
      z := mag*exp(j*phase);
    end polar2cart;
  end Math;

  package Scopes
    model Ammeter
      extends OmniPES.Circuit.Interfaces.SeriesComponent;
      import Modelica.ComplexMath.conj;
      OmniPES.Units.PerUnit I;
      OmniPES.Units.CPerUnit S;
      Modelica.Units.SI.Angle theta;
    equation
      I^2 = i.re^2 + i.im^2;
      i.re = I*cos(theta);
      S = p.v*conj(p.i);
      v = Complex(0);
      annotation(
        Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, endAngle = 360), Text(origin = {0, 1}, extent = {{-26, 25}, {26, -25}}, textString = "A"), Line(origin = {-70, 0}, points = {{-30, 0}, {30, 0}}), Line(origin = {70, 0}, points = {{-30, 0}, {30, 0}})}));
    end Ammeter;
  end Scopes;

  package SteadyState
    package Loads
      package Interfaces
        extends Modelica.Icons.InterfacesPackage;

        record LoadData
          extends Modelica.Icons.Record;
          parameter Real pi = 0;
          parameter Real pz = 0;
          parameter Real qi = 0;
          parameter Real qz = 0;
          annotation(
            defaultComponentPrefixes = "parameter");
        end LoadData;
      end Interfaces;

      model ZIPLoad
        outer OmniPES.SystemData data;
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        parameter OmniPES.Units.ActivePower Psp "Specified active power [MW]";
        parameter OmniPES.Units.ReactivePower Qsp "Specified reactive power [Mvar]";
        parameter OmniPES.Units.PerUnit Vdef = 1.0;
        parameter OmniPES.SteadyState.Loads.Interfaces.LoadData ss_par = OmniPES.SteadyState.Loads.Interfaces.LoadData() annotation(
          Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Units.CPerUnit S;
        OmniPES.Units.PerUnit Vabs(start = 1);
        import Modelica.ComplexMath.conj;
      protected
        parameter Real pp = 1 - ss_par.pi - ss_par.pz;
        parameter Real pi = ss_par.pi;
        parameter Real pz = ss_par.pz;
        parameter Real qq = 1 - ss_par.qi - ss_par.qz;
        parameter Real qi = ss_par.qi;
        parameter Real qz = ss_par.qz;
      equation
        S = v*conj(i);
        Vabs^2 = v.re^2 + v.im^2;
        S.re = Psp/data.Sbase*(pp + pi*(Vabs/Vdef) + pz*(Vabs/Vdef)^2);
        S.im = Qsp/data.Sbase*(qq + qi*(Vabs/Vdef) + qz*(Vabs/Vdef)^2);
        annotation(
          Icon(graphics = {Text(origin = {1, 2.84217e-14}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}));
      end ZIPLoad;
    end Loads;

    package Examples
      extends Modelica.Icons.ExamplesPackage;

      model Test_Radial_System_Power_Flow
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 0.98) annotation(
          Placement(visible = true, transformation(origin = {-96, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {52, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.01) annotation(
          Placement(visible = true, transformation(origin = {74, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
          Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Sources.PVSource pVSource(Psp = 100, Vsp = 1.0) annotation(
          Placement(visible = true, transformation(origin = {115, 3}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
        OmniPES.Circuit.Interfaces.Bus bus annotation(
          Placement(visible = true, transformation(origin = {94, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 150, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.SteadyState.Loads.ZIPLoad zip(Psp = 100, Qsp = 50, ss_par = load_data) annotation(
          Placement(visible = true, transformation(origin = {-46, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter Loads.Interfaces.LoadData load_data annotation(
          Placement(visible = true, transformation(origin = {-46, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine_switched tLine_switched(Q = 150, r = 0, t_open = 2, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {0, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(voltageSource.p, impedance2.n) annotation(
          Line(points = {{-96, 20}, {-80, 20}}, color = {0, 0, 255}));
        connect(impedance2.p, bus1.p) annotation(
          Line(points = {{-60, 20}, {-50.4, 20}, {-50.4, 18}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(bus2.p, impedance1.n) annotation(
          Line(points = {{52, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(impedance1.p, bus.p) annotation(
          Line(points = {{84, 16}, {94, 16}}, color = {0, 0, 255}));
        connect(pVSource.p, bus.p) annotation(
          Line(points = {{115, 16}, {94, 16}}, color = {0, 0, 255}));
        connect(tLine.n, bus2.p) annotation(
          Line(points = {{14, 30}, {38, 30}, {38, 22}, {52, 22}, {52, 16}}, color = {0, 0, 255}));
        connect(tLine.p, bus1.p) annotation(
          Line(points = {{-8, 30}, {-34, 30}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
        connect(zip.p, bus1.p) annotation(
          Line(points = {{-46, -30}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine_switched.p, bus1.p) annotation(
          Line(points = {{-10, -8}, {-38, -8}, {-38, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine_switched.n, bus2.p) annotation(
          Line(points = {{12, -8}, {38, -8}, {38, 16}, {52, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
      end Test_Radial_System_Power_Flow;

      model Test_Minimal
        OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
          Placement(visible = true, transformation(origin = {-84, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 50, r = 0, x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {39, -5}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-77, 69}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-58, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.PQSource pQSource(P = 100, Q = 0) annotation(
          Placement(visible = true, transformation(origin = {86, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {68, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {6, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TwoWindingTransformer twoWindingTransformer(tap = 1.05, x = 0.01) annotation(
          Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.SteadyState.Loads.ZIPLoad zIPLoad(Psp = 50, Qsp = 10, ss_par = loadData) annotation(
          Placement(visible = true, transformation(origin = {6, -60}, extent = {{-22, -22}, {22, 22}}, rotation = -90)));
        parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData(pi = 0.75, qz = 1) annotation(
          Placement(visible = true, transformation(origin = {-38, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(voltageSource.p, bus1.p) annotation(
          Line(points = {{-84, 0.2}, {-58, 0.2}}, color = {0, 0, 255}));
        connect(tLine.n, bus3.p) annotation(
          Line(points = {{55.5, -0.5}, {59.5, -0.5}, {59.5, -1.5}, {67, -1.5}}, color = {0, 0, 255}));
        connect(pQSource.p, bus3.p) annotation(
          Line(points = {{86, 0.2}, {68, 0.2}}, color = {0, 0, 255}));
        connect(tLine.p, bus2.p) annotation(
          Line(points = {{22.5, -0.5}, {6.5, -0.5}}, color = {0, 0, 255}));
        connect(twoWindingTransformer.p, bus1.p) annotation(
          Line(points = {{-37, 0}, {-59, 0}}, color = {0, 0, 255}));
        connect(twoWindingTransformer.n, bus2.p) annotation(
          Line(points = {{-15, 0}, {5, 0}}, color = {0, 0, 255}));
        connect(bus2.p, zIPLoad.p) annotation(
          Line(points = {{6, 0}, {6, -38}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
      end Test_Minimal;

      model Test_Radial_System_Power_Flow_Qlim
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 0.98) annotation(
          Placement(visible = true, transformation(origin = {-96, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {52, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.01) annotation(
          Placement(visible = true, transformation(origin = {74, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
          Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus annotation(
          Placement(visible = true, transformation(origin = {94, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 150, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine_switched tLine1(Q = 150, r = 0, t_open = 2, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {2, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.SteadyState.Loads.ZIPLoad zip(Psp = 100, Qsp = 50, ss_par = load_data) annotation(
          Placement(visible = true, transformation(origin = {-46, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.SteadyState.Loads.Interfaces.LoadData load_data annotation(
          Placement(visible = true, transformation(origin = {-46, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.PVSource_Qlim pVSource_Qlim(Psp = 100, Qmax = +3000, Qmin = -80, Vsp = 1.0) annotation(
          Placement(visible = true, transformation(origin = {131, -7}, extent = {{-23, -23}, {23, 23}}, rotation = -90)));
      equation
        connect(voltageSource.p, impedance2.n) annotation(
          Line(points = {{-96, 20}, {-80, 20}}, color = {0, 0, 255}));
        connect(impedance2.p, bus1.p) annotation(
          Line(points = {{-60, 20}, {-50.4, 20}, {-50.4, 18}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(bus2.p, impedance1.n) annotation(
          Line(points = {{52, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(impedance1.p, bus.p) annotation(
          Line(points = {{84, 16}, {94, 16}}, color = {0, 0, 255}));
        connect(tLine.n, bus2.p) annotation(
          Line(points = {{14, 30}, {38, 30}, {38, 22}, {52, 22}, {52, 16}}, color = {0, 0, 255}));
        connect(tLine.p, bus1.p) annotation(
          Line(points = {{-8, 30}, {-34, 30}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
        connect(zip.p, bus1.p) annotation(
          Line(points = {{-46, -30}, {-46, 18}}, color = {0, 0, 255}));
        connect(pVSource_Qlim.p, bus.p) annotation(
          Line(points = {{131, 16}, {94, 16}}, color = {0, 0, 255}));
        connect(tLine1.p, bus1.p) annotation(
          Line(points = {{-9, -1}, {-34, -1}, {-34, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine1.n, bus2.p) annotation(
          Line(points = {{13, -1}, {40, -1}, {40, 16}, {52, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
      end Test_Radial_System_Power_Flow_Qlim;

      model Kundur_Two_Area_System_SteadyState
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
        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor(NominalPower = 200) annotation(
          Placement(visible = true, transformation(origin = {-128, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor1(NominalPower = 350) annotation(
          Placement(visible = true, transformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ssLoadData(pi = 0, qz = 0) annotation(
          Placement(visible = true, transformation(origin = {-108, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource G3(angle = 0.0, magnitude = 1.030) annotation(
          Placement(visible = true, transformation(origin = {222, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.PVSource G4(Psp = 700, Vsp = 1.010) annotation(
          Placement(visible = true, transformation(origin = {172, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.PVSource G1(Psp = 700, Vsp = 1.030) annotation(
          Placement(visible = true, transformation(origin = {-254, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Sources.PVSource G2(Psp = 700, Vsp = 1.010) annotation(
          Placement(visible = true, transformation(origin = {-212, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.SteadyState.Loads.ZIPLoad L1(Psp = 967, Qsp = 100, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.SteadyState.Loads.ZIPLoad L2(Psp = 1767, Qsp = 100, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {64, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Sources.CurrentSource currentSource(magnitude = 0.0) annotation(
          Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
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
        connect(shunt_Capacitor.p, bus7.p) annotation(
          Line(points = {{-128, -16}, {-128, 0}, {-108, 0}, {-108, 16}}, color = {0, 0, 255}));
        connect(shunt_Capacitor1.p, bus9.p) annotation(
          Line(points = {{84, -14}, {72, -14}, {72, 12}, {64, 12}, {64, 16}}, color = {0, 0, 255}));
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
        connect(G3.p, bus3.p) annotation(
          Line(points = {{212, 14}, {198, 14}}, color = {0, 0, 255}));
        connect(G4.p, bus4.p) annotation(
          Line(points = {{162, -20}, {150, -20}}, color = {0, 0, 255}));
        connect(G1.p, bus1.p) annotation(
          Line(points = {{-244, 18}, {-230, 18}}, color = {0, 0, 255}));
        connect(G2.p, bus2.p) annotation(
          Line(points = {{-202, -8}, {-186, -8}}, color = {0, 0, 255}));
        connect(L1.p, bus7.p) annotation(
          Line(points = {{-108, -20}, {-108, 16}}, color = {0, 0, 255}));
        connect(L2.p, bus9.p) annotation(
          Line(points = {{64, -16}, {64, 16}}, color = {0, 0, 255}));
        connect(currentSource.p, bus7.p) annotation(
          Line(points = {{-50, -20}, {-96, -20}, {-96, 16}, {-108, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
      end Kundur_Two_Area_System_SteadyState;

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

      model Test_Radial_01
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {-18, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {12, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1) annotation(
          Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.TLine tLine1(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {42, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {78, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Sources.PVSource pVSource(Psp = 60., Vsp = 0.95) annotation(
          Placement(visible = true, transformation(origin = {4, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        connect(tLine.p, bus1.p) annotation(
          Line(points = {{-29, 23}, {-34, 23}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine.n, bus2.p) annotation(
          Line(points = {{-7, 23}, {12, 23}, {12, 17}}, color = {0, 0, 255}));
        connect(bus2.p, tLine1.p) annotation(
          Line(points = {{11.88, 16.8}, {31, 16.8}, {31, 21}}, color = {0, 0, 255}));
        connect(tLine1.n, bus3.p) annotation(
          Line(points = {{53, 21}, {65, 21}, {65, 15}, {77, 15}}, color = {0, 0, 255}));
        connect(voltageSource.p, bus1.p) annotation(
          Line(points = {{-70, 20}, {-58, 20}, {-58, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(pVSource.p, bus2.p) annotation(
          Line(points = {{4, -8}, {4, 16}, {12, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
      end Test_Radial_01;

      model Test_Radial_01_eq
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.TLine_eq tLine(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {-18, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {12, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1) annotation(
          Placement(visible = true, transformation(origin = {-70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.TLine_eq tLine1(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {54, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {96, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Sources.PVSource pVSource(Psp = 60., Vsp = 0.95) annotation(
          Placement(visible = true, transformation(origin = {4, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        connect(tLine.p, bus1.p) annotation(
          Line(points = {{-29, 23}, {-34, 23}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine.n, bus2.p) annotation(
          Line(points = {{-7, 23}, {12, 23}, {12, 17}}, color = {0, 0, 255}));
        connect(bus2.p, tLine1.p) annotation(
          Line(points = {{11.88, 16.8}, {43, 16.8}, {43, 17}}, color = {0, 0, 255}));
        connect(tLine1.n, bus3.p) annotation(
          Line(points = {{65, 17}, {96, 17}}, color = {0, 0, 255}));
        connect(voltageSource.p, bus1.p) annotation(
          Line(points = {{-70, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(pVSource.p, bus2.p) annotation(
          Line(points = {{4, -8}, {4, 16}, {12, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
      end Test_Radial_01_eq;
    end Examples;
  end SteadyState;

  package QuasiSteadyState
    package Machines
      package Interfaces
        extends Modelica.Icons.InterfacesPackage;

        model Inertia
          import Modelica.Units.SI;
          import Modelica.Constants;
          Modelica.Blocks.Interfaces.RealInput Pm(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput Pe(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput delta(start = 0, unit = "rad", displayUnit = "deg") annotation(
            Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {112, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput omega(start = 1.0, unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {112, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          //        protected
          outer OmniPES.SystemData data;
          parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
            Placement(visible = true, transformation(origin = {-78, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          parameter Modelica.Units.SI.Time H = smData.convData.H;
          parameter OmniPES.Units.PerUnit D = smData.convData.D;
        initial equation
          der(omega) = 0.0;
          der(delta) = 0.0;
        equation
          2*H*der(omega) = Pm - Pe - (if D > 0 then D*(omega - 1.0) else 0);
          der(delta) = data.wb*(omega - 1);
          annotation(
            Icon(graphics = {Text(origin = {-9, 0}, extent = {{-91, 80}, {109, -72}}, textString = "Inertia"), Rectangle(fillColor = {85, 87, 83}, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
        end Inertia;

        partial model PartialElectrical
          OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
            Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput Efd(start = 1.0, unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput delta(unit = "rad", displayUnit = "deg") annotation(
            Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Pt(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Qt(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          OmniPES.Units.CPerUnit Vqd(re(start = 1.0), im(start = 0.0));
          OmniPES.Units.CPerUnit Iqd;
          //(re(start = 1.0), im(start = 0.0));
          OmniPES.Units.CPerUnit Fqd;
          //(re(start = 0.0), im(start = 1.0));
          OmniPES.Units.CPerUnit Faqd;
          //(re(start = 0.0), im(start = 1.0));
          Modelica.Blocks.Interfaces.RealOutput Pe(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          //  OmniPES.Units.PerUnit Te(start=1.0);
          //        protected
          OmniPES.Units.CPerUnit St;
          parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
            Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          parameter OmniPES.Units.PerUnit ra = smData.convData.Ra;
          parameter OmniPES.Units.PerUnit xl = smData.convData.Xl;
          import Modelica.ComplexMath.j;
          import Modelica.ComplexMath.conj;
        initial equation
          der(delta) = 0.0;
        equation
          Vqd = OmniPES.Math.sys2qd(terminal.v, delta);
          Iqd = OmniPES.Math.sys2qd(-terminal.i, delta);
          St = Vqd*conj(Iqd);
          Pt = St.re;
          Qt = St.im;
//  Pe = Pt + ra * (terminal.i.re ^ 2 + terminal.i.im ^ 2);
          Vqd = -ra*Iqd - j*Fqd;
          Pe = Fqd.im*Iqd.re - Fqd.re*Iqd.im;
          Fqd = xl*Iqd + Faqd;
        end PartialElectrical;

        partial model Restriction
          outer OmniPES.SystemData data;
          parameter OmniPES.QuasiSteadyState.Machines.RestrictionData param;
          OmniPES.Units.PerUnit P;
          OmniPES.Units.PerUnit Q;
          OmniPES.Units.PerUnit V;
          Modelica.Units.SI.Angle theta;
        end Restriction;

        model Restriction_PQ
          extends OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction;
        initial equation
          P = param.Pesp/data.Sbase;
          Q = param.Qesp/data.Sbase;
        end Restriction_PQ;

        model Restriction_PV
          extends OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction;
        initial equation
          P = param.Pesp/data.Sbase;
          V = param.Vesp;
        end Restriction_PV;

        model Restriction_VTH
          extends OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction;
          import Modelica.Constants.pi;
        initial equation
          V = param.Vesp;
          theta = param.theta_esp;
        end Restriction_VTH;

        model Model_1_0_Electric
          extends OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical;
          OmniPES.Units.PerUnit F1d;//(start = 1.0);
        protected
          parameter OmniPES.Units.PerUnit x1d = smData.convData.X1d;
          parameter OmniPES.Units.PerUnit xd = smData.convData.Xd;
          parameter OmniPES.Units.PerUnit xq = smData.convData.Xq;
          parameter OmniPES.Units.PerUnit T1d0 = smData.convData.T1d0;
          OmniPES.Units.PerUnit Ifd;
        initial equation
          der(F1d) = 0;
        equation
          T1d0*der(F1d) = Efd - (xd - xl)*Ifd;
          Ifd = ((x1d - xd)/(xd - xl)*Faqd.im + F1d)/(x1d - xl);
          Faqd.im = (x1d - xl)*Iqd.im + F1d;
          Faqd.re = (xq - xl)*Iqd.re;
        end Model_1_0_Electric;

        model Model_2_1_Electric
          extends OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical;
          OmniPES.Units.PerUnit F1d(start = 1.0);
          OmniPES.Units.PerUnit Fkd(start = 1.0);
          OmniPES.Units.PerUnit Fkq(start = 0.0);
        protected
          parameter OmniPES.Units.PerUnit x2q = smData.convData.X2q;
          parameter OmniPES.Units.PerUnit x2d = smData.convData.X2d;
          parameter OmniPES.Units.PerUnit x1d = smData.convData.X1d;
          parameter OmniPES.Units.PerUnit xd = smData.convData.Xd;
          parameter OmniPES.Units.PerUnit xq = smData.convData.Xq;
          parameter OmniPES.Units.PerUnit T1d0 = smData.convData.T1d0;
          parameter OmniPES.Units.PerUnit T2q0 = smData.convData.T2q0;
          parameter OmniPES.Units.PerUnit T2d0 = smData.convData.T2d0;
          OmniPES.Units.PerUnit Ifd(start = 1.0), Ikd(start = 0.0);
          OmniPES.Units.PerUnit Ikq(start = 0.0);
        initial equation
          der(F1d) = 0;
          der(Fkd) = 0;
          der(Fkq) = 0;
        equation
          T1d0*der(F1d) = Efd - (xd - xl)*Ifd;
          T2d0*der(Fkd) = (x1d - xl)^2/(x2d - x1d)*Ikd;
          T2q0*der(Fkq) = (xq - xl)^2/(x2q - xq)*Ikq;
          Ifd = ((x1d - xd)/(xd - xl)*Faqd.im + F1d)/(x1d - xl);
          Ikd = (x2d - x1d)*(Faqd.im - Fkd)/(x2d - xl)/(x1d - xl);
          Ikq = (x2q - xq)*(Faqd.re - Fkq)/(x2q - xl)/(xq - xl);
          Faqd.im = (x2d - xl)*Iqd.im + (x2d - xl)*F1d/(x1d - xl) + (x1d - x2d)*Fkd/(x1d - xl);
          Faqd.re = (x2q - xl)*Iqd.re + (xq - x2q)/(xq - xl)*Fkq;
        end Model_2_1_Electric;

        model Model_2_2_Electric
          extends OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical;
          OmniPES.Units.PerUnit F1d(start = 1.0);
          OmniPES.Units.PerUnit Fkd(start = 1.0);
          OmniPES.Units.PerUnit Fgq(start = 1.0);
          OmniPES.Units.PerUnit Fkq(start = 1.0);
        protected
          parameter OmniPES.Units.PerUnit x2q = smData.convData.X2q;
          parameter OmniPES.Units.PerUnit x2d = smData.convData.X2d;
          parameter OmniPES.Units.PerUnit x1d = smData.convData.X1d;
          parameter OmniPES.Units.PerUnit x1q = smData.convData.X1q;
          parameter OmniPES.Units.PerUnit xd = smData.convData.Xd;
          parameter OmniPES.Units.PerUnit xq = smData.convData.Xq;
          parameter OmniPES.Units.PerUnit T1d0 = smData.convData.T1d0;
          parameter OmniPES.Units.PerUnit T1q0 = smData.convData.T1q0;
          parameter OmniPES.Units.PerUnit T2q0 = smData.convData.T2q0;
          parameter OmniPES.Units.PerUnit T2d0 = smData.convData.T2d0;
          OmniPES.Units.PerUnit Ifd, Ikd;
          OmniPES.Units.PerUnit Igq, Ikq;
        initial equation
          der(F1d) = 0;
          der(Fkd) = 0;
          der(Fgq) = 0;
          der(Fkq) = 0;
        equation
          T1d0*der(F1d) = Efd - (xd - xl)*Ifd;
          T2d0*der(Fkd) = (x1d - xl)^2/(x2d - x1d)*Ikd;
          T1q0*der(Fgq) = (xq - xl)^2/(x1q - xq)*Igq;
          T2q0*der(Fkq) = (x1q - xl)^2/(x2q - x1q)*Ikq;
          Ifd = ((x1d - xd)/(xd - xl)*Faqd.im + F1d)/(x1d - xl);
          Ikd = (x2d - x1d)*(Faqd.im - Fkd)/(x2d - xl)/(x1d - xl);
          Igq = (x1q - xq)*(Faqd.re - Fgq)/(x1q - xl)/(xq - xl);
          Ikq = (x2q - x1q)*(Faqd.re - Fkq)/(x2q - xl)/(x1q - xl);
          Faqd.im = (x2d - xl)*Iqd.im + (x2d - xl)*F1d/(x1d - xl) + (x1d - x2d)*Fkd/(x1d - xl);
          Faqd.re = (x2q - xl)*Iqd.re + (x1q - x2q)/(x1q - xl)*Fkq + (x2q - xl)*(xq - x1q)/(x1q - xl)/(xq - xl)*Fgq;
        end Model_2_2_Electric;

        model Classical_Electric
          OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
            Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput Efd(start = 1.0, unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput delta(start = 0.0, unit = "rad", displayUnit = "deg") annotation(
            Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Pt(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Qt(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          OmniPES.Units.CPerUnit Vt(re(start = 1.0), im(start = 0.0));
          OmniPES.Units.CPerUnit Ia(re(start = 0.0), im(start = 0.0));
          Modelica.Blocks.Interfaces.RealOutput Pe(unit = "pu") annotation(
            Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          //  OmniPES.Units.PerUnit Te(start=1.0);
          //        protected
          OmniPES.Units.CPerUnit St;
          OmniPES.Units.CPerUnit E1;
          parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
            Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          import Modelica.ComplexMath.j;
          import Modelica.ComplexMath.conj;
          import Modelica.ComplexMath.abs;
          import Modelica.ComplexMath.exp;
        equation
          Vt = terminal.v;
          Ia = -terminal.i;
          St = Vt*conj(Ia);
          Pt = St.re;
          Qt = St.im;
          Pe = E1.re*Ia.re + E1.im*Ia.im;
          E1 = Vt + Complex(smData.convData.Ra, smData.convData.X1d)*Ia;
          Efd = abs(E1);
//  E1.im = E1.re*tan(delta);
//  delta = atan2(E1.im, E1.re);
          delta = Modelica.ComplexMath.arg(E1);
        end Classical_Electric;
      end Interfaces;

      model Classical_SynchronousMachine
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
          Placement(visible = true, transformation(origin = {-78, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs "Record with load flow specs." annotation(
          Placement(visible = true, transformation(origin = {-126, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
          Placement(visible = true, transformation(origin = {-144, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.Interfaces.Inertia inertia(smData = smData) annotation(
          Placement(visible = true, transformation(origin = {57, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.Interfaces.Classical_Electric electrical(smData = smData) annotation(
          Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
        replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction restriction constrainedby OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction(param = specs) annotation(
           choicesAllMatching = true,
           Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
      equation
        der(inertia.Pm) = 0.0;
        der(electrical.Efd) = 0.0;
        restriction.P = electrical.Pt;
        restriction.Q = electrical.Qt;
        restriction.V = Modelica.ComplexMath.abs(terminal.v);
        terminal.v.re*tan(restriction.theta) = terminal.v.im;
        connect(inertia.delta, electrical.delta) annotation(
          Line(points = {{74, 6.5}, {88, 6.5}, {88, 38}, {-82, 38}, {-82, 18}, {-67, 18}, {-67, 19}}, color = {0, 0, 127}));
        connect(electrical.Pe, inertia.Pe) annotation(
          Line(points = {{-12, 0}, {40, 0}}, color = {0, 0, 127}));
        connect(terminal, electrical.terminal) annotation(
          Line(points = {{-144, 0}, {-63, 0}}, color = {0, 0, 255}));
        annotation(
          Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}, endAngle = 360), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text(origin = {10, 27}, extent = {{72, -67}, {-30, 13}}, textString = "SM")}, coordinateSystem(initialScale = 0.1)));
      end Classical_SynchronousMachine;

      record SynchronousMachineData
        extends Modelica.Icons.Record;
        import OmniPES.Units;
        parameter Units.ApparentPower MVAs = 100 "System base power" annotation(
          Dialog(group = "Base Quatities"));
        parameter Units.ApparentPower MVAb = 100 "Machine base power" annotation(
          Dialog(group = "Base Quatities"));
        parameter Integer Nmaq = 1 "Number of parallel machines" annotation(
          Dialog(group = "Base Quatities"));
        parameter Units.PerUnit Ra = 0.0 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit Xl = 0.0 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit Xd = 1.0 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit Xq = 0.8 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit X1d = 0.2 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit X1q = 0.2 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit X2d = 0.02 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit X2q = 0.02 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit T1d0 = 5.0 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit T2d0 = 0.01 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit T1q0 = 0.3 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit T2q0 = 0.01 annotation(
          Dialog(group = "Electrical Data"));
        parameter Units.PerUnit H = 5.0 annotation(
          Dialog(group = "Mechanical Data"));
        parameter Units.PerUnit D = 0.0 annotation(
          Dialog(group = "Mechanical Data"));

        record ConvertedData
          parameter Units.PerUnit Ra annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit Xl annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit Xd annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit Xq annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit X1d annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit X1q annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit X2d annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit X2q annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit T1d0 annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit T2d0 annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit T1q0 annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit T2q0 annotation(
            Dialog(group = "Electrical Data"));
          parameter Units.PerUnit H annotation(
            Dialog(group = "Mechanical Data"));
          parameter Units.PerUnit D annotation(
            Dialog(group = "Mechanical Data"));
        end ConvertedData;

        ConvertedData convData(Ra = MVAs/MVAb/Nmaq*Ra, Xl = MVAs/MVAb/Nmaq*Xl, Xd = MVAs/MVAb/Nmaq*Xd, Xq = MVAs/MVAb/Nmaq*Xq, X1d = MVAs/MVAb/Nmaq*X1d, X1q = MVAs/MVAb/Nmaq*X1q, X2d = MVAs/MVAb/Nmaq*X2d, X2q = MVAs/MVAb/Nmaq*X2q, H = Nmaq*MVAb/MVAs*H, D = Nmaq*MVAb/MVAs*D, T1d0 = T1d0, T1q0 = T1q0, T2d0 = T2d0, T2q0 = T2q0);
        //        annotation(
        //          Icon(coordinateSystem(initialScale = 0.2, grid = {0.5, 0.5})),
        //  Diagram(coordinateSystem(extent = {{-100, -150}, {100, 100}})));
        annotation(
          defaultComponentName = "smData",
          defaultVariability = "Parameter");
      end SynchronousMachineData;

      record RestrictionData
        extends Modelica.Icons.Record;
        import OmniPES.Units;
        parameter Units.ActivePower Pesp = 0.0 "Generated Active Power" annotation(
          Dialog(group = "Steady-State Specifications"));
        parameter Units.ReactivePower Qesp = 0.0 "Generated Rective Power" annotation(
          Dialog(group = "Steady-State Specifications"));
        parameter Units.PerUnit Vesp = 1.0 "Bus voltage magnitude" annotation(
          Dialog(group = "Steady-State Specifications"));
        parameter Modelica.Units.SI.Angle theta_esp(displayUnit = "deg") = 0 "Bus voltage angle" annotation(
          Dialog(group = "Steady-State Specifications"));
      end RestrictionData;

      model GenericSynchronousMachine
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
          Placement(visible = true, transformation(origin = {-74, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs "Record with load flow specs." annotation(
          Placement(visible = true, transformation(origin = {-126, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
          Placement(visible = true, transformation(origin = {-144, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.Interfaces.Inertia inertia(smData = smData) annotation(
          Placement(visible = true, transformation(origin = {57, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical electrical annotation(
          Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0))) constrainedby OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical(smData = smData) annotation(
           choicesAllMatching = true,
           Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
        replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction restriction constrainedby OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction(param = specs) annotation(
           choicesAllMatching = true,
           Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR avr annotation(
          Placement(visible = true, transformation(origin = {-96, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator sreg annotation(
          Placement(visible = true, transformation(origin = {58, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS pss annotation(
          Placement(visible = true, transformation(origin = {-56, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      equation
        restriction.P = electrical.Pt;
        restriction.Q = electrical.Qt;
        restriction.V = Modelica.ComplexMath.abs(terminal.v);
        restriction.theta = Modelica.ComplexMath.arg(terminal.v);
        avr.Vctrl = restriction.V;
        connect(inertia.delta, electrical.delta) annotation(
          Line(points = {{74, 6.5}, {88, 6.5}, {88, 38}, {-82, 38}, {-82, 18}, {-65, 18}, {-65, 19}, {-49, 19}}, color = {0, 0, 127}));
        connect(electrical.Pe, inertia.Pe) annotation(
          Line(points = {{6, 0}, {40, 0}}, color = {0, 0, 127}));
        connect(terminal, electrical.terminal) annotation(
          Line(points = {{-144, 0}, {-45, 0}}, color = {0, 0, 255}));
        connect(sreg.wctrl, inertia.omega) annotation(
          Line(points = {{69, -44}, {86, -44}, {86, -8}, {74, -8}}, color = {0, 0, 127}));
        connect(sreg.Pm, inertia.Pm) annotation(
          Line(points = {{47, -44}, {24, -44}, {24, -12}, {40, -12}}, color = {0, 0, 127}));
        connect(pss.omega, inertia.omega) annotation(
          Line(points = {{-44, -70}, {90, -70}, {90, -8}, {74, -8}, {74, -8}}, color = {0, 0, 127}));
        connect(pss.Vsad, avr.Vsad) annotation(
          Line(points = {{-68, -70}, {-134, -70}, {-134, -26}, {-107, -26}}, color = {0, 0, 127}));
        connect(avr.Efd, electrical.Efd) annotation(
          Line(points = {{-85, -20}, {-68, -20}, {-68, -19}, {-49, -19}}, color = {0, 0, 127}));
        annotation(
          Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}, endAngle = 360), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text(origin = {10, 27}, extent = {{72, -67}, {-30, 13}}, textString = "SM")}, coordinateSystem(initialScale = 0.1)));
      end GenericSynchronousMachine;
      annotation(
        Icon(coordinateSystem(initialScale = 0.4, grid = {0.5, 0.5}), graphics = {Ellipse(origin = {14, -5}, lineThickness = 1, extent = {{-114, 105}, {86, -95}}, endAngle = 360), Line(origin = {-28.88, 28.79}, points = {{-31.1188, -28.7929}, {-27.1188, -8.79289}, {-21.1188, 11.2071}, {-9.1188, 27.2071}, {8.88124, 27.2071}, {18.8812, 11.2071}, {24.8812, -8.79289}, {28.8812, -28.7929}}, thickness = 1, smooth = Smooth.Bezier), Line(origin = {31.12, -29.21}, points = {{-31.1188, 28.7929}, {-27.1188, 8.79289}, {-21.1188, -11.2071}, {-11.1188, -29.2071}, {8.88124, -29.2071}, {18.8812, -11.2071}, {24.8812, 8.79289}, {28.8812, 28.7929}}, thickness = 1, smooth = Smooth.Bezier)}),
        Diagram(coordinateSystem(extent = {{-100, -150}, {100, 100}})));
    end Machines;

    package Controllers
      package Interfaces
        extends Modelica.Icons.InterfacesPackage;

        partial model PartialAVR
          Modelica.Blocks.Interfaces.RealInput Vctrl annotation(
            Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput Vsad annotation(
            Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Efd(start=2.0) annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          annotation(
            Icon(graphics = {Text(extent = {{-100, 60}, {100, -60}}, textString = "AVR"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
        end PartialAVR;

        partial model PartialSpeedRegulator
          Modelica.Blocks.Interfaces.RealInput wctrl annotation(
            Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Pm annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          annotation(
            Icon(graphics = {Text(extent = {{-100, 60}, {100, -60}}, textString = "SR"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
        end PartialSpeedRegulator;

        partial model PartialPSS
          Modelica.Blocks.Interfaces.RealInput omega annotation(
            Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Vsad annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          annotation(
            Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -10}, extent = {{-100, 50}, {100, -50}}, textString = "PSS")}));
        end PartialPSS;
      end Interfaces;

      package AVR
        // IEEE Std 421.5-2005 - "IEEE Recommended Practice for Excitation System Models for Power System Stability Studies"

        model ConstantEfd
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
        equation
          der(Efd) = 0;
        end ConstantEfd;
      end AVR;

      package SpeedRegulators
        model ConstantPm
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator;
        equation
          der(Pm) = 0;
        end ConstantPm;
      end SpeedRegulators;

      package PSS
        model NoPSS
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS;
        equation
          Vsad = 0;
        end NoPSS;
      end PSS;
    end Controllers;

    package Loads
      package Interfaces
        extends Modelica.Icons.InterfacesPackage;

        partial model PartialSteadyStateZIP
          extends OmniPES.QuasiSteadyState.Loads.Interfaces.PartialSteadyStateLoad;
          import Modelica.ComplexMath.conj;
        equation
          if initial() then
            Modelica.ComplexMath.real(v*conj(i)) = Pesp/data.Sbase*(1 - par.pi - par.pz + par.pi*(Vo/par.Vdef) + par.pz*(Vo/par.Vdef)^2);
            Modelica.ComplexMath.imag(v*conj(i)) = Qesp/data.Sbase*(1 - par.qi - par.qz + par.qi*(Vo/par.Vdef) + par.qz*(Vo/par.Vdef)^2);
          end if;
        end PartialSteadyStateZIP;

        partial model PartialDynamicZIP
          extends OmniPES.QuasiSteadyState.Loads.Interfaces.PartialDynamicLoad;
          import Modelica.ComplexMath.conj;
        equation
          Modelica.ComplexMath.real(v*conj(i)) = Pesp/data.Sbase*(1 - par.pi - par.pz + par.pi*(Vabs/Vo) + par.pz*(Vabs/Vo)^2);
          Modelica.ComplexMath.imag(v*conj(i)) = Qesp/data.Sbase*(1 - par.qi - par.qz + par.qi*(Vabs/Vo) + par.qz*(Vabs/Vo)^2);
        end PartialDynamicZIP;

        record LoadData
          extends Modelica.Icons.Record;
          parameter Real pi = 0;
          parameter Real pz = 0;
          parameter Real qi = 0;
          parameter Real qz = 0;
          annotation(
            defaultComponentPrefixes = "parameter");
        end LoadData;

        partial model PartialSteadyStateLoad
          parameter OmniPES.Units.ActivePower Pesp "Specified active power [MW]";
          parameter OmniPES.Units.ReactivePower Qesp "Specified reactive power [Mvar]";
          parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData par;
          Modelica.ComplexBlocks.Interfaces.ComplexInput v annotation(
            Placement(visible = true, transformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.ComplexBlocks.Interfaces.ComplexInput i annotation(
            Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealOutput Vo(start = 1.0) annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        protected
          outer OmniPES.SystemData data;
          import Modelica.ComplexMath.conj;
          //  assert(Vo > 0,"ERROR: Vo cannot be negative.");
        equation
          if initial() then
            Vo^2 = v.re^2 + v.im^2;
          else
            der(Vo) = 0;
          end if;
        end PartialSteadyStateLoad;

        partial model PartialDynamicLoad
          parameter OmniPES.Units.ActivePower Pesp "Specified active power [MW]";
          parameter OmniPES.Units.ReactivePower Qesp "Specified reactive power [Mvar]";
          parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData par;
          Modelica.ComplexBlocks.Interfaces.ComplexInput v annotation(
            Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput Vo annotation(
            Placement(visible = true, transformation(origin = {-122, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
          Modelica.ComplexBlocks.Interfaces.ComplexInput i annotation(
            Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          //  OmniPES.Units.CPerUnit S;
          outer OmniPES.SystemData data;
          import Modelica.ComplexMath.conj;
          OmniPES.Units.PerUnit Vabs(start = 1.0);
        equation
//  S = v * conj(i);
          Vabs^2 = v.re^2 + v.im^2;
        end PartialDynamicLoad;
      end Interfaces;

      model ZIPLoad
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        parameter OmniPES.Units.ActivePower Pesp "Specified active power [MW]";
        parameter OmniPES.Units.ReactivePower Qesp "Specified reactive power [Mvar]";
        parameter OmniPES.Units.PerUnit Vdef = 1.0;
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dyn_par = OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData(pz = 1, qz = 1, pi = 0, qi = 0) annotation(
          Placement(visible = true, transformation(origin = {-70, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ss_par = OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData() annotation(
          Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Units.CPerUnit S;
        OmniPES.Units.PerUnit Vabs(start = 1);
        OmniPES.Units.PerUnit Vo(start = 1);
        import Modelica.ComplexMath.conj;
        outer OmniPES.SystemData data;
      initial equation
        der(Vo) = 0;
      equation
        S = v*conj(i);
        Vabs^2 = v.re^2 + v.im^2;
        der(Vo) = if initial() then Vabs - Vo else 0;
  S.re = if initial() then Pesp/data.Sbase*(1 - ss_par.pi - ss_par.pz + ss_par.pi*(Vo/Vdef) + ss_par.pz*(Vo/Vdef)^2) else Pesp/data.Sbase*(1 - dyn_par.pi - dyn_par.pz + dyn_par.pi*(Vabs/Vo) + dyn_par.pz*(Vabs/Vo)^2);
  S.im = if initial() then Qesp/data.Sbase*(1 - ss_par.qi - ss_par.qz + ss_par.qi*(Vo/Vdef) + ss_par.qz*(Vo/Vdef)^2) else Qesp/data.Sbase*(1 - dyn_par.qi - dyn_par.qz + dyn_par.qi*(Vabs/Vo) + dyn_par.qz*(Vabs/Vo)^2);
      //  if initial() then
      //    S.re = Pesp/data.Sbase*(1 - ss_par.pi - ss_par.pz + ss_par.pi*(Vo/Vdef) + ss_par.pz*(Vo/Vdef)^2);
      //    S.im = Qesp/data.Sbase*(1 - ss_par.qi - ss_par.qz + ss_par.qi*(Vo/Vdef) + ss_par.qz*(Vo/Vdef)^2);
      //  else
      //    S.re = Pesp/data.Sbase*(1 - dyn_par.pi - dyn_par.pz + dyn_par.pi*(Vabs/Vo) + dyn_par.pz*(Vabs/Vo)^2);
      //    S.im = Qesp/data.Sbase*(1 - dyn_par.qi - dyn_par.qz + dyn_par.qi*(Vabs/Vo) + dyn_par.qz*(Vabs/Vo)^2);
      //  end if;
        annotation(
          Icon(graphics = {Text(origin = {1, 2.84217e-14}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}));
      end ZIPLoad;
    end Loads;

    package Examples
      extends Modelica.Icons.ExamplesPackage;

      model Test_Radial_System
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-98, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 500., Qesp = 0.0, Vesp = 1.03, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {52, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.040) annotation(
          Placement(visible = true, transformation(origin = {2, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-86, 22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.040) annotation(
          Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
          Placement(visible = true, transformation(origin = {-66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare OmniPES.QuasiSteadyState.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {74, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {82, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Switches.Fault fault(t_off = 100.2, t_on = 100.1)  annotation(
          Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(impedance.p, bus3.p) annotation(
          Line(points = {{12, 22}, {49.2, 22}, {49.2, 18}}, color = {0, 0, 255}));
        connect(impedance.n, bus2.p) annotation(
          Line(points = {{-8, 22}, {-46, 22}, {-46, 18.4}}, color = {0, 0, 255}));
        connect(impedance2.p, bus2.p) annotation(
          Line(points = {{-56.4, 20}, {-46.8, 20}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(bus3.p, SM.terminal) annotation(
          Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 20}, {64, 20}}, color = {0, 0, 255}));
        connect(impedance2.n, bus1.p) annotation(
          Line(points = {{-76, 20}, {-86, 20}, {-86, 20}, {-86, 20}}, color = {0, 0, 255}));
        connect(voltageSource.p, bus1.p) annotation(
          Line(points = {{-98, 20}, {-86, 20}, {-86, 20}, {-86, 20}}, color = {0, 0, 255}));
        connect(impedance1.n, bus2.p) annotation(
          Line(points = {{-8, 0}, {-32, 0}, {-32, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(impedance1.p, bus3.p) annotation(
          Line(points = {{12, 0}, {32, 0}, {32, 18}, {50, 18}}, color = {0, 0, 255}));
        connect(impedance1.n, fault.T) annotation(
          Line(points = {{-8, 0}, {-10, 0}, {-10, -20}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")));
      end Test_Radial_System;

      model Test_Radial_System_CTRL
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.025, X2q = 0.025, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {70, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-110, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 500., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {32, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.04) annotation(
          Placement(visible = true, transformation(origin = {6, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
          Placement(visible = true, transformation(origin = {-64, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {76, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
            Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
          connect(Rectifier.y, limiter.u) annotation(
            Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(add3.y, LeadLag.u) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag.y, Rectifier.u) annotation(
            Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance1(x = 0.04) annotation(
          Placement(visible = true, transformation(origin = {6, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Switches.Fault fault(X = 1e-4, t_off = 0.2, t_on = 0.1) annotation(
          Placement(visible = true, transformation(origin = {-22, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-90, 16}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
      equation
        connect(impedance.p, bus3.p) annotation(
          Line(points = {{16, 18}, {49.2, 18}}, color = {0, 0, 255}));
        connect(impedance.n, bus2.p) annotation(
          Line(points = {{-4, 18}, {-46, 18}, {-46, 18.4}}, color = {0, 0, 255}));
        connect(impedance2.p, bus2.p) annotation(
          Line(points = {{-54, 18}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(bus3.p, SM.terminal) annotation(
          Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 20}, {66, 20}}, color = {0, 0, 255}));
        connect(seriesImpedance1.n, bus2.p) annotation(
          Line(points = {{-4, -2}, {-32, -2}, {-32, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(seriesImpedance1.p, bus3.p) annotation(
          Line(points = {{16, -2}, {32, -2}, {32, 18}, {50, 18}}, color = {0, 0, 255}));
  connect(seriesImpedance1.n, fault.T) annotation(
          Line(points = {{-4, -2}, {-22, -2}, {-22, -30}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus1.p) annotation(
          Line(points = {{-110, 6}, {-112, 6}, {-112, 14}, {-90, 14}}, color = {0, 0, 255}));
  connect(bus1.p, impedance2.n) annotation(
          Line(points = {{-90, 14}, {-74, 14}, {-74, 18}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")),
  Diagram);
      end Test_Radial_System_CTRL;

      model Kundur_Two_Area_System
        Real d13, d23, d43;
        inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
          Placement(visible = true, transformation(origin = {-1, 67}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_1(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {-202, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus7 annotation(
          Placement(visible = true, transformation(origin = {-108, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus8 annotation(
          Placement(visible = true, transformation(origin = {-30, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G3(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_2, specs = gen3_specs) annotation(
          Placement(visible = true, transformation(origin = {218, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G4(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_2, specs = gen4_specs) annotation(
          Placement(visible = true, transformation(origin = {168, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G2(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_1, specs = gen2_specs) annotation(
          Placement(visible = true, transformation(origin = {-214, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G1(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_1, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {-258, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen3_specs( Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {222, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {-254, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen4_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {172, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen2_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {-204, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {-66, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine1(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine2(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {16, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
          Placement(visible = true, transformation(origin = {-212, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.15*100/900) annotation(
          Placement(visible = true, transformation(origin = {176, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.15*100/900) annotation(
          Placement(visible = true, transformation(origin = {-162, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1, k3 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(strict = false, u(start = 1), uMax = 4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Gain gain(k = 200) annotation(
            Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0.0) annotation(
            Placement(visible = true, transformation(origin = {-134, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{87, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
          connect(gain.y, limiter.u) annotation(
            Line(points = {{27, 0}, {64, 0}}, color = {0, 0, 127}));
          connect(add3.y, gain.u) annotation(
            Line(points = {{-32, 0}, {4, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-122, 0}, {-102, 0}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor(NominalPower = 200) annotation(
          Placement(visible = true, transformation(origin = {-128, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor1(NominalPower = 350) annotation(
          Placement(visible = true, transformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.QuasiSteadyState.Loads.ZIPLoad L1(Pesp = 967, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ssLoadData(pi = 0, qz = 0) annotation(
          Placement(visible = true, transformation(origin = {-130, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dynLoadData(pi = 0, pz = 1, qz = 1) annotation(
          Placement(visible = true, transformation(origin = {-96, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Loads.ZIPLoad L2(Pesp = 1767, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {64, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

        model PSS_1
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS;
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
            Placement(visible = true, transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 0.2, uMin = -0.2) annotation(
            Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(omega, gain.u) annotation(
            Line(points = {{-120, 0}, {-86, 0}}, color = {0, 0, 127}));
          connect(gain.y, Washout.u) annotation(
            Line(points = {{-63, 0}, {-50, 0}}, color = {0, 0, 127}));
          connect(Washout.y, LeadLag1.u) annotation(
            Line(points = {{-27, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag1.y, LeadLag2.u) annotation(
            Line(points = {{11, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(LeadLag2.y, limiter.u) annotation(
            Line(points = {{52, 0}, {68, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Vsad) annotation(
            Line(points = {{91, 0}, {110, 0}}, color = {0, 0, 127}));
        end PSS_1;

        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_2(D = 0, H = 6.175, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Switches.Fault fault(R = 1e-5, X = 1e-1, t_off = 0.3, t_on = 0.2) annotation(
          Placement(visible = true, transformation(origin = {-30, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine_switched tLine21(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {16, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        d13 = G1.inertia.delta - G3.inertia.delta;
        d23 = G2.inertia.delta - G3.inertia.delta;
        d43 = G4.inertia.delta - G3.inertia.delta;
        connect(G1.terminal, bus1.p) annotation(
          Line(points = {{-248, 18}, {-230, 18}}, color = {0, 0, 255}));
        connect(trafo.p, bus1.p) annotation(
          Line(points = {{-222, 18}, {-230, 18}}, color = {0, 0, 255}));
        connect(trafo.n, bus5.p) annotation(
          Line(points = {{-202, 18}, {-199, 18}, {-199, 16}, {-196, 16}}, color = {0, 0, 255}));
        connect(tLine7.p, bus5.p) annotation(
          Line(points = {{-178, 20}, {-187, 20}, {-187, 16}, {-196, 16}}, color = {0, 0, 255}));
        connect(tLine7.n, bus6.p) annotation(
          Line(points = {{-156, 20}, {-154, 20}, {-154, 16}, {-150, 16}}, color = {0, 0, 255}));
        connect(tLine6.p, bus6.p) annotation(
          Line(points = {{-138, 18}, {-144, 18}, {-144, 16}, {-150, 16}}, color = {0, 0, 255}));
        connect(tLine6.n, bus7.p) annotation(
          Line(points = {{-116, 18}, {-108, 18}, {-108, 16}}, color = {0, 0, 255}));
        connect(tLine.p, bus7.p) annotation(
          Line(points = {{-76, 28}, {-94, 28}, {-94, 16}, {-108, 16}}, color = {0, 0, 255}));
        connect(tLine1.p, bus7.p) annotation(
          Line(points = {{-76, 2}, {-94, 2}, {-94, 16}, {-108, 16}}, color = {0, 0, 255}));
        connect(tLine.n, bus8.p) annotation(
          Line(points = {{-54, 28}, {-46, 28}, {-46, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine1.n, bus8.p) annotation(
          Line(points = {{-54, 2}, {-46, 2}, {-46, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine2.p, bus8.p) annotation(
          Line(points = {{6, 28}, {-18, 28}, {-18, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine2.n, bus9.p) annotation(
          Line(points = {{28, 28}, {42, 28}, {42, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(tLine4.p, bus9.p) annotation(
          Line(points = {{78, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(tLine4.n, bus10.p) annotation(
          Line(points = {{100, 16}, {108, 16}, {108, 14}}, color = {0, 0, 255}));
        connect(tLine5.p, bus10.p) annotation(
          Line(points = {{122, 16}, {115, 16}, {115, 14}, {108, 14}}, color = {0, 0, 255}));
        connect(tLine5.n, bus11.p) annotation(
          Line(points = {{144, 16}, {148, 16}, {148, 14}, {154, 14}}, color = {0, 0, 255}));
        connect(impedance.p, bus11.p) annotation(
          Line(points = {{166, 14}, {154, 14}}, color = {0, 0, 255}));
        connect(impedance.n, bus3.p) annotation(
          Line(points = {{186, 14}, {198, 14}}, color = {0, 0, 255}));
        connect(G3.terminal, bus3.p) annotation(
          Line(points = {{208, 14}, {198, 14}}, color = {0, 0, 255}));
        connect(G4.terminal, bus4.p) annotation(
          Line(points = {{158, -18}, {154, -18}, {154, -20}, {150, -20}}, color = {0, 0, 255}));
        connect(impedance2.n, bus4.p) annotation(
          Line(points = {{140, -20}, {150, -20}}, color = {0, 0, 255}));
        connect(impedance2.p, bus10.p) annotation(
          Line(points = {{120, -20}, {108, -20}, {108, 14}}, color = {0, 0, 255}));
        connect(shunt_Capacitor1.p, bus9.p) annotation(
          Line(points = {{84, -14}, {70, -14}, {70, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(L2.p, bus9.p) annotation(
          Line(points = {{64, -20}, {64, 16}}, color = {0, 0, 255}));
        connect(fault.T, bus8.p) annotation(
          Line(points = {{-30, -18}, {-30, 16}}, color = {0, 0, 255}));
        connect(L1.p, bus7.p) annotation(
          Line(points = {{-108, -20}, {-108, 16}}, color = {0, 0, 255}));
        connect(shunt_Capacitor.p, bus7.p) annotation(
          Line(points = {{-128, -16}, {-114, -16}, {-114, 16}, {-108, 16}}, color = {0, 0, 255}));
        connect(impedance1.n, bus6.p) annotation(
          Line(points = {{-152, -8}, {-150, -8}, {-150, 16}}, color = {0, 0, 255}));
        connect(impedance1.p, bus2.p) annotation(
          Line(points = {{-172, -8}, {-186, -8}}, color = {0, 0, 255}));
        connect(G2.terminal, bus2.p) annotation(
          Line(points = {{-204, -8}, {-186, -8}}, color = {0, 0, 255}));
        connect(bus8.p, tLine21.p) annotation(
          Line(points = {{-30, 16}, {-18, 16}, {-18, -4}, {6, -4}}, color = {0, 0, 255}));
        connect(tLine21.n, bus9.p) annotation(
          Line(points = {{28, -4}, {42, -4}, {42, 16}, {64, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
      end Kundur_Two_Area_System;

      model Test_Generic_Load
        inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
          Placement(visible = true, transformation(origin = {-117, 81}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Loads.ZIPLoad zip(Pesp = 100., Qesp = 50., ss_par = ssData, dyn_par = dynData) annotation(
          Placement(visible = true, transformation(origin = {95, -3}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(magnitude = 1.09) annotation(
          Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ssData(pi = 0, pz = 0, qi = 0, qz = 0) annotation(
          Placement(visible = true, transformation(origin = {68, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.30) annotation(
          Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dynData(pi = 0, pz = 1, qi = 0, qz = 1) annotation(
          Placement(visible = true, transformation(origin = {92, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus annotation(
          Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.30) annotation(
          Placement(visible = true, transformation(origin = {-24, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Scopes.Ammeter ammeter annotation(
          Placement(visible = true, transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Switches.TimedBreaker brk1(t_open = 0.2) annotation(
          Placement(visible = true, transformation(origin = {4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(impedance.p, voltageSource.p) annotation(
          Line(points = {{-33.6, 0}, {-85.6, 0}}, color = {0, 0, 255}));
        connect(impedance.n, bus.p) annotation(
          Line(points = {{-14, -0.2}, {28, -0.2}, {28, -2.2}}, color = {0, 0, 255}));
        connect(impedance1.p, impedance.p) annotation(
          Line(points = {{-33.6, -22}, {-39.6, -22}, {-39.6, 0}, {-33.6, 0}, {-33.6, 0}}, color = {0, 0, 255}));
        connect(bus.p, ammeter.p) annotation(
          Line(points = {{27.8, -2}, {37.8, -2}, {37.8, -2}, {37.8, -2}}, color = {0, 0, 255}));
        connect(ammeter.n, zip.p) annotation(
          Line(points = {{58, -2.2}, {63, -2.2}, {63, -3}, {80, -3}}, color = {0, 0, 255}));
        connect(impedance1.n, brk1.p) annotation(
          Line(points = {{-14, -22}, {-6, -22}}, color = {0, 0, 255}));
        connect(brk1.n, bus.p) annotation(
          Line(points = {{14, -22}, {16, -22}, {16, -2}, {28, -2}}, color = {0, 0, 255}));
      protected
        annotation(
          Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-6, Interval = 0.006));
      end Test_Generic_Load;

      model Test_Generic_Load_Default
        inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
          Placement(visible = true, transformation(origin = {-117, 81}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Loads.ZIPLoad zip(Pesp = 100., Qesp = 50.) annotation(
          Placement(visible = true, transformation(origin = {87, -3}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(magnitude = 1.09) annotation(
          Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.30) annotation(
          Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus annotation(
          Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.30) annotation(
          Placement(visible = true, transformation(origin = {-24, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Scopes.Ammeter ammeter annotation(
          Placement(visible = true, transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Switches.TimedBreaker brk1(t_open = 0.5) annotation(
          Placement(visible = true, transformation(origin = {6, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(impedance.p, voltageSource.p) annotation(
          Line(points = {{-33.6, 0}, {-85.6, 0}}, color = {0, 0, 255}));
        connect(impedance.n, bus.p) annotation(
          Line(points = {{-14, -0.2}, {28, -0.2}, {28, -2.2}}, color = {0, 0, 255}));
        connect(impedance1.p, impedance.p) annotation(
          Line(points = {{-33.6, -22}, {-39.6, -22}, {-39.6, 0}, {-33.6, 0}, {-33.6, 0}}, color = {0, 0, 255}));
        connect(bus.p, ammeter.p) annotation(
          Line(points = {{27.8, -2}, {37.8, -2}, {37.8, -2}, {37.8, -2}}, color = {0, 0, 255}));
        connect(ammeter.n, zip.p) annotation(
          Line(points = {{58, -2.2}, {63, -2.2}, {63, -3}, {76, -3}}, color = {0, 0, 255}));
        connect(impedance1.n, brk1.p) annotation(
          Line(points = {{-14, -22}, {-4, -22}}, color = {0, 0, 255}));
        connect(brk1.n, bus.p) annotation(
          Line(points = {{16, -22}, {22, -22}, {22, -2}, {28, -2}}, color = {0, 0, 255}));
      protected
        annotation(
          Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
          experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-6, Interval = 0.006));
      end Test_Generic_Load_Default;

      model Test_Generic_Machine_2
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-74, 80}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 10, H = 5, MVAb = 100, Nmaq = 1, Ra = 0.0, X1d = 0.2, X1q = 0.2, Xd = 1.0, Xl = 0.0, Xq = 0.8) annotation(
          Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 80., Qesp = 0, Vesp = 1.05) annotation(
          Placement(visible = true, transformation(origin = {24, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare OmniPES.QuasiSteadyState.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM2(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction, redeclare OmniPES.QuasiSteadyState.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {-72, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen2_specs(Pesp = 0., Qesp = 0, Vesp = 1.0, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TwoWindingTransformer twoWindingTransformer(tap = 1, x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 50, r = 1e-5, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {0, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(SM2.terminal, twoWindingTransformer.p) annotation(
          Line(points = {{-62, 20}, {-50, 20}}, color = {0, 0, 255}));
        connect(twoWindingTransformer.n, tLine.p) annotation(
          Line(points = {{-28, 20}, {-10, 20}}, color = {0, 0, 255}));
        connect(tLine.n, SM.terminal) annotation(
          Line(points = {{12, 20}, {30, 20}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Test_Generic_Machine_2;

      model Test_Breaker
        OmniPES.Circuit.Switches.Fault fault annotation(
          Placement(visible = true, transformation(origin = {38, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
          Placement(visible = true, transformation(origin = {-74, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.QuasiSteadyState.Loads.ZIPLoad zIPLoad(Pesp = 100, Qesp = 50) annotation(
          Placement(visible = true, transformation(origin = {12, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Circuit.Switches.TimedBreaker timedBreaker(t_open = 0.6) annotation(
          Placement(visible = true, transformation(origin = {-14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        inner SystemData data annotation(
          Placement(visible = true, transformation(origin = {-62, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(timedBreaker.n, fault.T) annotation(
          Line(points = {{-4, 0}, {38, 0}, {38, -4}}, color = {0, 0, 255}));
        connect(zIPLoad.p, timedBreaker.n) annotation(
          Line(points = {{12, -6}, {-4, -6}, {-4, 0}}, color = {0, 0, 255}));
        connect(voltageSource.p, seriesImpedance.p) annotation(
          Line(points = {{-74, 0}, {-60, 0}}, color = {0, 0, 255}));
        connect(seriesImpedance.n, timedBreaker.p) annotation(
          Line(points = {{-40, 0}, {-24, 0}}, color = {0, 0, 255}));
      end Test_Breaker;

      model Test_Radial_System_SWITCHED
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.025, X2q = 0.025, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {80, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-88, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {52, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {0, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {-66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {72, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
            Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
          connect(Rectifier.y, limiter.u) annotation(
            Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(add3.y, LeadLag.u) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag.y, Rectifier.u) annotation(
            Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        OmniPES.QuasiSteadyState.Loads.ZIPLoad zIPLoad(Pesp = 100., Qesp = 50.) annotation(
          Placement(visible = true, transformation(origin = {61, -23}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        OmniPES.Circuit.Switches.Fault fault(t_off = 0.3, t_on = 0.2) annotation(
          Placement(visible = true, transformation(origin = {-22, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {4, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(impedance.p, bus2.p) annotation(
          Line(points = {{9.6, 22}, {49.2, 22}, {49.2, 18}}, color = {0, 0, 255}));
        connect(impedance.n, bus1.p) annotation(
          Line(points = {{-10, 22.2}, {-46, 22.2}, {-46, 18.4}}, color = {0, 0, 255}));
        connect(voltageSource.p, impedance2.n) annotation(
          Line(points = {{-88, 19.4}, {-89, 19.4}, {-89, 20.4}, {-76, 20.4}}, color = {0, 0, 255}));
        connect(impedance2.p, bus1.p) annotation(
          Line(points = {{-56.4, 20}, {-46.8, 20}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(bus2.p, SM.terminal) annotation(
          Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 18}, {62, 18}}, color = {0, 0, 255}));
        connect(zIPLoad.p, bus2.p) annotation(
          Line(points = {{61, -8}, {61, 18}, {50, 18}}, color = {0, 0, 255}));
        connect(fault.T, tLine_switched.p) annotation(
          Line(points = {{-22, -14}, {-22, -4}, {-6, -4}}, color = {0, 0, 255}));
        connect(bus1.p, tLine_switched.p) annotation(
          Line(points = {{-46, 18}, {-34, 18}, {-34, -4}, {-6, -4}}, color = {0, 0, 255}));
        connect(tLine_switched.n, bus2.p) annotation(
          Line(points = {{16, -4}, {38, -4}, {38, 18}, {50, 18}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")));
      end Test_Radial_System_SWITCHED;

      model Test_CtrlVoltageSource
        import Modelica.ComplexMath.exp;
        OmniPES.Circuit.Sources.ControlledVoltageSource controlledVoltageSource annotation(
          Placement(visible = true, transformation(origin = {12, 2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
        Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex annotation(
          Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Step step(height = 1, startTime = 0.1) annotation(
          Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Constant const(k = 0) annotation(
          Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        constant Complex j = Complex(0, 1);
        Real delta;
        Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {40, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
          Placement(visible = true, transformation(origin = {76, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
// Variável delta controlada, provoca alterações na potência aparente transferida da fonte controlada até a fonte fixa
        delta = if time > 0.5 then 1 else 0;
        realToComplex.y*exp(j*delta) = controlledVoltageSource.u;
        connect(const.y, realToComplex.im) annotation(
          Line(points = {{-78, -20}, {-68, -20}, {-68, -6}, {-56, -6}}, color = {0, 0, 127}));
        connect(step.y, realToComplex.re) annotation(
          Line(points = {{-79, 20}, {-66, 20}, {-66, 6}, {-56, 6}}, color = {0, 0, 127}));
        connect(controlledVoltageSource.p, seriesImpedance.p) annotation(
          Line(points = {{12, 12}, {30, 12}}, color = {0, 0, 255}));
        connect(seriesImpedance.n, voltageSource.p) annotation(
          Line(points = {{50, 12}, {76, 12}}, color = {0, 0, 255}));
      end Test_CtrlVoltageSource;

      model Test_Classical_Machine_3
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-68, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 5, MVAb = 100, Nmaq = 1, Ra = 0.0, X1d = 0.2, X1q = 0.2, Xd = 1.0, Xl = 0.0, Xq = 0.8) annotation(
          Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 80., Qesp = 0, Vesp = 1.0) annotation(
          Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, smData = gen1_data, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {67, 21}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(magnitude = 1.05) annotation(
          Placement(visible = true, transformation(origin = {-66, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {-6, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Switches.Fault fault(X = 1e-4) annotation(
          Placement(visible = true, transformation(origin = {20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(tLine.n, SM.terminal) annotation(
          Line(points = {{5, 21}, {56, 21}}, color = {0, 0, 255}));
        connect(tLine.p, voltageSource.p) annotation(
          Line(points = {{-17, 21}, {-66, 21}, {-66, 20}}, color = {0, 0, 255}));
        connect(fault.T, tLine.n) annotation(
          Line(points = {{20, 8}, {6, 8}, {6, 22}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Test_Classical_Machine_3;

      model Kundur_Two_Area_System_ShortCircuit
        Real d13;
        inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
          Placement(visible = true, transformation(origin = {1, 71}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_1(D = 0, H = 6.5e10, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {-202, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus7 annotation(
          Placement(visible = true, transformation(origin = {-108, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus8 annotation(
          Placement(visible = true, transformation(origin = {-30, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine G3(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction, smData = gen_data_2, specs = gen3_specs) annotation(
          Placement(visible = true, transformation(origin = {218, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine G4(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, smData = gen_data_2, specs = gen4_specs) annotation(
          Placement(visible = true, transformation(origin = {168, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine G2(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, smData = gen_data_1, specs = gen2_specs) annotation(
          Placement(visible = true, transformation(origin = {-200, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine G1(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, smData = gen_data_1, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {-250, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen3_specs(Pesp = 0., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {222, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {-254, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen4_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {172, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen2_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {-204, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {-66, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine1(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine2(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {16, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor(NominalPower = 200) annotation(
          Placement(visible = true, transformation(origin = {-128, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor1(NominalPower = 350) annotation(
          Placement(visible = true, transformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.QuasiSteadyState.Loads.ZIPLoad L1(Pesp = 967, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ssLoadData(pi = 0, qz = 0) annotation(
          Placement(visible = true, transformation(origin = {-130, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dynLoadData(pi = 0, pz = 1, qz = 1) annotation(
          Placement(visible = true, transformation(origin = {-96, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Loads.ZIPLoad L2(Pesp = 1767, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {64, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_2(D = 0, H = 6.175e10, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine3(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {16, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.CurrentSource currentSource(magnitude = 1) annotation(
          Placement(visible = true, transformation(origin = {-64, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        d13 = G1.inertia.delta - G3.inertia.delta;
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
        connect(G1.terminal, bus1.p) annotation(
          Line(points = {{-240, 18}, {-230, 18}, {-230, 18}, {-230, 18}}, color = {0, 0, 255}));
        connect(trafo.p, bus1.p) annotation(
          Line(points = {{-224, 18}, {-230, 18}}, color = {0, 0, 255}));
        connect(G2.terminal, bus2.p) annotation(
          Line(points = {{-190, -8}, {-186, -8}, {-186, -8}, {-186, -8}}, color = {0, 0, 255}));
        connect(impedance1.p, bus2.p) annotation(
          Line(points = {{-178, -8}, {-186, -8}}, color = {0, 0, 255}));
        connect(impedance2.n, bus4.p) annotation(
          Line(points = {{140, -20}, {150, -20}}, color = {0, 0, 255}));
        connect(G4.terminal, bus4.p) annotation(
          Line(points = {{158, -18}, {150, -18}, {150, -20}, {150, -20}}, color = {0, 0, 255}));
        connect(impedance.n, bus3.p) annotation(
          Line(points = {{186, 14}, {198, 14}}, color = {0, 0, 255}));
        connect(G3.terminal, bus3.p) annotation(
          Line(points = {{208, 14}, {198, 14}, {198, 14}, {198, 14}}, color = {0, 0, 255}));
        connect(tLine1.p, bus7.p) annotation(
          Line(points = {{-77, 1}, {-92, 1}, {-92, 12}, {-108, 12}, {-108, 16}}, color = {0, 0, 255}));
        connect(shunt_Capacitor.p, bus7.p) annotation(
          Line(points = {{-128, -16}, {-128, 0}, {-108, 0}, {-108, 16}}, color = {0, 0, 255}));
        connect(shunt_Capacitor1.p, bus9.p) annotation(
          Line(points = {{84, -14}, {72, -14}, {72, 12}, {64, 12}, {64, 16}}, color = {0, 0, 255}));
        connect(L2.p, bus9.p) annotation(
          Line(points = {{64, -20}, {64, -20}, {64, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(tLine.n, bus8.p) annotation(
          Line(points = {{-54, 28}, {-40, 28}, {-40, 20}, {-30, 20}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine1.n, bus8.p) annotation(
          Line(points = {{-54, 2}, {-40, 2}, {-40, 12}, {-30, 12}, {-30, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine2.p, bus8.p) annotation(
          Line(points = {{6, 28}, {-18, 28}, {-18, 20}, {-30, 20}, {-30, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(L1.p, bus7.p) annotation(
          Line(points = {{-108, -20}, {-108, -20}, {-108, 16}, {-108, 16}}, color = {0, 0, 255}));
        connect(tLine3.p, bus8.p) annotation(
          Line(points = {{6, 0}, {-14, 0}, {-14, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine3.n, bus9.p) annotation(
          Line(points = {{28, 0}, {48, 0}, {48, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(currentSource.p, bus7.p) annotation(
          Line(points = {{-64, -38}, {-90, -38}, {-90, 16}, {-108, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
      end Kundur_Two_Area_System_ShortCircuit;

      model Test_Classical_Machine_1
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-68, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 5, MVAb = 100, Nmaq = 1, Ra = 0.0, X1d = 0.2, X1q = 0.2, Xd = 1.0, Xl = 0.0, Xq = 0.8) annotation(
          Placement(visible = true, transformation(origin = {47, 53}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 100, Qesp = 50, Vesp = 1.0) annotation(
          Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage annotation(
          Placement(visible = true, transformation(origin = {-39, -31}, extent = {{-21, -21}, {21, 21}}, rotation = -90)));
        Modelica.Blocks.Sources.Step step(height = -0.99, offset = 1, startTime = 0.1) annotation(
          Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Blocks.Math.Add add annotation(
          Placement(visible = true, transformation(origin = {24, -22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Step step1(height = 0.99, startTime = 0.2) annotation(
          Placement(visible = true, transformation(origin = {78, -64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.Step step11(height = 0) annotation(
          Placement(visible = true, transformation(origin = {18, -68}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      equation
        connect(controlledVoltage.p, SM.terminal) annotation(
          Line(points = {{-39, -10}, {-39, 0.42}, {44, 0.42}}, color = {0, 0, 255}));
        connect(add.y, controlledVoltage.Vr) annotation(
          Line(points = {{13, -22}, {4, -22}, {4, -14}, {-16, -14}}, color = {0, 0, 127}));
        connect(step11.y, controlledVoltage.Vi) annotation(
          Line(points = {{8, -68}, {-2, -68}, {-2, -22}, {-16, -22}}, color = {0, 0, 127}));
        connect(step.y, add.u1) annotation(
          Line(points = {{68, -30}, {52, -30}, {52, -16}, {36, -16}}, color = {0, 0, 127}));
        connect(step1.y, add.u2) annotation(
          Line(points = {{68, -64}, {46, -64}, {46, -28}, {36, -28}}, color = {0, 0, 127}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Test_Classical_Machine_1;

      model Problema_4_3
        OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.5) annotation(
          Placement(visible = true, transformation(origin = {2, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance trafo(x = 0.15) annotation(
          Placement(visible = true, transformation(origin = {-74, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
          Placement(visible = true, transformation(origin = {88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine GS(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, smData = smData, specs = pfdata) annotation(
          Placement(visible = true, transformation(origin = {-143, -3}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
        Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {-42, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        inner OmniPES.SystemData data(Sbase = 2220) annotation(
          Placement(visible = true, transformation(origin = {-191, 69}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        parameter Machines.SynchronousMachineData smData(H = 3.5, MVAb = 2220, MVAs = 2220) annotation(
          Placement(visible = true, transformation(origin = {-162, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData pfdata(Pesp = 1776, Vesp = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-134, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Switches.Fault fault(X = 0.01, t_off = 100.2, t_on = 100.1) annotation(
          Placement(visible = true, transformation(origin = {-42, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, t_open = 100.2, x = 0.93) annotation(
          Placement(visible = true, transformation(origin = {4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(GS.terminal, bus1.p) annotation(
          Line(points = {{-130, -3}, {-118, -3}, {-118, -2}, {-104, -2}}, color = {0, 0, 255}));
        connect(bus1.p, trafo.p) annotation(
          Line(points = {{-104, -2}, {-94, -2}, {-94, -4}, {-84, -4}}, color = {0, 0, 255}));
        connect(trafo.n, bus2.p) annotation(
          Line(points = {{-64, -4}, {-42, -4}}, color = {0, 0, 255}));
        connect(tLine.p, bus2.p) annotation(
          Line(points = {{-9, 13}, {-24, 13}, {-24, -4}, {-42, -4}}, color = {0, 0, 255}));
        connect(tLine.n, bus3.p) annotation(
          Line(points = {{13, 13}, {48, 13}, {48, -2}}, color = {0, 0, 255}));
        connect(voltageSource.p, bus3.p) annotation(
          Line(points = {{88, -2}, {48, -2}}, color = {0, 0, 255}));
        connect(bus2.p, fault.T) annotation(
          Line(points = {{-42, -4}, {-42, -36}}, color = {0, 0, 255}));
        connect(tLine_switched.p, bus2.p) annotation(
          Line(points = {{-6, -18}, {-28, -18}, {-28, -4}, {-42, -4}}, color = {0, 0, 255}));
        connect(tLine_switched.n, bus3.p) annotation(
          Line(points = {{16, -18}, {48, -18}, {48, -2}}, color = {0, 0, 255}));
        annotation(
          Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001));
      end Problema_4_3;

      model Problema_4_3_Generic_Machine
        OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.5) annotation(
          Placement(visible = true, transformation(origin = {2, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance trafo(x = 0.15) annotation(
          Placement(visible = true, transformation(origin = {-76, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
          Placement(visible = true, transformation(origin = {88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {-42, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        inner OmniPES.SystemData data(Sbase = 2220.) annotation(
          Placement(visible = true, transformation(origin = {-191, 69}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData(H = 3.5, MVAb = 2220., MVAs = 2220.) annotation(
          Placement(visible = true, transformation(origin = {-156, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData pfdata(Pesp = 1776., Vesp = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-128, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Switches.Fault fault(X = 0.01, t_off = 0.2, t_on = 0.1) annotation(
          Placement(visible = true, transformation(origin = {-42, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, t_open = 0.2, x = 0.93) annotation(
          Placement(visible = true, transformation(origin = {4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine GS(smData = smData, specs = pfdata, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {-142, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
            Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
          connect(Rectifier.y, limiter.u) annotation(
            Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(add3.y, LeadLag.u) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag.y, Rectifier.u) annotation(
            Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
        end IEEE_AC4A;
      equation
        connect(bus1.p, trafo.p) annotation(
          Line(points = {{-104, -2}, {-86, -2}}, color = {0, 0, 255}));
        connect(trafo.n, bus2.p) annotation(
          Line(points = {{-66, -2}, {-53, -2}, {-53, -4}, {-42, -4}}, color = {0, 0, 255}));
        connect(tLine.p, bus2.p) annotation(
          Line(points = {{-9, 13}, {-24, 13}, {-24, -4}, {-42, -4}}, color = {0, 0, 255}));
        connect(tLine.n, bus3.p) annotation(
          Line(points = {{13, 13}, {48, 13}, {48, -2}}, color = {0, 0, 255}));
        connect(voltageSource.p, bus3.p) annotation(
          Line(points = {{88, -2}, {48, -2}}, color = {0, 0, 255}));
        connect(bus2.p, fault.T) annotation(
          Line(points = {{-42, -4}, {-42, -36}}, color = {0, 0, 255}));
        connect(tLine_switched.p, bus2.p) annotation(
          Line(points = {{-6, -18}, {-28, -18}, {-28, -4}, {-42, -4}}, color = {0, 0, 255}));
        connect(tLine_switched.n, bus3.p) annotation(
          Line(points = {{16, -18}, {48, -18}, {48, -2}}, color = {0, 0, 255}));
        connect(GS.terminal, bus1.p) annotation(
          Line(points = {{-132, 2}, {-104, 2}, {-104, -2}}, color = {0, 0, 255}));
        annotation(
          Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001));
      end Problema_4_3_Generic_Machine;

      model Kundur_Two_Area_System_no_switch
        Real d13, d23, d43;
        inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
          Placement(visible = true, transformation(origin = {-1, 67}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_1(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {-202, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus7 annotation(
          Placement(visible = true, transformation(origin = {-108, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus8 annotation(
          Placement(visible = true, transformation(origin = {-30, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G3(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_2, specs = gen3_specs) annotation(
          Placement(visible = true, transformation(origin = {218, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G4(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_2, specs = gen4_specs) annotation(
          Placement(visible = true, transformation(origin = {168, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G2(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_1, specs = gen2_specs) annotation(
          Placement(visible = true, transformation(origin = {-214, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G1(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_1, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {-258, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen3_specs(Pesp = 0., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {222, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {-254, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen4_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {172, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen2_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {-204, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {-66, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine1(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine2(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {16, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
          Placement(visible = true, transformation(origin = {-212, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.15*100/900) annotation(
          Placement(visible = true, transformation(origin = {176, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.15*100/900) annotation(
          Placement(visible = true, transformation(origin = {-162, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1, k3 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1.5) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(strict = false, u(start = 1), uMax = 4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Gain gain(k = 200) annotation(
            Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0.0) annotation(
            Placement(visible = true, transformation(origin = {-134, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{87, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
          connect(gain.y, limiter.u) annotation(
            Line(points = {{27, 0}, {64, 0}}, color = {0, 0, 127}));
          connect(add3.y, gain.u) annotation(
            Line(points = {{-32, 0}, {4, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-122, 0}, {-102, 0}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor(NominalPower = 200) annotation(
          Placement(visible = true, transformation(origin = {-128, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor1(NominalPower = 350) annotation(
          Placement(visible = true, transformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ssLoadData(pi = 0, qz = 0) annotation(
          Placement(visible = true, transformation(origin = {-130, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dynLoadData(pi = 0, pz = 1, qz = 1) annotation(
          Placement(visible = true, transformation(origin = {-96, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

        model PSS_1
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS;
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
            Placement(visible = true, transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 0.2, uMin = -0.2) annotation(
            Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(omega, gain.u) annotation(
            Line(points = {{-120, 0}, {-86, 0}}, color = {0, 0, 127}));
          connect(gain.y, Washout.u) annotation(
            Line(points = {{-63, 0}, {-50, 0}}, color = {0, 0, 127}));
          connect(Washout.y, LeadLag1.u) annotation(
            Line(points = {{-27, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag1.y, LeadLag2.u) annotation(
            Line(points = {{11, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(LeadLag2.y, limiter.u) annotation(
            Line(points = {{52, 0}, {68, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Vsad) annotation(
            Line(points = {{91, 0}, {110, 0}}, color = {0, 0, 127}));
        end PSS_1;

        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_2(D = 0, H = 6.175, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tLine21(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
          Placement(visible = true, transformation(origin = {20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Loads.ZIPLoad L2(Pesp = 1767, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {64, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Loads.ZIPLoad L1(Pesp = 967, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
          Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        d13 = G1.inertia.delta - G3.inertia.delta;
        d23 = G2.inertia.delta - G3.inertia.delta;
        d43 = G4.inertia.delta - G3.inertia.delta;
        connect(G1.terminal, bus1.p) annotation(
          Line(points = {{-248, 18}, {-230, 18}}, color = {0, 0, 255}));
        connect(trafo.p, bus1.p) annotation(
          Line(points = {{-222, 18}, {-230, 18}}, color = {0, 0, 255}));
        connect(trafo.n, bus5.p) annotation(
          Line(points = {{-202, 18}, {-199, 18}, {-199, 16}, {-196, 16}}, color = {0, 0, 255}));
        connect(tLine7.p, bus5.p) annotation(
          Line(points = {{-178, 20}, {-187, 20}, {-187, 16}, {-196, 16}}, color = {0, 0, 255}));
        connect(tLine7.n, bus6.p) annotation(
          Line(points = {{-156, 20}, {-154, 20}, {-154, 16}, {-150, 16}}, color = {0, 0, 255}));
        connect(tLine6.p, bus6.p) annotation(
          Line(points = {{-138, 18}, {-144, 18}, {-144, 16}, {-150, 16}}, color = {0, 0, 255}));
        connect(tLine6.n, bus7.p) annotation(
          Line(points = {{-116, 18}, {-108, 18}, {-108, 16}}, color = {0, 0, 255}));
        connect(tLine.p, bus7.p) annotation(
          Line(points = {{-76, 28}, {-94, 28}, {-94, 16}, {-108, 16}}, color = {0, 0, 255}));
        connect(tLine1.p, bus7.p) annotation(
          Line(points = {{-76, 2}, {-94, 2}, {-94, 16}, {-108, 16}}, color = {0, 0, 255}));
        connect(tLine.n, bus8.p) annotation(
          Line(points = {{-54, 28}, {-46, 28}, {-46, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine1.n, bus8.p) annotation(
          Line(points = {{-54, 2}, {-46, 2}, {-46, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine2.p, bus8.p) annotation(
          Line(points = {{6, 28}, {-18, 28}, {-18, 16}, {-30, 16}}, color = {0, 0, 255}));
        connect(tLine2.n, bus9.p) annotation(
          Line(points = {{28, 28}, {42, 28}, {42, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(tLine4.p, bus9.p) annotation(
          Line(points = {{78, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(tLine4.n, bus10.p) annotation(
          Line(points = {{100, 16}, {108, 16}, {108, 14}}, color = {0, 0, 255}));
        connect(tLine5.p, bus10.p) annotation(
          Line(points = {{122, 16}, {115, 16}, {115, 14}, {108, 14}}, color = {0, 0, 255}));
        connect(tLine5.n, bus11.p) annotation(
          Line(points = {{144, 16}, {148, 16}, {148, 14}, {154, 14}}, color = {0, 0, 255}));
        connect(impedance.p, bus11.p) annotation(
          Line(points = {{166, 14}, {154, 14}}, color = {0, 0, 255}));
        connect(impedance.n, bus3.p) annotation(
          Line(points = {{186, 14}, {198, 14}}, color = {0, 0, 255}));
        connect(G3.terminal, bus3.p) annotation(
          Line(points = {{208, 14}, {198, 14}}, color = {0, 0, 255}));
        connect(G4.terminal, bus4.p) annotation(
          Line(points = {{158, -18}, {154, -18}, {154, -20}, {150, -20}}, color = {0, 0, 255}));
        connect(impedance2.n, bus4.p) annotation(
          Line(points = {{140, -20}, {150, -20}}, color = {0, 0, 255}));
        connect(impedance2.p, bus10.p) annotation(
          Line(points = {{120, -20}, {108, -20}, {108, 14}}, color = {0, 0, 255}));
        connect(shunt_Capacitor1.p, bus9.p) annotation(
          Line(points = {{84, -14}, {70, -14}, {70, 16}, {64, 16}}, color = {0, 0, 255}));
        connect(shunt_Capacitor.p, bus7.p) annotation(
          Line(points = {{-128, -16}, {-114, -16}, {-114, 16}, {-108, 16}}, color = {0, 0, 255}));
        connect(impedance1.n, bus6.p) annotation(
          Line(points = {{-152, -8}, {-150, -8}, {-150, 16}}, color = {0, 0, 255}));
        connect(impedance1.p, bus2.p) annotation(
          Line(points = {{-172, -8}, {-186, -8}}, color = {0, 0, 255}));
        connect(G2.terminal, bus2.p) annotation(
          Line(points = {{-204, -8}, {-186, -8}}, color = {0, 0, 255}));
        connect(bus8.p, tLine21.p) annotation(
          Line(points = {{-30, 16}, {-18, 16}, {-18, 1}, {9, 1}}, color = {0, 0, 255}));
        connect(bus9.p, tLine21.n) annotation(
          Line(points = {{64, 16}, {40, 16}, {40, 1}, {31, 1}}, color = {0, 0, 255}));
        connect(L2.p, bus9.p) annotation(
          Line(points = {{64, -20}, {64, 16}}, color = {0, 0, 255}));
        connect(L1.p, bus7.p) annotation(
          Line(points = {{-108, -20}, {-108, 16}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001),
          uses(Modelica(version = "3.2.2")),
          Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
          Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
      end Kundur_Two_Area_System_no_switch;
    end Examples;
  end QuasiSteadyState;

  package CoSimulation
    model BergeronLink
      OmniPES.Circuit.Interfaces.PositivePin pin_p annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.ComplexBlocks.Interfaces.ComplexOutput hist_out annotation(
        Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput hist_in annotation(
        Placement(visible = true, transformation(origin = {89, -19}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {111, -59}, extent = {{-11, -11}, {11, 11}}, rotation = 180)));
      //    Complex hist_in;
      parameter Complex Zc = Complex(1, 0);
      Complex S;
      import Modelica.ComplexMath.conj;
      replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction restriction(param = restrictionData) annotation(
        Placement(visible = true, transformation(origin = {-8, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter OmniPES.QuasiSteadyState.Machines.RestrictionData restrictionData annotation(
        Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //initial equation
      //  hist_in = - pin_p.v / Zc + pin_p.i;
    equation
      S = pin_p.v*conj(pin_p.i);
      restriction.P = S.re;
      restriction.Q = S.im;
      restriction.V^2 = pin_p.v.re^2 + pin_p.v.im^2;
      pin_p.v.re*tan(restriction.theta) = pin_p.v.im;
      (-pin_p.i) + pin_p.v/Zc = hist_in;
      hist_out = pin_p.v/Zc + pin_p.i;
//  der(hist_in.re) = 0;
//  der(hist_in.im) = 0;
      annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Line(origin = {-95, 0}, points = {{-15, 0}, {15, 0}}), Line(origin = {95.3614, 59.8795}, points = {{-15, 0}, {15, 0}}), Line(origin = {94.8795, -59.8795}, points = {{-15, 0}, {15, 0}}), Text(origin = {4, -1}, extent = {{-56, 39}, {56, -39}}, textString = "BL")}));
    end BergeronLink;

    model Teste_01
      parameter Real dt = 0.1;
      OmniPES.CoSimulation.BergeronLink bl_1(restrictionData = specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction) annotation(
        Placement(visible = true, transformation(origin = {2, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Sources.VoltageSource slack_cs annotation(
        Placement(visible = true, transformation(origin = {-88, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      OmniPES.SteadyState.Loads.ZIPLoad zIPLoad_cs(Psp = 100, Qsp = 0) annotation(
        Placement(visible = true, transformation(origin = {196, 32}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
      inner OmniPES.SystemData data(wref = 0) annotation(
        Placement(visible = true, transformation(origin = {-71, 77}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      OmniPES.Circuit.Basic.TLine tl2_cs(Q = 0, r = 0, x = 0.1) annotation(
        Placement(visible = true, transformation(origin = {128, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Interfaces.Bus bus_load_cs annotation(
        Placement(visible = true, transformation(origin = {156, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Interfaces.Bus bus_m annotation(
        Placement(visible = true, transformation(origin = {98, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs(Pesp = 100., Qesp = 10.1021, Vesp = 0.984222, theta_esp = -5.8315) annotation(
        Placement(visible = true, transformation(origin = {36, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Basic.TLine tLine1(Q = 0, r = 0, x = 0.1) annotation(
        Placement(visible = true, transformation(origin = {-54, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Interfaces.Bus bus_k annotation(
        Placement(visible = true, transformation(origin = {-26, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Interfaces.Bus bus_int annotation(
        Placement(visible = true, transformation(origin = {22, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Basic.TLine tl2(Q = 0, r = 0, x = 0.1) annotation(
        Placement(visible = true, transformation(origin = {52, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Sources.VoltageSource slack annotation(
        Placement(visible = true, transformation(origin = {-58, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      OmniPES.Circuit.Interfaces.Bus bus_load annotation(
        Placement(visible = true, transformation(origin = {80, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.SteadyState.Loads.ZIPLoad zIPLoad(Psp = 100, Qsp = 0) annotation(
        Placement(visible = true, transformation(origin = {120, -44}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
      OmniPES.Circuit.Basic.TLine tl1_cs(Q = 0, r = 0, x = 0.1) annotation(
        Placement(visible = true, transformation(origin = {-54, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.Circuit.Basic.TLine tl1(Q = 0, r = 0, x = 0.1) annotation(
        Placement(visible = true, transformation(origin = {-18, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OmniPES.CoSimulation.BergeronLink bl_2(restrictionData = specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction) annotation(
        Placement(visible = true, transformation(origin = {70, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
      connect(zIPLoad_cs.p, bus_load_cs.p) annotation(
        Line(points = {{173.56, 32}, {155.56, 32}}, color = {0, 0, 255}));
      connect(tl2_cs.n, bus_load_cs.p) annotation(
        Line(points = {{139, 33}, {155, 33}, {155, 31}}, color = {0, 0, 255}));
      connect(tl2_cs.p, bus_m.p) annotation(
        Line(points = {{117, 33}, {97, 33}, {97, 31}}, color = {0, 0, 255}));
      connect(slack_cs.p, tLine1.p) annotation(
        Line(points = {{-88, 32.2}, {-64, 32.2}}, color = {0, 0, 255}));
      connect(tLine1.n, bus_k.p) annotation(
        Line(points = {{-43, 31}, {-34, 31}, {-34, 30}, {-26, 30}}, color = {0, 0, 255}));
      connect(bl_1.pin_p, bus_k.p) annotation(
        Line(points = {{-8, 32}, {-26, 32}, {-26, 30}}, color = {0, 0, 255}));
      connect(slack.p, tl1.p) annotation(
        Line(points = {{-58, -40}, {-44, -40}, {-44, -41}, {-29, -41}}, color = {0, 0, 255}));
      connect(tl1.n, bus_int.p) annotation(
        Line(points = {{-7, -41}, {22, -41}, {22, -44}}, color = {0, 0, 255}));
      connect(tl2.p, bus_int.p) annotation(
        Line(points = {{42, -42}, {22, -42}, {22, -44}}, color = {0, 0, 255}));
      connect(tl2.n, bus_load.p) annotation(
        Line(points = {{64, -42}, {80, -42}, {80, -44}}, color = {0, 0, 255}));
      connect(zIPLoad.p, bus_load.p) annotation(
        Line(points = {{98, -44}, {80, -44}}, color = {0, 0, 255}));
      connect(bl_2.pin_p, bus_m.p) annotation(
        Line(points = {{82, 32}, {98, 32}}, color = {0, 0, 255}));
    protected
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.01));
    end Teste_01;

    package Examples
      extends Modelica.Icons.ExamplesPackage;

      model SubSystem_1
        import Modelica.ComplexMath.conj;
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.025, X2q = 0.025, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {88, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-88, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {50, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {-20, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {-66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {72, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
            Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          //initial equation
          //  controlledCurrent.v.re = 0.989789;
          //  controlledCurrent.v.im = 0.180676;
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
          connect(Rectifier.y, limiter.u) annotation(
            Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(add3.y, LeadLag.u) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag.y, Rectifier.u) annotation(
            Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        OmniPES.QuasiSteadyState.Loads.ZIPLoad zIPLoad(Pesp = 100., Qesp = 50.) annotation(
          Placement(visible = true, transformation(origin = {63, -27}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {26, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {4, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledCurrent controlledCurrent annotation(
          Placement(visible = true, transformation(origin = {4, -64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput Ir annotation(
          Placement(visible = true, transformation(origin = {58, -74}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {117, 81}, extent = {{-17, -17}, {17, 17}}, rotation = 180)));
        Modelica.Blocks.Interfaces.RealInput Ii annotation(
          Placement(visible = true, transformation(origin = {58, -86}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {117, 41}, extent = {{-17, -17}, {17, 17}}, rotation = 180)));
        Modelica.Blocks.Interfaces.RealOutput Vr annotation(
          Placement(visible = true, transformation(origin = {-48, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput Vi annotation(
          Placement(visible = true, transformation(origin = {-48, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {4, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(voltageSource.p, impedance2.n) annotation(
          Line(points = {{-88, 19.4}, {-89, 19.4}, {-89, 20.4}, {-76, 20.4}}, color = {0, 0, 255}));
        connect(impedance2.p, bus1.p) annotation(
          Line(points = {{-56.4, 20}, {-46.8, 20}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(bus2.p, SM.terminal) annotation(
          Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 18}, {62, 18}}, color = {0, 0, 255}));
        connect(zIPLoad.p, bus2.p) annotation(
          Line(points = {{63, -12}, {63, 18}, {50, 18}}, color = {0, 0, 255}));
        connect(impedance.n, bus1.p) annotation(
          Line(points = {{-30, -4}, {-37, -4}, {-37, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(impedance.p, bus3.p) annotation(
          Line(points = {{-10, -4}, {4, -4}}, color = {0, 0, 255}));
        connect(seriesImpedance.n, bus3.p) annotation(
          Line(points = {{16, -4}, {4, -4}}, color = {0, 0, 255}));
        connect(bus2.p, seriesImpedance.p) annotation(
          Line(points = {{50, 18}, {50, -4}, {36, -4}}, color = {0, 0, 255}));
        connect(controlledCurrent.p, bus3.p) annotation(
          Line(points = {{4, -54}, {4, -4}}, color = {0, 0, 255}));
        connect(controlledCurrent.Vr, Vr) annotation(
          Line(points = {{-7, -56}, {-25, -56}, {-25, -52}, {-49, -52}}, color = {0, 0, 127}));
        connect(controlledCurrent.Vi, Vi) annotation(
          Line(points = {{-7, -60}, {-33, -60}, {-33, -76}, {-49, -76}}, color = {0, 0, 127}));
        connect(Ir, controlledCurrent.Ir) annotation(
          Line(points = {{58, -74}, {38, -74}, {38, -56}, {16, -56}}, color = {0, 0, 127}));
        connect(Ii, controlledCurrent.Ii) annotation(
          Line(points = {{58, -86}, {26, -86}, {26, -60}, {16, -60}}, color = {0, 0, 127}));
        connect(tLine_switched.p, bus1.p) annotation(
          Line(points = {{-7, 41}, {-36, 41}, {-36, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine_switched.n, bus2.p) annotation(
          Line(points = {{15, 41}, {32, 41}, {32, 18}, {50, 18}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 1e-3, Tolerance = 1e-06, Interval = 0.001),
          uses(Modelica(version = "3.2.2")));
      end SubSystem_1;

      model SubSystem_2
        import Modelica.ComplexMath.conj;
        inner SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        OmniPES.SteadyState.Loads.ZIPLoad zIPLoad_cs(Psp = 100, Qsp = 50) annotation(
          Placement(visible = true, transformation(origin = {86, 38}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tl2_cs(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {18, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus4 annotation(
          Placement(visible = true, transformation(origin = {-12, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus5 annotation(
          Placement(visible = true, transformation(origin = {46, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage annotation(
          Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealOutput Ii annotation(
          Placement(visible = true, transformation(origin = {-92, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput Ir annotation(
          Placement(visible = true, transformation(origin = {-92, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Vi annotation(
          Placement(visible = true, transformation(origin = {-4, -10}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {116, 44}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
        Modelica.Blocks.Interfaces.RealInput Vr annotation(
          Placement(visible = true, transformation(origin = {-4, 8}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {116, 84}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
        //initial equation
        //  controlledVoltage.v.re = 0.989789;
        //  controlledVoltage.v.im = 0.180676;
      equation
        connect(zIPLoad_cs.p, bus5.p) annotation(
          Line(points = {{63.56, 38}, {45.56, 38}}, color = {0, 0, 255}));
        connect(tl2_cs.n, bus5.p) annotation(
          Line(points = {{29, 39}, {45, 39}, {45, 37}}, color = {0, 0, 255}));
        connect(tl2_cs.p, bus4.p) annotation(
          Line(points = {{7, 39}, {-13, 39}, {-13, 37}}, color = {0, 0, 255}));
        connect(controlledVoltage.p, bus4.p) annotation(
          Line(points = {{-50, 10.2}, {-50, 38.2}, {-12, 38.2}}, color = {0, 0, 255}));
        connect(Vr, controlledVoltage.Vr) annotation(
          Line(points = {{-4, 8}, {-38, 8}}, color = {0, 0, 127}));
        connect(Vi, controlledVoltage.Vi) annotation(
          Line(points = {{-4, -10}, {-28, -10}, {-28, 4}, {-38, 4}}, color = {0, 0, 127}));
        connect(controlledVoltage.Ir, Ir) annotation(
          Line(points = {{-61, 8}, {-92, 8}}, color = {0, 0, 127}));
        connect(controlledVoltage.Ii, Ii) annotation(
          Line(points = {{-61, 4}, {-67, 4}, {-67, -16}, {-92, -16}}, color = {0, 0, 127}));
      end SubSystem_2;

      model System
        parameter QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {50, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-88, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.025, X2q = 0.025, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {88, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {72, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        inner SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {26, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {4, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        Circuit.Basic.SeriesImpedance impedance2(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {-66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {-20, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        QuasiSteadyState.Loads.ZIPLoad zIPLoad(Pesp = 100., Qesp = 50.) annotation(
          Placement(visible = true, transformation(origin = {63, -23}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        OmniPES.Circuit.Interfaces.Bus bus4 annotation(
          Placement(visible = true, transformation(origin = {4, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.SteadyState.Loads.ZIPLoad zIPLoad_cs(Psp = 100, Qsp = 50) annotation(
          Placement(visible = true, transformation(origin = {102, -70}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tl2_cs(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {34, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus5 annotation(
          Placement(visible = true, transformation(origin = {62, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
            Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
          connect(Rectifier.y, limiter.u) annotation(
            Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(add3.y, LeadLag.u) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag.y, Rectifier.u) annotation(
            Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        OmniPES.Scopes.Ammeter ammeter annotation(
          Placement(visible = true, transformation(origin = {-4, -34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {6, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(zIPLoad.p, bus2.p) annotation(
          Line(points = {{63, -8}, {63, 18}, {50, 18}}, color = {0, 0, 255}));
        connect(seriesImpedance.n, bus3.p) annotation(
          Line(points = {{16, -4}, {4, -4}}, color = {0, 0, 255}));
        connect(bus2.p, SM.terminal) annotation(
          Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 18}, {62, 18}}, color = {0, 0, 255}));
        connect(bus2.p, seriesImpedance.p) annotation(
          Line(points = {{50, 18}, {50, -4}, {36, -4}}, color = {0, 0, 255}));
        connect(impedance.p, bus3.p) annotation(
          Line(points = {{-10, -4}, {4, -4}}, color = {0, 0, 255}));
        connect(impedance.n, bus1.p) annotation(
          Line(points = {{-30, -4}, {-37, -4}, {-37, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(impedance2.p, bus1.p) annotation(
          Line(points = {{-56.4, 20}, {-46.8, 20}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(voltageSource.p, impedance2.n) annotation(
          Line(points = {{-88, 19.4}, {-89, 19.4}, {-89, 20.4}, {-76, 20.4}}, color = {0, 0, 255}));
        connect(zIPLoad_cs.p, bus5.p) annotation(
          Line(points = {{79.56, -70}, {61.56, -70}}, color = {0, 0, 255}));
        connect(tl2_cs.n, bus5.p) annotation(
          Line(points = {{45, -69}, {61, -69}, {61, -71}}, color = {0, 0, 255}));
        connect(tl2_cs.p, bus4.p) annotation(
          Line(points = {{23, -69}, {3, -69}, {3, -71}}, color = {0, 0, 255}));
        connect(ammeter.p, bus3.p) annotation(
          Line(points = {{-4, -24}, {-4, -4}, {4, -4}}, color = {0, 0, 255}));
        connect(ammeter.n, bus4.p) annotation(
          Line(points = {{-4, -44}, {-4, -70}, {4, -70}}, color = {0, 0, 255}));
        connect(tLine_switched.p, bus1.p) annotation(
          Line(points = {{-5, 43}, {-28, 43}, {-28, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine_switched.n, bus2.p) annotation(
          Line(points = {{17, 43}, {34, 43}, {34, 18}, {50, 18}}, color = {0, 0, 255}));
      end System;

      model SubSystem_1_TL
        import Modelica.ComplexMath.conj;
        inner OmniPES.SystemData data(wref = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.025, X2q = 0.025, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
          Placement(visible = true, transformation(origin = {88, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-88, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
          Placement(visible = true, transformation(origin = {50, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {-20, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus1 annotation(
          Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus2 annotation(
          Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        //
        OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {-66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {72, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
            Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          //initial equation
          //  controlledCurrent.v.re = 0.989789;
          //  controlledCurrent.v.im = 0.180676;
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
          connect(Rectifier.y, limiter.u) annotation(
            Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(add3.y, LeadLag.u) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag.y, Rectifier.u) annotation(
            Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        OmniPES.QuasiSteadyState.Loads.ZIPLoad zIPLoad(Pesp = 100., Qesp = 50.) annotation(
          Placement(visible = true, transformation(origin = {63, -27}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.025) annotation(
          Placement(visible = true, transformation(origin = {26, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        OmniPES.Circuit.Interfaces.Bus bus3 annotation(
          Placement(visible = true, transformation(origin = {4, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, x = 0.05) annotation(
          Placement(visible = true, transformation(origin = {4, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.CoSimulation.BergeronLink TL_k(restrictionData = specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction) annotation(
          Placement(visible = true, transformation(origin = {4, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs(Pesp = -100., Qesp = -63.9135, Vesp = 1.0061432, theta_esp = 0.180552) annotation(
          Placement(visible = true, transformation(origin = {-38, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput hout_re annotation(
          Placement(visible = true, transformation(origin = {18, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput hout_im annotation(
          Placement(visible = true, transformation(origin = {18, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput hin_im annotation(
          Placement(visible = true, transformation(origin = {-63, -87}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput hin_re annotation(
          Placement(visible = true, transformation(origin = {-63, -67}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
      equation
        TL_k.hist_out.re = hout_re;
        TL_k.hist_out.im = hout_im;
        TL_k.hist_in.re = hin_re;
        TL_k.hist_in.im = hin_im;
        connect(voltageSource.p, impedance2.n) annotation(
          Line(points = {{-88, 19.4}, {-89, 19.4}, {-89, 20.4}, {-76, 20.4}}, color = {0, 0, 255}));
        connect(impedance2.p, bus1.p) annotation(
          Line(points = {{-56.4, 20}, {-46.8, 20}, {-46.8, 18}}, color = {0, 0, 255}));
        connect(bus2.p, SM.terminal) annotation(
          Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 18}, {62, 18}}, color = {0, 0, 255}));
        connect(zIPLoad.p, bus2.p) annotation(
          Line(points = {{63, -12}, {63, 18}, {50, 18}}, color = {0, 0, 255}));
        connect(impedance.n, bus1.p) annotation(
          Line(points = {{-30, -4}, {-37, -4}, {-37, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(impedance.p, bus3.p) annotation(
          Line(points = {{-10, -4}, {4, -4}}, color = {0, 0, 255}));
        connect(seriesImpedance.n, bus3.p) annotation(
          Line(points = {{16, -4}, {4, -4}}, color = {0, 0, 255}));
        connect(bus2.p, seriesImpedance.p) annotation(
          Line(points = {{50, 18}, {50, -4}, {36, -4}}, color = {0, 0, 255}));
        connect(tLine_switched.p, bus1.p) annotation(
          Line(points = {{-7, 41}, {-36, 41}, {-36, 18}, {-46, 18}}, color = {0, 0, 255}));
        connect(tLine_switched.n, bus2.p) annotation(
          Line(points = {{15, 41}, {32, 41}, {32, 18}, {50, 18}}, color = {0, 0, 255}));
        connect(TL_k.pin_p, bus3.p) annotation(
          Line(points = {{4, -25}, {4, -4}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 1e-3, Tolerance = 1e-06, Interval = 0.001),
          uses(Modelica(version = "3.2.2")));
      end SubSystem_1_TL;

      model SubSystem_2_TL
        import Modelica.ComplexMath.conj;
        inner SystemData data(wref = 1.0) annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        OmniPES.SteadyState.Loads.ZIPLoad zIPLoad_cs(Psp = 100, Qsp = 50) annotation(
          Placement(visible = true, transformation(origin = {86, 38}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        OmniPES.Circuit.Basic.TLine tl2_cs(Q = 0, r = 0, x = 0.1) annotation(
          Placement(visible = true, transformation(origin = {18, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus4 annotation(
          Placement(visible = true, transformation(origin = {-12, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.Bus bus5 annotation(
          Placement(visible = true, transformation(origin = {46, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.CoSimulation.BergeronLink TL_m(restrictionData = specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction) annotation(
          Placement(visible = true, transformation(origin = {-42, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput hin_re annotation(
          Placement(visible = true, transformation(origin = {-63, -67}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput hin_im annotation(
          Placement(visible = true, transformation(origin = {-63, -87}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput hout_re annotation(
          Placement(visible = true, transformation(origin = {18, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput hout_im annotation(
          Placement(visible = true, transformation(origin = {18, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs(Pesp = 100., Qesp = 63.9135, Vesp = 1.0061432, theta_esp = 0.180552) annotation(
          Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        TL_m.hist_out.re = hout_re;
        TL_m.hist_out.im = hout_im;
        TL_m.hist_in.re = hin_re;
        TL_m.hist_in.im = hin_im;
        connect(zIPLoad_cs.p, bus5.p) annotation(
          Line(points = {{63.56, 38}, {45.56, 38}}, color = {0, 0, 255}));
        connect(tl2_cs.n, bus5.p) annotation(
          Line(points = {{29, 39}, {45, 39}, {45, 37}}, color = {0, 0, 255}));
        connect(tl2_cs.p, bus4.p) annotation(
          Line(points = {{7, 39}, {-13, 39}, {-13, 37}}, color = {0, 0, 255}));
        connect(TL_m.pin_p, bus4.p) annotation(
          Line(points = {{-42, 20}, {-42, 38}, {-12, 38}}, color = {0, 0, 255}));
      end SubSystem_2_TL;

      model System_TL
        parameter Real dt = 1e-3;
        OmniPES.CoSimulation.Examples.SubSystem_1_TL subs1 annotation(
          Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.CoSimulation.Examples.SubSystem_2_TL subs2 annotation(
          Placement(visible = true, transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        subs2.hin_re = delay(subs1.hout_re, dt);
        subs2.hin_im = delay(subs1.hout_im, dt);
        subs1.hin_re = delay(subs2.hout_re, dt);
        subs1.hin_im = delay(subs2.hout_im, dt);
      end System_TL;

      model Test_Classical_Machine
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-74, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
          Placement(visible = true, transformation(origin = {50, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
          Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Vr(start = 1) annotation(
          Placement(visible = true, transformation(origin = {39, -29}, extent = {{13, -13}, {-13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Vi(start = 0) annotation(
          Placement(visible = true, transformation(origin = {39, -75}, extent = {{15, -15}, {-15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage1 annotation(
          Placement(visible = true, transformation(origin = {-32, -30}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      equation
        connect(SM.terminal, controlledVoltage1.p) annotation(
          Line(points = {{44, 0}, {-32, 0}, {-32, -10}}, color = {0, 0, 255}));
        connect(controlledVoltage1.Vr, Vr) annotation(
          Line(points = {{-10, -14}, {18, -14}, {18, -28}, {40, -28}}, color = {0, 0, 127}));
        connect(controlledVoltage1.Vi, Vi) annotation(
          Line(points = {{-10, -22}, {2, -22}, {2, -74}, {40, -74}}, color = {0, 0, 127}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Test_Classical_Machine;

      model Generic_Machine
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
          Placement(visible = true, transformation(origin = {78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
          Placement(visible = true, transformation(origin = {40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
          Placement(visible = true, transformation(origin = {73, 15}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));

        model IEEE_AC4A
          extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
          Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
            Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
            Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.Constant const(k = 0) annotation(
            Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
            Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add3.u3, Vsad) annotation(
            Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
          connect(Vref.y, add3.u2) annotation(
            Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
          connect(const.y, Vref.u) annotation(
            Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
          connect(Rectifier.y, limiter.u) annotation(
            Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
          connect(limiter.y, Efd) annotation(
            Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
          connect(add3.y, LeadLag.u) annotation(
            Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
          connect(LeadLag.y, Rectifier.u) annotation(
            Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
          connect(firstOrder.u, Vctrl) annotation(
            Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
          connect(firstOrder.y, add3.u1) annotation(
            Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
        end IEEE_AC4A;

        Modelica.Blocks.Interfaces.RealInput Vi(start = 0) annotation(
          Placement(visible = true, transformation(origin = {35, -67}, extent = {{15, -15}, {-15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage1 annotation(
          Placement(visible = true, transformation(origin = {-36, -22}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealInput Vr(start = 1) annotation(
          Placement(visible = true, transformation(origin = {35, -21}, extent = {{13, -13}, {-13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        connect(controlledVoltage1.Vi, Vi) annotation(
          Line(points = {{-14, -14}, {-2, -14}, {-2, -66}, {36, -66}}, color = {0, 0, 127}));
        connect(controlledVoltage1.Vr, Vr) annotation(
          Line(points = {{-14, -6}, {14, -6}, {14, -20}, {36, -20}}, color = {0, 0, 127}));
        connect(SM.terminal, controlledVoltage1.p) annotation(
          Line(points = {{58, 15}, {-36, 15}, {-36, -2}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          uses(Modelica(version = "3.2.2")));
      end Generic_Machine;

      model Classical_Machine_ZTH
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-74, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
          Placement(visible = true, transformation(origin = {50, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
          Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Vr(start = 1) annotation(
          Placement(visible = true, transformation(origin = {19, -33}, extent = {{13, -13}, {-13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Vi(start = 0) annotation(
          Placement(visible = true, transformation(origin = {19, -79}, extent = {{15, -15}, {-15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage1 annotation(
          Placement(visible = true, transformation(origin = {-52, -34}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
        OmniPES.Circuit.Basic.SeriesImpedance zth(x = 1e-10) annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      equation
        connect(controlledVoltage1.Vr, Vr) annotation(
          Line(points = {{-30, -18}, {-2, -18}, {-2, -32}, {20, -32}}, color = {0, 0, 127}));
        connect(controlledVoltage1.Vi, Vi) annotation(
          Line(points = {{-30, -26}, {-18, -26}, {-18, -78}, {20, -78}}, color = {0, 0, 127}));
        connect(zth.p, SM.terminal) annotation(
          Line(points = {{10, 0}, {44, 0}}, color = {0, 0, 255}));
        connect(zth.n, controlledVoltage1.p) annotation(
          Line(points = {{-10, 0}, {-52, 0}, {-52, -14}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Classical_Machine_ZTH;

      model Classical_Machine_PQ
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-74, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
          Placement(visible = true, transformation(origin = {50, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
          Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction, smData = gen1_data, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput P(start = 1) annotation(
          Placement(visible = true, transformation(origin = {39, -29}, extent = {{13, -13}, {-13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Q(start = 0) annotation(
          Placement(visible = true, transformation(origin = {39, -75}, extent = {{15, -15}, {-15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledPower controlledPower annotation(
          Placement(visible = true, transformation(origin = {-23, -23}, extent = {{-17, -17}, {17, 17}}, rotation = -90)));
      equation
        connect(controlledPower.P, P) annotation(
          Line(points = {{-4, -9}, {22, -9}, {22, -28}, {40, -28}}, color = {0, 0, 127}));
        connect(controlledPower.Q, Q) annotation(
          Line(points = {{-4, -16}, {12, -16}, {12, -74}, {40, -74}}, color = {0, 0, 127}));
        connect(SM.terminal, controlledPower.p) annotation(
          Line(points = {{44, 0}, {-22, 0}, {-22, -6}}, color = {0, 0, 255}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Classical_Machine_PQ;

      model Classical_Machine_Filter
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-74, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
          Placement(visible = true, transformation(origin = {50, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
          Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Vr(start = 1) annotation(
          Placement(visible = true, transformation(origin = {61, -31}, extent = {{13, -13}, {-13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Vi(start = 0) annotation(
          Placement(visible = true, transformation(origin = {61, -71}, extent = {{15, -15}, {-15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage1 annotation(
          Placement(visible = true, transformation(origin = {-32, -30}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
        Modelica.Blocks.Continuous.FirstOrder f2(T = 1e-3, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
          Placement(visible = true, transformation(origin = {20, -72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Blocks.Continuous.FirstOrder f1(T = 1e-3, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
          Placement(visible = true, transformation(origin = {22, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      equation
        connect(SM.terminal, controlledVoltage1.p) annotation(
          Line(points = {{44, 0}, {-32, 0}, {-32, -10}}, color = {0, 0, 255}));
        connect(f1.u, Vr) annotation(
          Line(points = {{34, -30}, {62, -30}}, color = {0, 0, 127}));
        connect(f2.u, Vi) annotation(
          Line(points = {{32, -72}, {62, -72}, {62, -70}}, color = {0, 0, 127}));
        connect(f2.y, controlledVoltage1.Vi) annotation(
          Line(points = {{10, -72}, {-2, -72}, {-2, -22}, {-10, -22}}, color = {0, 0, 127}));
        connect(f1.y, controlledVoltage1.Vr) annotation(
          Line(points = {{12, -30}, {6, -30}, {6, -14}, {-10, -14}}, color = {0, 0, 127}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Classical_Machine_Filter;

      model Classical_Machine_TL
        inner OmniPES.SystemData data annotation(
          Placement(visible = true, transformation(origin = {-74, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
          Placement(visible = true, transformation(origin = {50, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
          Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        //
        OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
          Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput hist_in_re(start = 1) annotation(
          Placement(visible = true, transformation(origin = {-75, -37}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput hist_in_im(start = 0) annotation(
          Placement(visible = true, transformation(origin = {-75, -83}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Circuit.Basic.SeriesImpedance Zc(r = 0, x = gen1_data.convData.X1d) annotation(
          Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.CoSimulation.Adaptors.ControlledVoltage hist annotation(
          Placement(visible = true, transformation(origin = {-30, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        OmniPES.Units.CPerUnit E_hist;
      equation
        E_hist = Zc.n.v - Complex(Zc.r, Zc.x)*Zc.n.i;
        connect(Zc.n, SM.terminal) annotation(
          Line(points = {{12, 0}, {44, 0}}, color = {0, 0, 255}));
        connect(hist.p, Zc.p) annotation(
          Line(points = {{-30, -34}, {-32, -34}, {-32, 0}, {-8, 0}}, color = {0, 0, 255}));
        connect(hist_in_re, hist.Vr) annotation(
          Line(points = {{-74, -36}, {-40, -36}}, color = {0, 0, 127}));
        connect(hist_in_im, hist.Vi) annotation(
          Line(points = {{-74, -82}, {-52, -82}, {-52, -40}, {-40, -40}}, color = {0, 0, 127}));
      protected
        annotation(
          experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
          Diagram);
      end Classical_Machine_TL;
    end Examples;

    package Adaptors
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

      model ControlledVoltage
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        Modelica.Blocks.Interfaces.RealInput Vr annotation(
          Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        Modelica.Blocks.Interfaces.RealInput Vi annotation(
          Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        Modelica.Blocks.Interfaces.RealOutput Ir annotation(
          Placement(visible = true, transformation(origin = {-112, -6}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealOutput Ii annotation(
          Placement(visible = true, transformation(origin = {-112, -24}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        //Modelica.Blocks.Interfaces.RealOutput dIr annotation(
        //    Placement(visible = true, transformation(origin = {-112, -66}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        //Modelica.Blocks.Interfaces.RealOutput dIi annotation(
        //    Placement(visible = true, transformation(origin = {-112, -80}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        v = Complex(Vr, Vi);
        i = -Complex(Ir, Ii);
//dIr = der(i.re);
//dIi = der(i.im);
        annotation(
          Icon(graphics = {Ellipse(extent = {{-50, 50}, {50, -50}}, endAngle = 360), Line(origin = {-75, 0}, points = {{25, 0}, {-25, 0}, {-25, 0}}), Line(origin = {65, 0}, points = {{-15, 0}, {15, 0}, {15, 0}}), Rectangle(origin = {-0.00942045, 0.0664522}, extent = {{-100.009, 100.066}, {100.009, -100.066}}), Line(origin = {81.5, 0}, points = {{-1.2, 20}, {-1.2, -20}}), Line(origin = {87.5, 0}, points = {{-1.2, 15}, {-1.2, -15}}), Line(origin = {93.5, 0}, points = {{-1.2, 10}, {-1.2, -10}}), Text(origin = {-36, 0.6}, extent = {{-20, 20}, {20, -20}}, textString = "+"), Text(origin = {42, 0}, rotation = 90, extent = {{-20, 20}, {20, -20}}, textString = "-")}));
      end ControlledVoltage;

      model ControlledPower
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        Modelica.Blocks.Interfaces.RealInput P annotation(
          Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        Modelica.Blocks.Interfaces.RealInput Q annotation(
          Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        Modelica.Blocks.Interfaces.RealOutput Ir annotation(
          Placement(visible = true, transformation(origin = {-112, -6}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Interfaces.RealOutput Ii annotation(
          Placement(visible = true, transformation(origin = {-112, -24}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        //Modelica.Blocks.Interfaces.RealOutput dIr annotation(
        //    Placement(visible = true, transformation(origin = {-112, -66}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        //Modelica.Blocks.Interfaces.RealOutput dIi annotation(
        //    Placement(visible = true, transformation(origin = {-112, -80}, extent = {{-12, -12}, {12, 12}}, rotation = 180), iconTransformation(origin = {80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        v*Modelica.ComplexMath.conj(i) = Complex(P, Q);
        i = -Complex(Ir, Ii);
//dIr = der(i.re);
//dIi = der(i.im);
        annotation(
          Icon(graphics = {Ellipse(extent = {{-50, 50}, {50, -50}}, endAngle = 360), Line(origin = {-75, 0}, points = {{25, 0}, {-25, 0}, {-25, 0}}), Line(origin = {65, 0}, points = {{-15, 0}, {15, 0}, {15, 0}}), Rectangle(origin = {-0.00942045, 0.0664522}, extent = {{-100.009, 100.066}, {100.009, -100.066}}), Line(origin = {81.5, 0}, points = {{-1.2, 20}, {-1.2, -20}}), Line(origin = {87.5, 0}, points = {{-1.2, 15}, {-1.2, -15}}), Line(origin = {93.5, 0}, points = {{-1.2, 10}, {-1.2, -10}}), Text(origin = {-36, 0.6}, extent = {{-20, 20}, {20, -20}}, textString = "+"), Text(origin = {42, 0}, rotation = 90, extent = {{-20, 20}, {20, -20}}, textString = "-")}));
      end ControlledPower;
    end Adaptors;
  end CoSimulation;

  package Circuit
    package Interfaces
      extends Modelica.Icons.InterfacesPackage;

      connector PositivePin
        import OmniPES.Units;
        Units.CPerUnit v(re(start=1.0), im(start=0.0)) "Positive node voltage";
        flow Units.CPerUnit i(re(start=1e-6), im(start=1e-6)) "Sum of currents flowing into node";
        annotation(
          defaultComponentName = "pin_p",
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-160, 110}, {40, 50}}, lineColor = {0, 0, 255}, textString = "%name")}));
      end PositivePin;

      connector NegativePin
        import OmniPES.Units;
        Units.CPerUnit v(re(start=1.0), im(start=0.0)) "Negative node voltage";
        flow Units.CPerUnit i(re(start=1e-6), im(start=1e-6)) "Sum of currents flowing into node";
        annotation(
          defaultComponentName = "pin_n",
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, 110}, {160, 50}}, textString = "%name", lineColor = {0, 0, 255})}));
      end NegativePin;

      partial model SeriesComponent
        import OmniPES.Units;
        Units.CPerUnit v "Voltage drop accros this circuit element.";
        Units.CPerUnit i "Current flowing from pin 'p' to pin 'n'";
        PositivePin p annotation(
          Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        NegativePin n annotation(
          Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        v = p.v - n.v;
        i = p.i;
        p.i + n.i = Complex(0);
      end SeriesComponent;

      model Bus
        import OmniPES.Units;
        import Modelica.Units.SI;
        OmniPES.Circuit.Interfaces.PositivePin p(v.re(start = 1.0)) annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-100, -100}, {100, 100}}, rotation = 0), iconTransformation(origin = {-2, -20}, extent = {{-15, -150}, {15, 150}}, rotation = 0)));
        Units.PerUnit V(start = 1.0);
        SI.Angle angle(start = 0);
      equation
        V^2 = p.v.re^2 + p.v.im^2;
        p.v.re = V*cos(angle);
        p.i = Complex(0);
        annotation(
          Icon(graphics = {Rectangle(origin = {-7, 3}, extent = {{1, 97}, {13, -105}}), Text(origin = {-5, 163}, lineColor = {0, 0, 255}, extent = {{-83, 41}, {83, -41}}, textString = "%name")}));
      end Bus;

      partial model ShuntComponent
        import OmniPES.Units;
        OmniPES.Circuit.Interfaces.PositivePin p annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Units.CPerUnit v "Node voltage across this shunt element.";
        Units.CPerUnit i "Current flowing towards the reference node.";
      equation
        v = p.v;
        i = p.i;
      end ShuntComponent;

      model IdealTransformer
        parameter Real a = 1.0 "Transformer ratio";
        PositivePin p annotation(
          Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        NegativePin n annotation(
          Placement(visible = true, transformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        p.v = a*n.v;
        n.i + a*p.i = Complex(0);
        annotation(
          Icon(graphics = {Line(origin = {72, 0}, points = {{-27, 0}, {30, 0}}), Line(origin = {-72, 0}, points = {{-30, 0}, {27, 0}}), Ellipse(origin = {-17, 0}, extent = {{-28, 28}, {28, -28}}, endAngle = 360), Ellipse(origin = {17, 0}, extent = {{-28, 28}, {28, -28}}, endAngle = 360), Ellipse(origin = {-48, 28}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}, endAngle = 360)}));
      end IdealTransformer;
    end Interfaces;

    package Sources
      extends Modelica.Icons.SourcesPackage;

      model VoltageSource
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        import Modelica.ComplexMath.conj;
        import OmniPES.Math.polar2cart;
        parameter OmniPES.Units.PerUnit magnitude = 1.0;
        parameter Modelica.Units.NonSI.Angle_deg angle = 0.0;
        OmniPES.Units.CPerUnit S;
      equation
        v = polar2cart(magnitude, angle);
        S = -v*conj(i);
        annotation(
          Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}, endAngle = 360), Line(origin = {-73, 0}, points = {{-13, 0}, {13, 0}}), Line(origin = {81, 0}, points = {{-9, 0}, {9, 0}}), Line(origin = {-4, -22}, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {16, 22}, rotation = 180, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {98, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {108, -1}, points = {{0, 33}, {0, -33}}), Line(origin = {122, -1}, points = {{0, 19}, {0, -19}}), Line(origin = {134, 1}, points = {{0, 3}, {0, -7}})}, coordinateSystem(initialScale = 0.1)));
      end VoltageSource;

      model CurrentSource
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        import OmniPES.Math.polar2cart;
        parameter OmniPES.Units.PerUnit magnitude = 0.0;
        parameter Modelica.Units.NonSI.Angle_deg angle = 0.0;
      equation
//  if time < 1 then
//    i = 0;
//  else
        i = if time < 1 then Complex(0.0) else -polar2cart(magnitude, angle);
//  end
        annotation(
          Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}, endAngle = 360), Line(origin = {-73, 0}, points = {{-13, 0}, {13, 0}}), Line(origin = {-18.0759, 0}, points = {{75.235, 0}, {11.235, 0}, {11.235, 20}, {-20.765, 0}, {11.235, -20}, {11.235, 0}}), Line(origin = {93, 0}, points = {{-21, 0}, {21, 0}}), Line(origin = {114, -1}, points = {{0, 35}, {0, -35}}), Line(origin = {130, -1}, points = {{0, 21}, {0, -19}}), Line(origin = {144, -1}, points = {{0, 9}, {0, -5}})}, coordinateSystem(initialScale = 0.1)));
      end CurrentSource;

      model PVSource
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        import Modelica.ComplexMath.conj;
        parameter OmniPES.Units.ActivePower Psp;
        parameter OmniPES.Units.PerUnit Vsp = 1.0;
        outer OmniPES.SystemData data;
        OmniPES.Units.CPerUnit S;
      equation
        S = -v*conj(i);
        S.re = Psp/data.Sbase;
        Vsp^2 = v.re^2 + v.im^2;
        annotation(
          Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}), Line(origin = {-73, 0}, points = {{-13, 0}, {13, 0}}), Line(origin = {81, 0}, points = {{-9, 0}, {9, 0}}), Line(origin = {-4, -22}, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {16, 22}, rotation = 180, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {98, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {108, -1}, points = {{0, 33}, {0, -33}}), Line(origin = {122, -1}, points = {{0, 19}, {0, -19}}), Line(origin = {134, 1}, points = {{0, 3}, {0, -7}}), Text(origin = {80.4, -71.35}, rotation = 90, extent = {{-25.35, 29.6}, {26.65, -18.4}}, textString = "PV")}, coordinateSystem(initialScale = 0.1)));
      end PVSource;

      model PQSource
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        import Modelica.ComplexMath.conj;
        parameter OmniPES.Units.ActivePower P;
        parameter OmniPES.Units.ReactivePower Q;
        outer OmniPES.SystemData data;
        OmniPES.Units.CPerUnit S;
      equation
        S = -v*conj(i);
        S.re = P/data.Sbase;
        S.im = Q/data.Sbase;
        annotation(
          Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}, endAngle = 360), Line(origin = {-73, 0}, points = {{-13, 0}, {13, 0}}), Line(origin = {81, 0}, points = {{-9, 0}, {9, 0}}), Line(origin = {-4, -22}, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {16, 22}, rotation = 180, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {98, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {108, -1}, points = {{0, 33}, {0, -33}}), Line(origin = {122, -1}, points = {{0, 19}, {0, -19}}), Line(origin = {134, 1}, points = {{0, 3}, {0, -7}}), Text(origin = {91, -75}, rotation = 90, extent = {{-39, 37}, {41, -23}}, textString = "PQ")}, coordinateSystem(initialScale = 0.1)));
      end PQSource;

      model PVSource_Qlim
        outer OmniPES.SystemData data;
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        import Modelica.ComplexMath.conj;
        parameter OmniPES.Units.ActivePower Psp;
        parameter OmniPES.Units.PerUnit Vsp = 1.0;
        parameter OmniPES.Units.ReactivePower Qmin = -1e5;
        parameter OmniPES.Units.ReactivePower Qmax = +1e5;
        parameter Real tolq = 1e-3;
        parameter Real tolv = 1e-3;
        parameter Real inc = 1e5;
        OmniPES.Units.CPerUnit S(re(start = Psp/data.Sbase), im(start = 0));
        OmniPES.Units.PerUnit Vabs(start = 1);
        Real ch1(start = 0), ch2(start = 0), ch3(start = 0), ch4(start = 0);
      protected
        parameter Real lim_max = Qmax/data.Sbase - tolq;
        parameter Real lim_min = Qmin/data.Sbase + tolq;
        parameter Real lim_sup = Vsp + tolv;
        parameter Real lim_inf = Vsp - tolv;
      equation
        S = -v*conj(i);
        S.re = Psp/data.Sbase;
        (1 - ch1*ch3)*(1 - ch2*ch4)*(Vabs - Vsp) + ch1*ch3*(1 - ch2*ch4)*(S.im - Qmax/data.Sbase) + (1 - ch1*ch3)*(ch2*ch4)*(S.im - Qmin/data.Sbase) = 0;
        Vabs^2 = v.re^2 + v.im^2;
      algorithm
        ch1 := 1/(1 + exp(-inc*(S.im - lim_max)));
        ch2 := 1/(1 + exp(inc*(S.im - lim_min)));
        ch3 := 1/(1 + exp(inc*(Vabs - lim_sup)));
        ch4 := 1/(1 + exp(-inc*(Vabs - lim_inf)));
        annotation(
          Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}, endAngle = 360), Line(origin = {-73, 0}, points = {{-25, 0}, {13, 0}}), Line(origin = {81, 0}, points = {{-9, 0}, {9, 0}}), Line(origin = {-4, -22}, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {16, 22}, rotation = 180, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {98, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {108, -1}, points = {{0, 33}, {0, -33}}), Line(origin = {122, -1}, points = {{0, 19}, {0, -19}}), Line(origin = {134, 1}, points = {{0, 3}, {0, -7}}), Text(origin = {75, 65}, rotation = -90, extent = {{-33, 25}, {33, -25}}, textString = "PV\nQlim")}, coordinateSystem(initialScale = 0.1)));
      end PVSource_Qlim;

      model ControlledVoltageSource
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        import Modelica.ComplexMath.conj;
        import OmniPES.Math.polar2cart;
        OmniPES.Units.CPerUnit S;
        Modelica.ComplexBlocks.Interfaces.ComplexInput u annotation(
          Placement(visible = true, transformation(origin = {-62, -48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {6, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        v = u;
        S = -v*conj(i);
        annotation(
          Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}, endAngle = 360), Line(origin = {-73, 0}, points = {{-25, 0}, {13, 0}}), Line(origin = {81, 0}, points = {{-9, 0}, {9, 0}}), Line(origin = {-4, -22}, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {16, 22}, rotation = 180, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {98, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {108, -1}, points = {{0, 33}, {0, -33}}), Line(origin = {122, -1}, points = {{0, 19}, {0, -19}}), Line(origin = {134, 1}, points = {{0, 3}, {0, -7}})}, coordinateSystem(initialScale = 0.1)));
      end ControlledVoltageSource;
    end Sources;

    package Basic
      extends Modelica.Icons.Package;

      model SeriesImpedance
        extends OmniPES.Circuit.Interfaces.SeriesComponent;
        parameter OmniPES.Units.PerUnit r = 0.0;
        parameter OmniPES.Units.PerUnit x = 0.0;
      equation
        v = Complex(r, x)*i;
        annotation(
          Icon(graphics = {Rectangle(origin = {1, -1}, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-13, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {14, 0}})}, coordinateSystem(initialScale = 0.1)));
      end SeriesImpedance;

      model SeriesAdmittance
        extends OmniPES.Circuit.Interfaces.SeriesComponent;
        parameter OmniPES.Units.PerUnit g;
        parameter OmniPES.Units.PerUnit b;
      equation
        i = Complex(g, b)*v;
        annotation(
          Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-13, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {14, 0}})}, coordinateSystem(initialScale = 0.1)));
      end SeriesAdmittance;

      model Ground
        OmniPES.Circuit.Interfaces.PositivePin p annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        p.v.re = 0;
        p.v.im = 0;
        annotation(
          Diagram,
          Icon(graphics = {Line(origin = {0, -40}, points = {{-60, 0}, {60, 0}, {60, 0}}), Line(origin = {0, -60}, points = {{-40, 0}, {40, 0}}), Line(origin = {0, -80}, points = {{-20, 0}, {20, 0}}), Line(origin = {0, -15}, points = {{0, 5}, {0, -25}})}, coordinateSystem(initialScale = 0.1)));
      end Ground;

      model Shunt_Capacitor
        parameter OmniPES.Units.ReactivePower NominalPower;
        outer OmniPES.SystemData data;
        extends OmniPES.Circuit.Basic.ShuntAdmittance(g = 0, b = NominalPower/data.Sbase);
        annotation(
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(origin = {-21.0002, -2.2362e-05}, points = {{-13, 0}, {13, 0}}), Line(origin = {20.9998, -2.2362e-05}, points = {{-13, 0}, {13, 0}}), Line(origin = {-8.00024, -3.00002}, points = {{0, 23}, {0, -17}}), Line(origin = {7.99976, -3.00002}, points = {{0, 23}, {0, -17}})}));
      end Shunt_Capacitor;

      model ShuntAdmittance
        extends OmniPES.Circuit.Interfaces.ShuntComponent;
        //protected
        parameter OmniPES.Units.PerUnit g;
        parameter OmniPES.Units.PerUnit b;
      equation
        i = Complex(g, b)*v;
        annotation(
          Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-27, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {24, 0}}), Line(origin = {112, 0}, points = {{0, 22}, {0, -22}}), Line(origin = {100, 0}, points = {{0, 30}, {0, -30}}), Line(origin = {122, 0}, points = {{0, 12}, {0, -12}})}, coordinateSystem(initialScale = 0.1)));
      end ShuntAdmittance;

      model TwoWindingTransformer
        outer OmniPES.SystemData data;
        parameter OmniPES.Units.ApparentPower NominalMVA = data.Sbase;
        parameter OmniPES.Units.PerUnit r = 0;
        parameter OmniPES.Units.PerUnit x;
        parameter Real tap = 1.0;
        OmniPES.Circuit.Interfaces.PositivePin p(v.re(start = 1)) annotation(
          Placement(visible = true, transformation(origin = {-66, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.NegativePin n(v.re(start = 1)) annotation(
          Placement(visible = true, transformation(origin = {56, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance Z(r = r*data.Sbase/NominalMVA, x = x*data.Sbase/NominalMVA) annotation(
          Placement(visible = true, transformation(origin = {26, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.IdealTransformer idealTransformer(a = tap) annotation(
          Placement(visible = true, transformation(origin = {-30, 14}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
      equation
        connect(p, idealTransformer.p) annotation(
          Line(points = {{-66, 14}, {-46, 14}}, color = {0, 0, 255}));
        connect(idealTransformer.n, Z.p) annotation(
          Line(points = {{-14.6, 14}, {15.4, 14}}, color = {0, 0, 255}));
        connect(Z.n, n) annotation(
          Line(points = {{36, 13.8}, {56, 13.8}}, color = {0, 0, 255}));
        annotation(
          Icon(graphics = {Rectangle(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}), Ellipse(origin = {-17, 0}, extent = {{-28, 28}, {28, -28}}, endAngle = 360), Ellipse(origin = {17, 0}, extent = {{-28, 28}, {28, -28}}, endAngle = 360), Line(origin = {-72, 0}, points = {{-30, 0}, {27, 0}}), Line(origin = {72, 0}, points = {{-27, 0}, {30, 0}}), Ellipse(origin = {-60, 40}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
      end TwoWindingTransformer;

      model TLine
        outer OmniPES.SystemData data;
        parameter OmniPES.Units.PerUnit r;
        parameter OmniPES.Units.PerUnit x;
        parameter OmniPES.Units.ReactivePower Q;
        OmniPES.Circuit.Interfaces.PositivePin p annotation(
          Placement(visible = true, transformation(origin = {-40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.NegativePin n annotation(
          Placement(visible = true, transformation(origin = {40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance Z(r = r, x = x) annotation(
          Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.Shunt_Capacitor Ypp(NominalPower = Q/2) annotation(
          Placement(visible = true, transformation(origin = {-26, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.Shunt_Capacitor Ynn(NominalPower = Q/2) annotation(
          Placement(visible = true, transformation(origin = {24, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      equation
        connect(Z.n, n) annotation(
          Line(points = {{10, 52}, {40, 52}}, color = {0, 0, 255}));
        connect(p, Z.p) annotation(
          Line(points = {{-40, 52}, {-10, 52}}, color = {0, 0, 255}));
        connect(Ypp.p, Z.p) annotation(
          Line(points = {{-26, 36}, {-26, 44}, {-10, 44}, {-10, 52}}, color = {0, 0, 255}));
        connect(Ynn.p, Z.n) annotation(
          Line(points = {{24, 38}, {24, 44}, {10, 44}, {10, 52}}, color = {0, 0, 255}));
        annotation(
          Icon(graphics = {Rectangle(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}), Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}})}, coordinateSystem(initialScale = 0.1)));
      end TLine;

      model TLine_switched
        outer OmniPES.SystemData data;
        parameter OmniPES.Units.PerUnit r;
        parameter OmniPES.Units.PerUnit x;
        parameter OmniPES.Units.ReactivePower Q;
        OmniPES.Circuit.Interfaces.PositivePin p annotation(
          Placement(visible = true, transformation(origin = {-86, 54}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.NegativePin n annotation(
          Placement(visible = true, transformation(origin = {90, 54}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.SeriesImpedance Z(r = r, x = x) annotation(
          Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Basic.Shunt_Capacitor Ypp(NominalPower = Q/2) annotation(
          Placement(visible = true, transformation(origin = {-12, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.Shunt_Capacitor Ynn(NominalPower = Q/2) annotation(
          Placement(visible = true, transformation(origin = {12, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        parameter Real t_open = 0.3;
        Circuit.Switches.TimedBreaker brk_p(t_open = t_open) annotation(
          Placement(visible = true, transformation(origin = {-46, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Switches.TimedBreaker brk_n(t_open = t_open) annotation(
          Placement(visible = true, transformation(origin = {48, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(Z.p, Ypp.p) annotation(
          Line(points = {{-10, 52}, {-12, 52}, {-12, 38}}, color = {0, 0, 255}));
        connect(Z.n, Ynn.p) annotation(
          Line(points = {{10, 52}, {12, 52}, {12, 38}}, color = {0, 0, 255}));
        connect(p, brk_p.p) annotation(
          Line(points = {{-86, 54}, {-56, 54}, {-56, 52}}, color = {0, 0, 255}));
        connect(brk_p.n, Z.p) annotation(
          Line(points = {{-36, 52}, {-10, 52}}, color = {0, 0, 255}));
        connect(Z.n, brk_n.p) annotation(
          Line(points = {{10, 52}, {38, 52}}, color = {0, 0, 255}));
        connect(brk_n.n, n) annotation(
          Line(points = {{58, 52}, {74, 52}, {74, 54}, {90, 54}}, color = {0, 0, 255}));
        annotation(
          Icon(graphics = {Rectangle(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}), Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}}), Text(origin = {-2, -18}, extent = {{38, -38}, {-38, 38}}, textString = "SW")}, coordinateSystem(initialScale = 0.1)));
      end TLine_switched;

      model TLine_eq
        outer OmniPES.SystemData data;
        parameter OmniPES.Units.PerUnit r;
        parameter OmniPES.Units.PerUnit x;
        parameter OmniPES.Units.ReactivePower Q;
        OmniPES.Circuit.Interfaces.PositivePin p annotation(
          Placement(visible = true, transformation(origin = {-40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        OmniPES.Circuit.Interfaces.NegativePin n annotation(
          Placement(visible = true, transformation(origin = {40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //protected
        parameter Complex ysh(re = 1e-10, im = Q/2);
        parameter Complex ykm = 1/Complex(r, x);
      equation
        p.i = ykm*(p.v - n.v) + ysh*p.v;
        n.i = ykm*(n.v - p.v) + ysh*n.v;
//p.i.re = ykm.re * (p.v.re - n.v.re) - ykm.im * (p.v.im - n.v.im) - ysh.im * p.v.im;
//p.i.im = ykm.re * (p.v.im - n.v.im) + ykm.im * (p.v.re - n.v.re) + ysh.im * p.v.re;
//n.i.re = ykm.re * (n.v.re - p.v.re) - ykm.im * (n.v.im - p.v.im) - ysh.im * n.v.im;
//n.i.im = ykm.re * (n.v.im - p.v.im) + ykm.im * (n.v.re - p.v.re) + ysh.im * p.v.re;
        annotation(
          Icon(graphics = {Rectangle(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}), Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}})}, coordinateSystem(initialScale = 0.1)));
      end TLine_eq;
    end Basic;

    package Switches
      model Breaker
        extends OmniPES.Circuit.Switches.Interfaces.BasicBreaker;
        import OmniPES.Units;
        Modelica.Blocks.Interfaces.BooleanInput ext_open annotation(
          Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 88}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      equation
        ext_open = open;
        annotation(
          Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Line(origin = {0, 53}, points = {{0, 17}, {0, -29}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled})}),
          Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Breaker;

      model TimedBreaker
        extends OmniPES.Circuit.Switches.Interfaces.BasicBreaker;
        import OmniPES.Units;
        parameter Real t_open;
      equation
        open = if time >= t_open then true else false;
        annotation(
          Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Text(origin = {-1, -59}, extent = {{-99, 39}, {99, -39}}, textString = "%t_open [s]")}),
          Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end TimedBreaker;

      model Fault
        import OmniPES.Units;
        import Modelica.Units.SI;
        parameter Units.PerUnit R = 0;
        parameter Units.PerUnit X = 1e-3;
        parameter SI.Time t_on = 0.1;
        parameter SI.Time t_off = 0.2;
        OmniPES.Circuit.Interfaces.PositivePin T annotation(
          Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1.77636e-15, 100}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
        Boolean closed;
      protected
        OmniPES.Circuit.Switches.Breaker breaker annotation(
          Placement(visible = true, transformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        OmniPES.Circuit.Basic.ShuntAdmittance shuntAdmittance(g = R/(R^2 + X^2), b = -X/(R^2 + X^2)) annotation(
          Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      initial equation
      closed = false;
      equation
        breaker.open = not closed;
        closed = if time >= t_on and time < t_off then true else false;
        connect(breaker.p, T) annotation(
          Line(points = {{0, 86}, {0, 110}}, color = {0, 0, 255}));
        connect(breaker.n, shuntAdmittance.p) annotation(
          Line(points = {{0, 66}, {0, 50}}, color = {0, 0, 255}));
      protected
        annotation(
          Icon(coordinateSystem(grid = {0.5, 0.5}, initialScale = 0.1), graphics = {Line(origin = {10, 60}, points = {{-20, 0}, {20, 0}}), Line(origin = {-20, 44}, points = {{10, 16}, {-10, -16}}), Line(origin = {20, 44}, points = {{10, 16}, {-10, -16}}), Line(origin = {20, 12}, points = {{10, 16}, {-10, -16}}), Line(origin = {-20, 12}, points = {{10, 16}, {-10, -16}, {-10, -16}}), Line(origin = {-20, -20}, points = {{10, 16}, {-10, -40}}), Line(origin = {-20, 28}, points = {{-10, 0}, {10, 0}}), Line(origin = {20, 28}, points = {{-10, 0}, {10, 0}}), Line(origin = {-20, -4}, points = {{-10, 0}, {10, 0}}), Line(origin = {12, -20}, points = {{10, 16}, {-42, -40}}), Line(origin = {16, -4}, points = {{-6, 0}, {6, 0}}), Rectangle(origin = {-15, -1}, extent = {{-45, 71}, {75, -71}}), Line(origin = {0, 86}, points = {{0, 16}, {0, -16}})}),
          Diagram(coordinateSystem(grid = {0.5, 0.5})),
          __OpenModelica_commandLineOptions = "");
      end Fault;

      package Interfaces
        extends Modelica.Icons.InterfacesPackage;

        partial model BasicBreaker
          extends OmniPES.Circuit.Interfaces.SeriesComponent;
          import OmniPES.Units;
          Boolean open(start = false);
        protected
          parameter Real Ron(final min = 0) = 1e-6;
          parameter Real Goff(final min = 0) = 1e-6;
          Complex s(re(start = 0)) "Auxiliary variable";
        equation
//v = s*(if open then 1 else Ron);
//i = s*(if open then Goff else 1);
          if open then
            v = s;
            i = Complex(0);
          else
            v = Complex(0);
            i = s;
          end if;
          annotation(
            Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Line(origin = {-70, 0}, points = {{-30, 0}, {30, 0}}, thickness = 1), Line(origin = {70, 0}, points = {{-30, 0}, {30, 0}}, thickness = 1), Line(origin = {-40, 0}, points = {{0, 0}, {69.28, 40}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 6), Line(origin = {50, 0}, points = {{-10, 10}, {10, -10}, {10, -10}}), Line(origin = {50, 0}, points = {{-10, -10}, {10, 10}, {10, 10}})}),
            Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end BasicBreaker;
      end Interfaces;
      annotation(
        Icon(coordinateSystem(initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Line(origin = {-70, 0}, points = {{-10, 0}, {30, 0}}, thickness = 1), Line(origin = {70, 0}, points = {{-20, 0}, {10, 0}}, thickness = 1), Line(origin = {-40, 0}, points = {{0, 0}, {69.28, 40}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 6), Line(origin = {50, 0}, points = {{-10, 10}, {10, -10}, {10, -10}}), Line(origin = {50, 0}, points = {{-10, -10}, {10, 10}, {10, 10}}), Rectangle(lineThickness = 1, extent = {{-100, 100}, {100, -100}}), Ellipse(origin = {-80, 0}, fillPattern = FillPattern.Solid, extent = {{2, 2}, {-2, -2}}, endAngle = 360), Ellipse(origin = {80, 0}, fillPattern = FillPattern.Solid, extent = {{2, 2}, {-2, -2}}, endAngle = 360)}),
        Diagram(coordinateSystem(extent = {{-100, -150}, {100, 100}})));
    end Switches;
  end Circuit;
  annotation(
    uses(Modelica(version = "4.0.0")),
    version = "0.1",
    versionDate = "2022-11-23",
    versionBuild = 1);
end OmniPES;