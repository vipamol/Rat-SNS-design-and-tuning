function [ v_star_low, v_star_high, v_star_interneuron_inh, v_star_interneuron_exc, nprops, sprops ] = I_find_inhibited_V_ss( values, vars_to_change, nprops, sprops )
%FIND_ALL_V_SS Summary of this function goes here
%   Detailed explanation goes here

    n_inds = (vars_to_change <= 13);
    s_inds = (vars_to_change > 13);
%     s_inds_sub = s_inds - 13;

%     num_neurons = size(nprops,1);
%     num_synapses = size(sprops,1);
    
    n_start = length(n_inds(n_inds>0));
    s_start = n_start + 1;

    vars_to_change_n = vars_to_change(n_inds);
    vars_to_change_s = vars_to_change(s_inds)-13;
    
    nprops(1:2,vars_to_change_n) = repmat(values(1:n_start)',2,1);
%     nprops(1:4,vars_to_change_n) = repmat(values(1:n_start)',4,1);
%     sprops(3:4,vars_to_change_s) = repmat(values(s_start:end)',2,1);
    sprops(1:4,vars_to_change_s) = repmat(values(s_start:end)',4,1);

    bisect_tol = 1e-12;
    bisect_max_it = 1e6;
    
    g = @(v) dV_dt(v,hinf_of_v(nprops(1,9),nprops(1,10),nprops(1,11),v),0,0,nprops(1,:));
    v_star_high = bisect(g,-80,-20,bisect_tol,bisect_tol,bisect_max_it);

    G_dep = G_syn_func(v_star_high,sprops(1,:));
    E_dep = sprops(1,2);
    v_star_interneuron_exc = (nprops(3,5).*nprops(3,2) + G_dep.*E_dep)./(nprops(3,2) + G_dep);

    G_hyp = G_syn_func(v_star_interneuron_exc,sprops(3,:));
    E_hyp = sprops(3,2);
    
    G_dep_w1 = G_syn_func(v_star_high,sprops(5,:));
    E_dep_w1 = sprops(5,2);
    Gsyn = [G_hyp,G_dep_w1];
    Esyn = [E_hyp,E_dep_w1];
    
    g = @(v) dV_dt(v,hinf_of_v(nprops(2,9),nprops(2,10),nprops(2,11),v),Gsyn,Esyn,nprops(2,:));
    v_star_low = bisect(g,-80,-20,bisect_tol,bisect_tol,bisect_max_it);

    G_dep = G_syn_func(v_star_low,sprops(2,:));
    v_star_interneuron_inh = (nprops(4,5).*nprops(4,2) + G_dep.*sprops(2,2))./(nprops(4,2) + G_dep);
    
%     keyboard
end

