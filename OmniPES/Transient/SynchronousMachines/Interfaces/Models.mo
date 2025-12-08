within OmniPES.Transient.SynchronousMachines.Interfaces;

type Models = enumeration(Classic " - Fixed Transient voltage behind transient reactance", 
                          E1q " - IEEE (1,0) - Excitation field dynamics, no damping windings", 
                          E1qd " - IEEE (1,1) - Excitation field dynamics, one damping winding aligned with q axis", 
                          Hydro " - IEEE (2,1) - Excitation field dynamics, one damping winding aligned with each d and q axis", 
                          Turbo " - IEEE (2,2) - Excitation field dynamics, one damping winding aligned with d-axis and two aligned with q-axis") annotation(
  Documentation(info="<html><body>TODO</body></html>"));