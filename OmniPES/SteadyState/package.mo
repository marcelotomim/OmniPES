within OmniPES;

package SteadyState
  annotation(Documentation(info="<html>
<body>
<h4>Overview</h4>
<p>
The <strong>SteadyState</strong> subpackage contains models for traditional power flow analysis where power-flow restrictions (Kirchhoff's laws) are enforced at each time step. Power flow equations are solved at every time step, with time acting as a parameterization variable for load/generation variations. This framework is suitable for daily load profiles, generation ramps, and wind speed profiles, without modeling fast electromagnetic or electromechanical dynamics.
</p>

<h4>Main Subpackages</h4>
<ul>
<li><a href=\"modelica://OmniPES.SteadyState.Sources\">Sources</a> &mdash; Power sources specified by their control variables (PQ, PV, VTH) with optional reactive power limits</li>
<li><a href=\"modelica://OmniPES.SteadyState.Loads\">Loads</a> &mdash; Voltage-dependent ZIP load models for steady-state analysis</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples\">Examples</a> &mdash; Demonstration models including radial systems, power flow with Q-limits, and benchmark systems</li>
</ul>

<h4>Usage</h4>
<p>
Use SteadyState models when analyzing power systems under quasi-static conditions, where system dynamics are slow enough that power flow constraints remain satisfied continuously. Combine with Circuit components to build complete network models. For dynamic studies including machine dynamics and controllers, use the <a href=\"modelica://OmniPES.Transient\">Transient</a> subpackage instead.
</p>
</body>
</html>"));
end SteadyState;