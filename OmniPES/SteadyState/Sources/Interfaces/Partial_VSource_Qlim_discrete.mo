within OmniPES.SteadyState.Sources.Interfaces;

partial model Partial_VSource_Qlim_discrete
  extends Interfaces.Partial_VSource_Qlim;
  Real x(min=-0.5, max=0.5);
  Boolean s_normal;
  Boolean s_qmax;
  Boolean s_qmin;
  protected
  Boolean smax(start=false);
  Boolean smin(start=false);
  Boolean bmax(start=false);
  Boolean bmin(start=false);
  Boolean ns_normal(start=true);
  Boolean ns_qmax(start=false);
  Boolean ns_qmin(start=false);
equation
  x = Vsp + dvsp - V;
  if s_normal then
    x = 0;
  else 
    if s_qmax then 
      S.im = Qmax/data.Sbase; 
    else 
      S.im = Qmin/data.Sbase;
    end if;
  end if;

algorithm
  smax := S.im > Qmax/data.Sbase;
  smin := S.im < Qmin/data.Sbase;
  bmin := x > 0;
  bmax := x < 0;
  
  if initial() then
    if ((not smax) and (not smin)) then
      s_normal := true;
      s_qmax := false;
      s_qmin := false;
    elseif smax then
      s_normal := false;
      s_qmax := true;
      s_qmin := false;
    else 
      s_normal := false;
      s_qmax := false;
      s_qmin := true;
    end if;
  else
    s_normal := pre(ns_normal);
    s_qmax := pre(ns_qmax);
    s_qmin := pre(ns_qmin);        
  end if;

  ns_normal := ((not smax) and (not smin) and (s_normal)) or (bmax and (s_qmax)) or (bmin and (s_qmin));
  ns_qmax := ((smax) and (not smin) and (s_normal)) or ((not bmax) and (s_qmax));
  ns_qmin := ((smin) and (not smax) and (s_normal)) or ((not bmin) and (s_qmin));

end Partial_VSource_Qlim_discrete;