# **OmniPES**: Modelica Library for Power Systems Simulation

## Table of Contents
- [Overview](#overview)
- [Why OmniPES?](#why-omnipes)
- [Features at a Glance](#features-at-a-glance)
- [Library Architecture](#library-architecture)
- [Core Concepts](#core-concepts)
- [Subpackages](#subpackages)
- [Getting Started](#getting-started)
- [Examples](#examples)
- [Advanced Topics](#advanced-topics)
- [Contributing & Support](#contributing--support)
- [Citation](#citation)
- [License](#license)
- [Authors](#authors)
- [References](#references)

---

## Overview

The OmniPES library is the main outcome of a learning experience in which we investigated how we could effectively use the Modelica language for modeling and analyzing electrical power systems. As the library matured, it was structured along the same lines as industrial-grade power-flow and transient stability programs employ for modeling bulk power systems.

At the present stage of the development, the OmniPES library provides mainly two analysis frameworks: **steady-state** and **transient stability**. In the first framework, power-flow restrictions are enforced at all times during a simulation. The second one, on the other hand, considers the premises of transient stability programs, which allow the inclusion of slow dynamics associated with generation, load, and other system controlling devices. 

### Key Features

- **Dual Analysis Frameworks**: Steady-state power flow analysis and transient stability analysis
- **Embedded Power Flow**: Power-flow restrictions are embedded within models, eliminating the need for external power flow calculations
- **No External Dependencies**: Initial conditions are automatically determined through embedded power-flow restrictions—no need to import results from third-party tools
- **Rapid Prototyping**: Enables quick development of small to medium-scale power system models
- **Sigmoid-Based Reactive Power Limits**: Advanced constraint enforcement for reactive power output that supports backoff procedures
- **Quasi-Steady-State Capability**: Supports long-term simulations for voltage and frequency stability analysis
- **Positive-Sequence Models**: Based on positive-sequence analysis for bulk power system modeling
- **Open Source**: Developed with OpenModelica (version 1.22.2+) and based on MSL 4.0.0
- **Production-Grade Structure**: Organized along the same lines as industrial-grade power-flow and transient stability programs

### Library Version
- Version: 0.1
- Version Date: 2022-11-23
- Base Library: Modelica Standard Library (MSL) 4.0.0
- Development Environment: OpenModelica 1.22.2~12-g3b7ae01

---

## Why OmniPES?

### Motivation

Modern electric power systems face unprecedented challenges with the rapid integration of distributed energy resources (DERs), renewable energy sources, and advanced power converters. These developments require sophisticated modeling and analysis tools that can:

1. **Rapidly prototype power system models** for small to medium-scale systems without external computational dependencies
2. **Enable seamless integration** of traditional and innovative control systems (e.g., secondary voltage regulation, frequency support)
3. **Support multiple analysis frameworks** (steady-state, transient stability, and quasi-steady-state) within a single environment
4. **Follow industry best practices** in power system modeling, matching the structure of production-grade tools like PSS/E and PSAT

### Key Advantages Over Alternatives

Unlike other Modelica libraries for power systems, OmniPES:

- **Eliminates external power flow dependency**: Initial conditions are implicitly determined through embedded power-flow restrictions, removing the need for third-party load-flow programs
- **Supports advanced reactive power management**: Implements sigmoid-based switches for smooth constraint enforcement with automatic backoff capabilities
- **Provides a unified simulation environment**: Combine steady-state and transient models seamlessly for long-term analysis without switching tools
- **Designed for education and research**: Enables students and professionals to rapidly develop, validate, and integrate control systems for modern power grids

---

## Library Architecture

The OmniPES library is organized hierarchically into five main subpackages:

```
OmniPES/
├── Circuit/              # Basic circuit components
├── SteadyState/          # Power flow analysis framework
├── Transient/            # Transient stability framework
├── Math/                 # Mathematical utilities
├── Scopes/               # Measurement and monitoring components
└── Icons/                # Icon definitions
```

### Design Philosophy

The library follows these key design principles:

1. **Embedded Power-Flow Restrictions**: Unlike traditional simulation tools, OmniPES embeds power-flow restrictions directly into component models, ensuring initial operating conditions are self-contained.

2. **Modularity**: Components are designed as building blocks that can be easily combined to create larger system models.

3. **Positive-Sequence Representation**: All models use positive-sequence representation, simplifying analysis while capturing essential dynamics for most studies.

4. **Compatibility**: Built on MSL 4.0.0, ensuring compatibility with the Modelica standard and broad simulator support.

---

## Core Concepts

### Base Parameters

All power system quantities in OmniPES are expressed in per-unit (p.u.) form using base values defined in the **SystemData** model:

- Source: [`OmniPES/SystemData.mo`](OmniPES/SystemData.mo)
- **Sbase**: Base apparent power (default: 100 MVA) - used for power normalization
- **fb**: Base frequency (default: 60 Hz) - used for angular velocity calculations
- **wb**: Base angular velocity = 2π × fb

The `SystemData` model must be instantiated as an inner component at the top level of any system model.

### Voltage Representation

Voltages are represented as complex numbers in the Modelica `Complex` type, automatically handling both magnitude and angle:

$$V = V_{\text{re}} + j V_{\text{im}}$$

Buses and nodes provide interfaces to extract:
- **V**: Voltage magnitude in p.u.
- **angle**: Voltage phase angle in radians (or degrees)

### Power Flow

Power is represented as complex power in p.u.:

$$S = P + jQ$$

Where:
- **P**: Active power in p.u. (base = Sbase)
- **Q**: Reactive power in p.u. (base = Sbase)

---

## Subpackages

### 1. Circuit Subpackage

The **Circuit** subpackage contains fundamental network elements for positive-sequence power system analysis.

#### Location
`OmniPES.Circuit`

#### Contents

**a) Interfaces (`Circuit.Interfaces`)**

This package defines the architectural foundation for all network components. It provides partial models (abstract base classes) and connectors that establish the standard interface for power system elements.

**Connectors**:
- **PositivePin**: Positive terminal connector for series components
  - Source: [`OmniPES/Circuit/Interfaces/PositivePin.mo`](OmniPES/Circuit/Interfaces/PositivePin.mo)
  - Variables: Complex voltage `v` and current `i`
  
- **NegativePin**: Negative terminal connector for series components
  - Source: [`OmniPES/Circuit/Interfaces/NegativePin.mo`](OmniPES/Circuit/Interfaces/NegativePin.mo)
  - Variables: Complex voltage `v` and current `i`

**Partial Models** (Abstract Base Classes):

- **Bus**: Network bus/node element
  - Type: Concrete model (not partial)
  - Purpose: Represents a network junction point
  - Interface: Single PositivePin p
  - Functionality: 
    - Enforces zero current injection (Kirchhoff's Current Law)
    - Extracts voltage magnitude and angle
  - Source: [`OmniPES/Circuit/Interfaces/Bus.mo`](OmniPES/Circuit/Interfaces/Bus.mo)
  - Usage: Connect series and shunt components to establish the network topology
  
- **SeriesComponent**: Base model for series network elements
  - Type: Partial model (abstract base)
  - Interface: Two terminals (PositivePin p, NegativePin n)
  - Key equations: Voltage drop across element, current continuity (KCL)
  - Source: [`OmniPES/Circuit/Interfaces/SeriesComponent.mo`](OmniPES/Circuit/Interfaces/SeriesComponent.mo)
  - Extended by: `SeriesImpedance`, `SeriesAdmittance`
  - Purpose: Ensures consistent interface and automatic current conservation
  
- **ShuntComponent**: Base model for shunt network elements
  - Type: Partial model (abstract base)
  - Interface: Single terminal (PositivePin p) connecting to ground
  - Key equations: Node voltage and current injection
  - Source: [`OmniPES/Circuit/Interfaces/ShuntComponent.mo`](OmniPES/Circuit/Interfaces/ShuntComponent.mo)
  - Extended by: `ShuntImpedance`, `ShuntAdmittance`, `Shunt_Capacitor`, `Shunt_Reactor`
  - Purpose: Establishes common structure for elements connecting between bus and ground
  
- **IdealTransformer**: Base for ideal transformer connections
  - Type: Partial model (abstract base)
  - Purpose: Models ideal transformer with tap ratio `a`
  - Source: [`OmniPES/Circuit/Interfaces/IdealTransformer.mo`](OmniPES/Circuit/Interfaces/IdealTransformer.mo)
  - Usage: Used internally by `TwoWindingTransformer` in series composition

**Inheritance Hierarchy**:
```
SeriesComponent (partial)
├── SeriesImpedance
├── SeriesImpedance_switched
└── SeriesAdmittance

ShuntComponent (partial)
├── ShuntImpedance
├── ShuntAdmittance
├── Shunt_Capacitor (extends ShuntAdmittance)
└── Shunt_Reactor (extends ShuntAdmittance)

Composite (does not extend partial):
├── TLine (uses coupled equations)
├── TLine_switched (extends TLine)
├── TwoWindingTransformer (composition: IdealTransformer + SeriesImpedance)
└── Ground (voltage reference only)

Standalone:
└── Bus (node with voltage extraction)
```

---

**b) Basic Components (`Circuit.Basic`)**

Components in this section implement physical network elements. They extend the partial models defined in `Circuit.Interfaces` to inherit standard connector and equation structures.

**Series Components**:
- **SeriesImpedance** → extends [`SeriesComponent`](#seriescomponent-base-model-for-series-network-elements)
  - Parameters: Resistance (r) and reactance (x)
  - Source: [`OmniPES/Circuit/Basic/SeriesImpedance.mo`](OmniPES/Circuit/Basic/SeriesImpedance.mo)
  
- **SeriesImpedance_switched** → extends [`SeriesComponent`](#seriescomponent-base-model-for-series-network-elements)
  - Enables/disables element via controlled parameter
  - Source: [`OmniPES/Circuit/Basic/SeriesImpedance_switched.mo`](OmniPES/Circuit/Basic/SeriesImpedance_switched.mo)
  
- **SeriesAdmittance** → extends [`SeriesComponent`](#seriescomponent-base-model-for-series-network-elements)
  - Models admittance-based series element
  - Source: [`OmniPES/Circuit/Basic/SeriesAdmittance.mo`](OmniPES/Circuit/Basic/SeriesAdmittance.mo)

- **TLine** → does NOT extend partial (composite model)
  - Composition: Series impedance with distributed shunt capacitance
  - Parameters: r (resistance), x (reactance), Q (shunt capacitance)
  - Internally: Uses coupled current injection equations at both ends
  - Source: [`OmniPES/Circuit/Basic/TLine.mo`](OmniPES/Circuit/Basic/TLine.mo)
  
- **TLine_switched** → extends `TLine`
  - Extends: `TLine` with additional switch control
  - Source: [`OmniPES/Circuit/Basic/TLine_switched.mo`](OmniPES/Circuit/Basic/TLine_switched.mo)
  
- **TwoWindingTransformer** → does NOT extend partial (composite model)
  - Composition: [`IdealTransformer`](#idealtransformer-base-for-ideal-transformer-connections) + [`SeriesImpedance`](#seriescomponent-base-model-for-series-network-elements)
  - Parameters: r (resistance), x (reactance), tap (transformer ratio)
  - Internal connection: PositivePin → IdealTransformer → SeriesImpedance → NegativePin
  - Source: [`OmniPES/Circuit/Basic/TwoWindingTransformer.mo`](OmniPES/Circuit/Basic/TwoWindingTransformer.mo)

**Shunt Components**:
- **ShuntImpedance** → extends [`ShuntComponent`](#shuntcomponent-base-model-for-shunt-network-elements)
  - Parameters: Resistance (r) and reactance (x)
  - Source: [`OmniPES/Circuit/Basic/ShuntImpedance.mo`](OmniPES/Circuit/Basic/ShuntImpedance.mo)
  
- **ShuntAdmittance** → extends [`ShuntComponent`](#shuntcomponent-base-model-for-shunt-network-elements)
  - Models admittance-based shunt element
  - Source: [`OmniPES/Circuit/Basic/ShuntAdmittance.mo`](OmniPES/Circuit/Basic/ShuntAdmittance.mo)
  
- **Shunt_Capacitor** → extends `ShuntAdmittance`
  - Parent: [`ShuntAdmittance`](#shuntcomponent-base-model-for-shunt-network-elements) → [`ShuntComponent`](#shuntcomponent-base-model-for-shunt-network-elements)
  - Parameter: `NominalPower` (in Mvar) for reactive power rating
  - Reactive behavior: Capacitive (positive susceptance)
  - Source: [`OmniPES/Circuit/Basic/Shunt_Capacitor.mo`](OmniPES/Circuit/Basic/Shunt_Capacitor.mo)
  
- **Shunt_Reactor** → extends `ShuntAdmittance`
  - Parent: [`ShuntAdmittance`](#shuntcomponent-base-model-for-shunt-network-elements) → [`ShuntComponent`](#shuntcomponent-base-model-for-shunt-network-elements)
  - Parameter: `NominalPower` (in Mvar) for reactive power rating
  - Reactive behavior: Inductive (negative susceptance)
  - Source: [`OmniPES/Circuit/Basic/Shunt_Reactor.mo`](OmniPES/Circuit/Basic/Shunt_Reactor.mo)

**Reference Elements**:
- **Ground** → does NOT extend any partial model
  - Purpose: Establishes voltage reference (zero potential)
  - Source: [`OmniPES/Circuit/Basic/Ground.mo`](OmniPES/Circuit/Basic/Ground.mo)
  - Use: Connect to any electrical node to establish ground reference in the network

**Component Relationship Summary**:

| Component | Base Interface | Terminals | Location | Source File |
|-----------|----------------|-----------|----------|-------------|
| **SeriesImpedance** | [`SeriesComponent`](#seriescomponent-base-model-for-series-network-elements) | Two (p, n) | Between two [`Bus`](#bus-network-busnod-element) | [SeriesImpedance.mo](OmniPES/Circuit/Basic/SeriesImpedance.mo) |
| **SeriesAdmittance** | [`SeriesComponent`](#seriescomponent-base-model-for-series-network-elements) | Two (p, n) | Between two [`Bus`](#bus-network-busnod-element) | [SeriesAdmittance.mo](OmniPES/Circuit/Basic/SeriesAdmittance.mo) |
| **ShuntImpedance** | [`ShuntComponent`](#shuntcomponent-base-model-for-shunt-network-elements) | One (p) | [`Bus`](#bus-network-busnod-element) to [`Ground`](#reference-elements) | [ShuntImpedance.mo](OmniPES/Circuit/Basic/ShuntImpedance.mo) |
| **ShuntAdmittance** | [`ShuntComponent`](#shuntcomponent-base-model-for-shunt-network-elements) | One (p) | [`Bus`](#bus-network-busnod-element) to [`Ground`](#reference-elements) | [ShuntAdmittance.mo](OmniPES/Circuit/Basic/ShuntAdmittance.mo) |
| **Shunt_Capacitor** | [`ShuntAdmittance`](#shunt-components-extend-shuntcomponent) | One (p) | [`Bus`](#bus-network-busnod-element) to [`Ground`](#reference-elements) | [Shunt_Capacitor.mo](OmniPES/Circuit/Basic/Shunt_Capacitor.mo) |
| **Shunt_Reactor** | [`ShuntAdmittance`](#shunt-components-extend-shuntcomponent) | One (p) | [`Bus`](#bus-network-busnod-element) to [`Ground`](#reference-elements) | [Shunt_Reactor.mo](OmniPES/Circuit/Basic/Shunt_Reactor.mo) |
| **TLine** | - | Two (p, n) | Between two [`Bus`](#bus-network-busnod-element) | [TLine.mo](OmniPES/Circuit/Basic/TLine.mo) |
| **TwoWindingTransformer** | - | Two (p, n) | Between two [`Bus`](#bus-network-busnod-element) | [TwoWindingTransformer.mo](OmniPES/Circuit/Basic/TwoWindingTransformer.mo) |

**c) Sources (`Circuit.Sources`)**
- **VoltageSource**: Idealized voltage source
  - Source: [`OmniPES/Circuit/Sources/VoltageSource.mo`](OmniPES/Circuit/Sources/VoltageSource.mo)
- **CurrentSource**: Idealized current source
  - Source: [`OmniPES/Circuit/Sources/CurrentSource.mo`](OmniPES/Circuit/Sources/CurrentSource.mo)
- **ControlledVoltageSource**: Voltage source with external control signal
  - Source: [`OmniPES/Circuit/Sources/ControlledVoltageSource.mo`](OmniPES/Circuit/Sources/ControlledVoltageSource.mo)

**d) Switches (`Circuit.Switches`)**
- **Breaker**: Controllable power system breaker
  - Source: [`OmniPES/Circuit/Switches/Breaker.mo`](OmniPES/Circuit/Switches/Breaker.mo)
- **TimedBreaker**: Breaker with time-scheduled switching
  - Source: [`OmniPES/Circuit/Switches/TimedBreaker.mo`](OmniPES/Circuit/Switches/TimedBreaker.mo)
- **Fault**: Fault simulation element (short-circuit)
  - Source: [`OmniPES/Circuit/Switches/Fault.mo`](OmniPES/Circuit/Switches/Fault.mo)

---

### 2. SteadyState Subpackage

The **SteadyState** subpackage contains models for traditional power flow analysis where power-flow restrictions (Kirchhoff's laws) are enforced at each time step.

#### Location
`OmniPES.SteadyState`

#### Key Characteristics
- Power flow equations solved at every time step
- Time acts as a parameterization variable for load/generation variations
- Suitable for: Daily load profiles, generation ramps, wind speed profiles
- No fast electromagnetic or electromechanical dynamics
- Fast computation suitable for operational planning studies

#### Contents

**a) Interfaces (`SteadyState.Sources.Interfaces` & `SteadyState.Loads.Interfaces`)**

Partial models (abstract base classes) that define the structure for sources and loads:

- **Partial_Source** (partial model): Base for all sources
  - Source: [`OmniPES/SteadyState/Sources/Interfaces/Partial_Source.mo`](OmniPES/SteadyState/Sources/Interfaces/Partial_Source.mo)
  - Defines common interface and behavior for power sources
  - Extended by: PQSource, PVSource, VTHSource variants

- **Partial_Load** (partial model): Base for all loads with optional external power modulation
  - Source: [`OmniPES/SteadyState/Loads/Interfaces/Partial_Load.mo`](OmniPES/SteadyState/Loads/Interfaces/Partial_Load.mo)
  - Defines common interface for dynamic loads
  - Extended by: ZIPLoad

- **LoadData** (record): Voltage-dependent load characteristics
  - Source: [`OmniPES/SteadyState/Loads/Interfaces/LoadData.mo`](OmniPES/SteadyState/Loads/Interfaces/LoadData.mo)
  - Parameters: `pi`, `qi` (constant current fractions), `pz`, `qz` (constant impedance fractions)

**b) Sources (`SteadyState.Sources`)**

Power sources are specified by their control variables (not by internal dynamics). All extend [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces):

- **PQSource**: Constant power source → extends [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Parameters: Psp, Qsp (specified P and Q)
  - Maintains specified active and reactive power injections
  - Source: [`OmniPES/SteadyState/Sources/PQSource.mo`](OmniPES/SteadyState/Sources/PQSource.mo)

- **PVSource**: Constant power and voltage source → extends [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Parameters: Psp (specified power), Vsp (specified voltage magnitude)
  - Adjusts reactive power to maintain voltage
  - Equivalent to generator with automatic voltage regulator
  - Source: [`OmniPES/SteadyState/Sources/PVSource.mo`](OmniPES/SteadyState/Sources/PVSource.mo)

- **PVSource_Qlim_sigmoid**: PV source with reactive power limits using sigmoid function → extends [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Parameters: Psp, Vsp, Qmin, Qmax, steepness
  - Smooth transition at reactive power limits
  - Source: [`OmniPES/SteadyState/Sources/PVSource_Qlim_sigmoid.mo`](OmniPES/SteadyState/Sources/PVSource_Qlim_sigmoid.mo)

- **PVSource_Qlim_discrete**: PV source with discrete reactive power limits → extends [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Parameters: Psp, Vsp, Qmin, Qmax
  - Hard switching at reactive power limits
  - Source: [`OmniPES/SteadyState/Sources/PVSource_Qlim_discrete.mo`](OmniPES/SteadyState/Sources/PVSource_Qlim_discrete.mo)

- **VTHSource**: Voltage and Thévenin impedance source → extends [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Parameters: Vth (Thévenin voltage), Zth (Thévenin impedance)
  - Models voltage source with series impedance
  - Source: [`OmniPES/SteadyState/Sources/VTHSource.mo`](OmniPES/SteadyState/Sources/VTHSource.mo)

- **VTHSource_Qlim_sigmoid**: VTH source with reactive power limits (sigmoid) → extends [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Source: [`OmniPES/SteadyState/Sources/VTHSource_Qlim_sigmoid.mo`](OmniPES/SteadyState/Sources/VTHSource_Qlim_sigmoid.mo)
  
- **VTHSource_Qlim_discrete**: VTH source with reactive power limits (discrete) → extends [`Partial_Source`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Source: [`OmniPES/SteadyState/Sources/VTHSource_Qlim_discrete.mo`](OmniPES/SteadyState/Sources/VTHSource_Qlim_discrete.mo)

**c) Loads (`SteadyState.Loads`)**

- **ZIPLoad**: Polynomial (constant impedance, constant current, constant power) load → extends [`Partial_Load`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces)
  - Parameters:
    - `Psp`, `Qsp`: Specified power at nominal voltage
    - `ss_par`: [`LoadData`](#a-interfaces-steadystatesourcesinterfaces--steadystateloadsinterfaces) record containing voltage-dependent characteristics
  - `LoadData` record parameters:
    - `pi`, `qi`: Constant current fractions (0-1)
    - `pz`, `qz`: Constant impedance fractions (0-1)
    - `pp = 1 - pi - pz`: Constant power fraction
  - Source: [`OmniPES/SteadyState/Loads/ZIPLoad.mo`](OmniPES/SteadyState/Loads/ZIPLoad.mo)

**d) Examples (`SteadyState.Examples`)**

- Minimal case: [`OmniPES.SteadyState.Examples.Test_Minimal`](OmniPES/SteadyState/Examples/Test_Minimal.mo)
- Radial power flow: [`OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow`](OmniPES/SteadyState/Examples/Test_Radial_System_Power_Flow.mo)
- Radial with Q-limits (sigmoid): [`OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow_Qlim_sigmoid`](OmniPES/SteadyState/Examples/Test_Radial_System_Power_Flow_Qlim_sigmoid.mo)
- Radial with Q-limits (discrete): [`OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow_Qlim_discrete`](OmniPES/SteadyState/Examples/Test_Radial_System_Power_Flow_Qlim_discrete.mo)
- Benchmark system: [`OmniPES.SteadyState.Examples.Kundur_Two_Area_System_SteadyState`](OmniPES/SteadyState/Examples/Kundur_Two_Area_System_SteadyState.mo)

---

### 3. Transient Subpackage

The **Transient** subpackage contains models for electromechanical transient stability analysis, including synchronous machine models and their controllers.

#### Location
`OmniPES.Transient`

#### Key Characteristics
- Includes fast and slow dynamics
- Synchronous machine models with various complexities
- Automatic voltage regulators (AVR), speed governors, power system stabilizers (PSS)
- Embedded power-flow restrictions for initial conditions
- Suitable for: Stability studies, fault analysis, controller testing

#### Contents

**a) Interfaces (`Transient.SynchronousMachines.Interfaces` & `Transient.Controllers.Interfaces`)**

Partial models and interfaces that define the structure for synchronous machines and controllers:

**Synchronous Machine Interfaces:**

- **Restriction Models** (for Initial Conditions): Define how machine initializes based on power flow
  - **Restriction_PQ**: Fixed P and Q injection
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_PQ.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_PQ.mo)
  - **Restriction_PV**: Fixed P with V control
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_PV.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_PV.mo)
  - **Restriction_VTH**: Voltage with Thévenin impedance
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_VTH.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_VTH.mo)
  - **Restriction_P**: Fixed active power only
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_P.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Restriction_P.mo)

- **Electrical Models**: Implement field winding equations and flux linkages
  - **Classical_Electric**: Classical model (constant transient impedance behind voltage)
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Classical_Electric.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Classical_Electric.mo)
  - **Model_1_0_Electric**: Model 1.0 (one damper winding in d-axis)
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Model_1_0_Electric.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Model_1_0_Electric.mo)
  - **Model_2_1_Electric**: Model 2.1 (two damper windings, one in q-axis)
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Model_2_1_Electric.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Model_2_1_Electric.mo)
  - **Model_2_2_Electric**: Model 2.2 (two damper windings in both axes)
    - Source: [`OmniPES/Transient/SynchronousMachines/Interfaces/Model_2_2_Electric.mo`](OmniPES/Transient/SynchronousMachines/Interfaces/Model_2_2_Electric.mo)

**Controller Interfaces:**

- **PartialAVR**: Base model for AVRs (partial model for user extensions)
  - Source: [`OmniPES/Transient/Controllers/Interfaces/PartialAVR.mo`](OmniPES/Transient/Controllers/Interfaces/PartialAVR.mo)
  - Extended by: ConstantEfd and custom AVR implementations in examples

- **PartialSpeedRegulator**: Base model for speed regulators/governors (partial model for user extensions)
  - Source: [`OmniPES/Transient/Controllers/Interfaces/PartialSpeedRegulator.mo`](OmniPES/Transient/Controllers/Interfaces/PartialSpeedRegulator.mo)
  - Extended by: ConstantPm and custom governor implementations in examples

- **PartialPSS**: Base class for power system stabilizers (partial model for user extensions)
  - Source: [`OmniPES/Transient/Controllers/Interfaces/PartialPSS.mo`](OmniPES/Transient/Controllers/Interfaces/PartialPSS.mo)
  - Extended by: NoPSS and custom PSS implementations in examples

**b) Synchronous Machines (`Transient.SynchronousMachines`)**

The core element of the Transient subpackage is the **GenericSynchronousMachine**, which implements various electrical models.

**GenericSynchronousMachine Model**
- Source: [`OmniPES/Transient/SynchronousMachines/GenericSynchronousMachine.mo`](OmniPES/Transient/SynchronousMachines/GenericSynchronousMachine.mo)
- Flexible framework supporting multiple electrical models (via redeclaration of [`Electrical Models`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces)):
  - **Classical Model**: Constant voltage behind transient reactance
  - **Model 1.0**: One time-constant for the excitation field in d-axis
  - **Model 2.1**: Two time-constants for the d-axis (excitation field and damper winding) and one time-constant for the q-axis (damper winding)
  - **Model 2.2**: Two time-constants for the d-axis (excitation field and damper winding) and two time-constants for the q-axis (two damper windings)

**Key Parameters:**
- Rated power (Pn, MVA)
- Rated voltage (Vn, kV)
- Rated frequency (fn)
- Direct-axis synchronous reactance (Xd, p.u.)
- Quadrature-axis synchronous reactance (Xq, p.u.)
- Direct-axis transient reactance (Xd', p.u.)
- Direct-axis subtransient reactance (Xd'', p.u.)
- Quadrature-axis transient reactance (Xq', p.u.)
- Quadrature-axis subtransient reactance (Xq'', p.u.)
- Direct-axis transient time constant (Td0')
- Direct-axis subtransient time constant (Td0'')
- Quadrature-axis transient time constant (Tq0')
- Quadrature-axis subtransient time constant (Tq0'')
- Saturation function parameters (S10, S12)
- Inertia constant (H, seconds)
- Damping coefficient (Kp, p.u.)

**Internal Structure:**
- **Electrical Model**: Redeclarable electrical models (see [`Electrical Models`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces))
- **Restriction Model**: Redeclarable initial condition models (see [`Restriction Models`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces))
- **Inertia/Rotor Model**: Mechanical inertial model.
- **Saturation Function**: Models magnetic saturation effects
- **Controllers**: Optional connections to AVR, PSS, and speed regulators (see [`Controller Interfaces`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces))

**Example Usage:**
```modelica
// Define machine data parameters
parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data(
  MVAb = 1e8, 
  D = 0, 
  H = 6.5,
  Xd = 1.8, 
  Xq = 1.7, 
  X1d = 0.3, 
  X1q = 0.55,
  X2d = 0.25, 
  X2q = 0.25, 
  T1d0 = 8, 
  T2d0 = 0.03,
  T1q0 = 0.4, 
  T2q0 = 0.05,
  Xl = 0.2,
  Ra = 0.0);

// Define restriction/initial condition parameters
parameter OmniPES.Transient.SynchronousMachines.RestrictionData gen_specs(
  Psp = 1e8, 
  Qsp = 0.0, 
  Vsp = 1.0, 
  theta_sp = 0);

// Instantiate the machine
OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine gen(
  smData = gen_data,
  specs = gen_specs,
  redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction,
  redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric electrical,
  redeclare OmniPES.Transient.Controllers.AVR.ConstantEfd avr,
  redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss,
  redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg,
  avr_on = false, 
  sreg_on = false, 
  pss_on = false);

// Connect to network
connect(bus.p, gen.terminal);
```

**c) Controllers (`Transient.Controllers`)**

Provides automatic control systems for synchronous machines. All controllers extend their respective partial models (see [`Controller Interfaces`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces)).

**AVR (Automatic Voltage Regulator) (`Controllers.AVR`)**
- **ConstantEfd**: Fixed field voltage placeholder → extends [`PartialAVR`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces)
  - Source: [`OmniPES/Transient/Controllers/AVR/ConstantEfd.mo`](OmniPES/Transient/Controllers/AVR/ConstantEfd.mo)
  - Means no AVR is considered; field voltage held constant
- Note: Example models may redeclare study-specific AVR implementations; topologies and parameters vary per case.
- Examples with implemented AVR models (AVR type in parentheses):
  - [`Transient.Examples.Test_Single_Machine`](OmniPES/Transient/Examples/Test_Single_Machine.mo) — `FieldStep` (local)
  - [`Transient.Examples.IEEE9bus`](OmniPES/Transient/Examples/IEEE9bus.mo) — `AVR_Type_I` (local)
  - [`Transient.Examples.Kundur_Two_Area_System`](OmniPES/Transient/Examples/Kundur_Two_Area_System.mo) — `IEEE_AC4A` (local)
  - [`Transient.Examples.Single_Machine_GGOV`](OmniPES/Transient/Examples/Single_Machine_GGOV.mo) — `IEEE_AC4A` (local)
  - [`Transient.Examples.PSCC24.tutorial_system`](OmniPES/Transient/Examples/PSCC24/tutorial_system.mo) — `PSCC24.Controllers.AVR` (local package)
  - [`Transient.Examples.PSCC24.tutorial_system_SVR`](OmniPES/Transient/Examples/PSCC24/tutorial_system_SVR.mo) — `PSCC24.Controllers.AVR_SRV` (local package)
  - [`Transient.Examples.PSCC24.tutorial_system_SVR_QSS`](OmniPES/Transient/Examples/PSCC24/tutorial_system_SVR_QSS.mo) — `PSCC24.Controllers.AVR_SRV` (local package)

**Speed Regulator (`Controllers.SpeedRegulators`)**
- **ConstantPm**: Fixed mechanical power placeholder → extends [`PartialSpeedRegulator`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces)
  - Source: [`OmniPES/Transient/Controllers/SpeedRegulators/ConstantPm.mo`](OmniPES/Transient/Controllers/SpeedRegulators/ConstantPm.mo)
  - Means no governor is considered; mechanical power held constant
- Examples with implemented speed regulator/governor models (type in parentheses):
  - [`Transient.Examples.Single_Machine_GGOV`](OmniPES/Transient/Examples/Single_Machine_GGOV.mo) — `IEEE_GGOV1` (local)
  - [`Transient.Examples.PSCC24.tutorial_system`](OmniPES/Transient/Examples/PSCC24/tutorial_system.mo) — `PSCC24.Controllers.SpeedGovernor`
  - [`Transient.Examples.PSCC24.tutorial_system_SVR`](OmniPES/Transient/Examples/PSCC24/tutorial_system_SVR.mo) — `PSCC24.Controllers.SpeedGovernor`
  - [`Transient.Examples.PSCC24.tutorial_system_SVR_QSS`](OmniPES/Transient/Examples/PSCC24/tutorial_system_SVR_QSS.mo) — `PSCC24.Controllers.SpeedGovernor`

**Power System Stabilizer (PSS) (`Controllers.PSS`)**
- **NoPSS** placeholder → extends [`PartialPSS`](#a-interfaces-transientsynchronousmachinesinterfaces--transientcontrollersinterfaces)
  - Source: [`OmniPES/Transient/Controllers/PSS/NoPSS.mo`](OmniPES/Transient/Controllers/PSS/NoPSS.mo)
  - Means no stabilizer is present; no stabilizing action
- Additional PSS models are not included in the base library.
- Examples with implemented PSS models (PSS type in parentheses):
  - [`Transient.Examples.Kundur_Two_Area_System`](OmniPES/Transient/Examples/Kundur_Two_Area_System.mo) — `PSS_1` (local)
  - [`Transient.Examples.Single_Machine_GGOV`](OmniPES/Transient/Examples/Single_Machine_GGOV.mo) — `PSS_1` (local)

**d) Blocks (`Controllers.Blocks`)**
Reusable control system building blocks:
- **LagLimit**: Lag with Limiter
  - Source: [`OmniPES/Transient/Controllers/Blocks/LagLimit.mo`](OmniPES/Transient/Controllers/Blocks/LagLimit.mo)
- **IntegratorLimit**: Integrator with anti-windup limiter
  - Source: [`OmniPES/Transient/Controllers/Blocks/IntegratorLimit.mo`](OmniPES/Transient/Controllers/Blocks/IntegratorLimit.mo)

**e) Loads (`Transient.Loads`)**

Dynamic load models for transient stability analysis.

- **ZIPLoad**: Dynamic polynomial load with distinct behavior for steady-state and transient conditions.
  - Parameters: Psp, Qsp, distinct `LoadData` records for steady-state and transient, `ss_par` and `dyn_par`, respectively.
  - Source: [`OmniPES/Transient/Loads/ZIPLoad.mo`](OmniPES/Transient/Loads/ZIPLoad.mo)

**f) FACTS (`Transient.FACTS`)**

Currently includes **STATCOM_simple**. Other FACTS devices (e.g., SVC, TCSC) are not included.
- **STATCOM_simple**: Static synchronous compensator
  - Source: [`OmniPES/Transient/FACTS/STATCOM_simple.mo`](OmniPES/Transient/FACTS/STATCOM_simple.mo)

**g) Examples (`Transient.Examples`)**
- **Kundur_Two_Area_System**: Benchmark two-area system with transient dynamics ([open](OmniPES/Transient/Examples/Kundur_Two_Area_System.mo))
- **IEEE9bus**: IEEE 9-bus test system ([open](OmniPES/Transient/Examples/IEEE9bus.mo))
- **Single_Machine_GGOV**: Single machine with governor-turbine model ([open](OmniPES/Transient/Examples/Single_Machine_GGOV.mo))
- **Test_Radial_System**: Radial system with transient models ([open](OmniPES/Transient/Examples/Test_Radial_System.mo))
- **Test_Generic_Machine**: Generic machine testing ([open](OmniPES/Transient/Examples/Test_Generic_Machine.mo))
- **Test_Breaker**: Breaker operation simulation ([open](OmniPES/Transient/Examples/Test_Breaker.mo))

#### Using Transient Models

For a complete, working setup (generator, network, fault, restriction/electrical redeclares, AVR/pss/gov toggles), open the library example [`OmniPES.Transient.Examples.Test_Radial_System`](OmniPES/Transient/Examples/Test_Radial_System.mo).

---

### 4. Math Subpackage

#### Location
`OmniPES.Math`

#### Contents

**Utility Functions:**

- **polar2cart**: Convert polar coordinates (magnitude, angle) to Cartesian (real, imaginary)
  - Source: [`OmniPES/Math/polar2cart.mo`](OmniPES/Math/polar2cart.mo)

- **sys2qd**: Transform phasor quantities from system reference frame to machine (d-q) reference frame
  - Used for transient stability calculations
  - Source: [`OmniPES/Math/sys2qd.mo`](OmniPES/Math/sys2qd.mo)

- **sigmoid**: Smooth transition function
  - Used for reactive power limit implementations
  - Provides smooth curve instead of hard switching
  - Source: [`OmniPES/Math/sigmoid.mo`](OmniPES/Math/sigmoid.mo)

---

### 5. Scopes Subpackage

#### Location
`OmniPES.Scopes`

#### Contents

**Measurement Components:**

- **Ammeter**: Measures current and power flowing through a component
  - Computes: 
    - `I`: Current magnitude in p.u.
    - `theta`: Current phase angle in radians
    - `S`: Complex power entering the ammeter
  - Behavior: Acts as ideal short circuit (zero voltage drop)
  - Typical placement: In series with branches
  - Source: [`OmniPES/Scopes/Ammeter.mo`](OmniPES/Scopes/Ammeter.mo)

**Note on Voltage Measurements:**
For voltages, use the `Bus` provided signals (no separate voltmeter model in the library).

---

### 6. Icons Subpackage

#### Location
`OmniPES.Icons`

Contains icon definitions for visual representation in Modelica tools:
- **Vsource**: Voltage source icon
  - Source: [`OmniPES/Icons/Vsource.mo`](OmniPES/Icons/Vsource.mo)
- **Isource**: Current source icon
  - Source: [`OmniPES/Icons/Isource.mo`](OmniPES/Icons/Isource.mo)

---

## Getting Started

### Prerequisites
- OpenModelica version 1.22.2 or later
- Modelica Standard Library 4.0.0
- Understanding of power systems and Modelica basics

### Basic Workflow

#### Step 1: Set Up System Data

Every OmniPES model must include a `SystemData` component at the top level:

```modelica
model MyPowerSystem
  inner SystemData data(
    Sbase = 100e6,    // 100 MVA base
    fb = 60);          // 60 Hz base frequency
  
  // ... rest of model
end MyPowerSystem;
```

#### Step 2: Create Network Components

```modelica
// Define nodes/buses
OmniPES.Circuit.Interfaces.Bus B1, B2;

// Add transmission line
OmniPES.Circuit.Basic.TLine TL_12(r=0.05, x=0.15, Q=50e6);
connect(B1.p, TL_12.p);
connect(TL_12.n, B2.p);
```

#### Step 3: Add Power Sources

**For Steady-State Analysis:**
```modelica
OmniPES.SteadyState.Sources.PVSource Gen(
  Psp = 700e6,    // 700 MW
  Vsp = 1.05);    // 1.05 p.u.
connect(B1.p, Gen.p);
```

**For Transient Analysis:**
```modelica
// Define machine data parameters
parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data(
  MVAb = 700e6,
  H = 5.0,
  Xd = 1.8,
  Xq = 1.7,
  X1d = 0.3,
  // ... other machine parameters
);

// Define restriction/initial condition parameters
parameter OmniPES.Transient.SynchronousMachines.RestrictionData gen_specs(
  Psp = 700e6,
  Vsp = 1.05
);

// Instantiate the machine
OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine Gen(
  smData = gen_data,
  specs = gen_specs,
  redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction
);
connect(B2.p, Gen.terminal);
```

#### Step 4: Add Loads

```modelica
// Define load characteristics
parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData(
  pi = 0.3,  // 30% constant current
  pz = 0.3,  // 30% constant impedance
  qi = 0.3,  // 30% constant current (reactive)
  qz = 0.3   // 30% constant impedance (reactive)
  // Remaining 40% is constant power (pp = 1 - pi - pz)
);

// Steady-state load
OmniPES.SteadyState.Loads.ZIPLoad Load1(
  Psp = 100e6,
  Qsp = 20e6,
  ss_par = loadData);
connect(B2.p, Load1.p);

// Define transient load dynamics characteristics
parameter OmniPES.Transient.Loads.Interfaces.LoadData dynLoadData(
  pi = 0.0,  // 0% constant current during transients
  pz = 1.0,  // 100% constant impedance during transients
  qi = 0.0,  // 0% constant current (reactive) during transients
  qz = 1.0   // 100% constant impedance (reactive) during transients
);

// Transient load
OmniPES.Transient.Loads.ZIPLoad Load2(
  Psp = 100e6,
  Qsp = 20e6,
  ss_par = loadData,      // Steady-state behavior
  dyn_par = dynLoadData);  // Transient behavior
connect(B3.p, Load2.p);
```

### Custom Component Development

To create custom models:

1. **For Circuit elements**: Extend `Circuit.Interfaces.SeriesComponent` or `ShuntComponent`
2. **For Sources**: Extend `SteadyState.Sources.Interfaces.Partial_Source`
3. **For Loads**: Extend `SteadyState.Loads.Interfaces.Partial_Load`
4. **For Controllers**: Extend `Transient.Controllers.Interfaces.PartialAVR` or `PartialPSS`

Example:

```modelica
within MyPackage;

model CustomLoad
  extends OmniPES.SteadyState.Loads.Interfaces.Partial_Load;
  
  equation
    // Custom load model equations
    S.re = Psp/data.Sbase * (V/V_rated)^np;
    S.im = Qsp/data.Sbase * (V/V_rated)^nq;
    
end CustomLoad;
```

---

## References

### Key Standards and Documents

1. **IEEE Std 421.5-2005**: IEEE Recommended Practice for Excitation System Models for Power System Stability Studies
  - Defines standard excitation system models (AVR). Example models in this library may redeclare user-supplied AVRs depending on the study.

2. **Modelica Standard Library (MSL) 4.0.0**
   - Official MSL documentation: https://github.com/modelica/ModelicaStandardLibrary
   - Provides base types, units, constants

3. **OpenModelica Documentation**
   - Official OpenModelica documentation: https://openmodelica.org/
   - Version 1.22.2+

<!-- ### Related Papers and References

- Kundur benchmark systems (Kundur, P., et al., 1994)
  - Two-area system for transient stability analysis
  - Available in `Examples` subpackages

- Power System Dynamics and Stability
  - Classic references on power system modeling
  - NEPLAN and PSS/E are industrial equivalents -->

<!-- ### Library Development Notes

- **Author/Contributors**: Library developed as learning experience
- **License**: As per project licensing
- **Version Control**: Track updates and modifications
- **Testing**: Include test cases for validation -->

---

## Component Quick Reference

| Component | Package | Type | Use Case |
|-----------|---------|------|----------|
| Bus | Circuit.Interfaces | Node | Network junction |
| TLine | Circuit.Basic | Series | Transmission line |
| TwoWindingTransformer | Circuit.Basic | Series | Power transformer |
| PQSource | SteadyState.Sources | Source | Constant P, Q generator |
| PVSource | SteadyState.Sources | Source | Constant P, variable Q |
| ZIPLoad | SteadyState.Loads | Load | Voltage-dependent load (SS) |
| GenericSynchronousMachine | Transient.Machines | Generator | Dynamic machine (TS) |
| ZIPLoad | Transient.Loads | Load | Dynamic polynomial load (TS) |
| Ammeter | Scopes | Measurement | Current measurement |

---

**Library Version**: 0.1  
**Last Updated**: December 2024  
**Modelica Standard Library**: 4.0.0  
**OpenModelica Version**: 1.22.2+

---

## Contributing & Support

### How to Contribute

We welcome contributions from the community! To contribute:

1. **Report Issues**: Use the [GitHub Issues](https://github.com/marcelotomim/OmniPES/issues) page to report bugs or suggest improvements
2. **Submit Enhancements**: Fork the repository, make your changes, and submit a pull request
3. **Extend the Library**: Add new component models, controllers, or examples following the library structure

### Support & Feedback

- **Questions & Discussion**: Open an issue with the `question` label
- **Bug Reports**: Include model details, error messages, and steps to reproduce
- **Feature Requests**: Describe the use case and proposed implementation
- **Contact**: For direct inquiries, reach out to the development team (see [Authors](#authors) section below)

### Guidelines for Contributors

- Follow Modelica naming conventions and the library's modular structure
- Document new models with detailed comments and example usage
- Test models with OpenModelica 1.22.2+ before submitting
- Ensure compatibility with MSL 4.0.0

---

## Citation

If you use OmniPES in your research or work, please cite:

### BibTeX
```bibtex
@article{OmniPES,
  title={Introduction to {OmniPES}: A {Modelica} Library for Power Systems Modeling and Analysis},
  author={Tomim, Marcelo A. and Henriques, Ricardo M. and Passos Filho, João A.},
  journal={IEEE Access},
  volume={13},
  year={2025},
  doi={10.1109/ACCESS.2024.0429000}
}
```

### Plain Text
Tomim, M. A., Henriques, R. M., & Passos Filho, J. A. (2025). Introduction to OmniPES: A Modelica Library for Power Systems Modeling and Analysis. *IEEE Access*, vol. 13. DOI: 10.1109/ACCESS.2024.0429000

<!-- ---

## License

This library is released under the **MIT License**. See the LICENSE file in the repository for details. -->

---

## Authors

- **Marcelo A. Tomim** - Federal University of Juiz de Fora (UFJF), Brazil  
  Email: marcelo.tomim@ufjf.br

- **Ricardo M. Henriques** (Senior Member, IEEE) - Federal University of Juiz de Fora (UFJF), Brazil  
  Email: ricardo.henriques@ufjf.br

- **João A. Passos Filho** (Senior Member, IEEE) - Federal University of Juiz de Fora (UFJF), Brazil  
  Email: joao.passos@ufjf.br
