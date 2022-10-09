function [h, tau] = hinf_of_v(T_h, S_h, V_h, v)
    
    z = exp(-S_h.*(v-V_h))*0.5;
    h = 1./(1+z);
    
    tau = h.*sqrt(z).*T_h;

end