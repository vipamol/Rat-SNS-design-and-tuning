function C_dV_dt = dV_dt( V, h, Gsyn, Esyn, nprops )
%V_SS Summary of this function goes here
%   Detailed explanation goes here
    %nprops(1,:) = [C,Gmem,Gca,Eca,Vr,Tm,Sm,VmidM,Th,Sh,VmidH,V_noise,I_stim];
    
    Gmem = nprops(2);
    Gca = nprops(3);
    Eca = nprops(4);
    Er = nprops(5);
    S_m = nprops(7);
    V_m = nprops(8);
    I_ext = nprops(13);
    
    %Compute m_inf and h_inf, which are their SS values
    z = exp(-S_m.*(V-V_m));
    m = 1./(1+z);
    
%     m = minf_of_v_silvia(S_m,V_m,100,V);
    
%     ica = Gca.*(Eca-V).*m.*h
    if length(Gsyn) == length(Esyn)
        isyn = 0;
        for i=1:length(Gsyn)
            isyn = isyn + Gsyn(i).*(Esyn(i)-V);
        end
    end
%     iext = I_ext
%     gtotal = Gmem + Gsyn + Gca.*m.*h

    C_dV_dt = Gmem.*(Er-V) + isyn + I_ext + Gca.*(Eca-V).*m.*h;
end

