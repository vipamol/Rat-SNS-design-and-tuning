function m = minf_of_v(S_m, V_m, v)
    
    z = exp(-S_m.*(v-V_m));
    m = 1./(1+z);

end