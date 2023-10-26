# **OmniPES** Power Systems Analysis Library

The OmniPES library is the main outcome of a learning experience in which we investigated how we could effectively use the Modelica language for modeling and analyzing electrical power systems. As the library matured, we started to structure it along the same lines as industrial-grade power-flow and transient stability programs employ for modeling bulk power systems.

Two modeling frameworks are provided for steady-state and transient stability analysis. In the first framework,power-flow restrictions are enforced at all times during a simulation. The second one, on the other hand, considers the premises of transient stability programs, which allow the inclusion of slow dynamics associated with generation, load, and other system controlling devices.

In our development, we considered from the start that initial operating conditions should be established through embedded power-flow restrictions applied to power plants, loads, and any other dynamic devices. This design strategy aimed at facilitating rapid prototyping of small to medium-scale power systems, eliminating the necessity of importing power flow results from third-party programs.

Having both steady-state and transient stability frameworks available in a single library also enables the development of long-term simulations, usually employed for voltage and frequency stability analysis.