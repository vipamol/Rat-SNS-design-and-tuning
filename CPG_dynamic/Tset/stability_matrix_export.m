function f_Jacobian  = stability_matrix_export( neur_props, syn_props )
%stability_matrix_export Summary of this function goes here
%   Detailed explanation goes here
    
    C = neur_props(:,1); %5e-9;
    G_mem = neur_props(:,2); %1e6;
    Gca = neur_props(:,3); %5e-6;
    Eca = neur_props(:,4); %.2;
    Er = neur_props(:,5); %-.060;
    Sm = neur_props(:,7); %.1e3;
    EmidM = neur_props(:,8); %-.030;
    Th = neur_props(:,9); %.25;
    Sh = neur_props(:,10); %-.1e3;
    EmidH = neur_props(:,11); %-.090;
    I_stim = neur_props(:,13);
    
    size(neur_props,1)
    if size(neur_props,1) <= 4
        syn_props(5:6,:) = zeros(2,4);
    end
    
    G_syn = syn_props(:,1);
    E_syn = syn_props(:,2);
    E_lo = syn_props(:,3);
    E_hi = syn_props(:,4);
    
    syms V1 h1 V2 h2 I1 I2 I3 I4 V5
    
    G_syn_2_to_4 = symfun( G_syn(2).*(heaviside( V2 - E_lo(2) ).*heaviside( E_hi(2) - V2).*(V2 - E_lo(2))./(E_hi(2) - E_lo(2)) + heaviside(V2 - E_hi(2))) , [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    V4 = symfun( (G_mem(4).*Er(4) + G_syn_2_to_4.*E_syn(2) + I_stim(4) + I4)./(G_mem(4) + G_syn_2_to_4) ,[V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    G_syn_4_to_1 = symfun( G_syn(4).*(heaviside( V4 - E_lo(4) ).*heaviside( E_hi(4) - V4).*(V4 - E_lo(4))./(E_hi(4) - E_lo(4)) + heaviside(V4 - E_hi(4))) , [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    
    G_syn_1_to_3 = symfun( G_syn(1).*(heaviside( V1 - E_lo(1) ).*heaviside( E_hi(1) - V1).*(V1 - E_lo(1))./(E_hi(1) - E_lo(1)) + heaviside(V1 - E_hi(1))) , [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    V3 = symfun( (G_mem(3).*Er(3) + G_syn_1_to_3.*E_syn(1) + I_stim(3) + I3)./(G_mem(3) + G_syn_1_to_3) ,[V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    G_syn_3_to_2 = symfun( G_syn(3).*(heaviside( V3 - E_lo(3) ).*heaviside( E_hi(3) - V3).*(V3 - E_lo(3))./(E_hi(3) - E_lo(3)) + heaviside(V3 - E_hi(3))) , [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
                
    G_syn_5_to_1 = symfun( G_syn(5).*(heaviside( V5 - E_lo(5) ).*heaviside( E_hi(5) - V5).*(V5 - E_lo(5))./(E_hi(5) - E_lo(5)) + heaviside(V5 - E_hi(5))) , [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    G_syn_5_to_2 = symfun( G_syn(6).*(heaviside( V5 - E_lo(6) ).*heaviside( E_hi(6) - V5).*(V5 - E_lo(6))./(E_hi(6) - E_lo(6)) + heaviside(V5 - E_hi(6))) , [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    
    minf1 = symfun(1/(1+exp(-Sm(1).*(V1-EmidM(1)))), [V1,h1,V2,h2,I1,I2,I3,I4,V5] );
    hinf1 = symfun(1/(1+0.5*exp(-Sh(1).*(V1-EmidH(1)))), [V1,h1,V2,h2,I1,I2,I3,I4,V5] );
    tauh1 = hinf1 * symfun(sqrt( 0.5*exp(-Sh(1).*(V1-EmidH(1)))), [V1,h1,V2,h2,I1,I2,I3,I4,V5]) * Th(1);
    
    minf2 = symfun(1/(1+exp(-Sm(2).*(V2-EmidM(2)))), [V1,h1,V2,h2,I1,I2,I3,I4,V5] );
    hinf2 = symfun(1/(1+0.5*exp(-Sh(2).*(V2-EmidH(2)))), [V1,h1,V2,h2,I1,I2,I3,I4,V5] );
    tauh2 = hinf2 * symfun(sqrt( 0.5*exp(-Sh(2).*(V2-EmidH(2)))), [V1,h1,V2,h2,I1,I2,I3,I4,V5]) * Th(2);
    
    dV1_dt = symfun( 1/C(1)*(G_mem(1)*(Er(1) - V1) + G_syn_4_to_1*(E_syn(4) - V1) + G_syn_5_to_1*(E_syn(5) - V1) + Gca(1)*minf1*h1*(Eca(1) - V1) + I_stim(1) + I1), [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    
    dh1_dt = symfun( (hinf1 - h1)/tauh1, [V1,h1,V2,h2,I1,I2,I3,I4,V5] );
    
    dV2_dt = symfun( 1/C(2)*(G_mem(2)*(Er(2) - V2) + G_syn_3_to_2*(E_syn(3) - V2) + G_syn_5_to_2*(E_syn(6) - V2) + Gca(2)*minf2*h2*(Eca(2) - V2) + I_stim(2) + I2), [V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    
    dh2_dt = symfun( (hinf2 - h2)/tauh2, [V1,h1,V2,h2,I1,I2,I3,I4,V5] );
    
    state_vec = [dV1_dt;dh1_dt;dV2_dt;dh2_dt];
            
    J = jacobian(state_vec,[V1,h1,V2,h2,I1,I2,I3,I4,V5]);
    
    f_Jacobian = matlabFunction(J);
    
end

