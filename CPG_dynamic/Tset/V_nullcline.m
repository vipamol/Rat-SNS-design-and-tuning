function h = V_nullcline(U,Syn_state,nprops)

%     nprops(1,:) = [C,Gmem,Gca,Eca,Vr,Tm,Sm,VmidM,Th,Sh,VmidH,V_noise,I_stim];
    G_mem = nprops(2);
    G_ca = nprops(3);
    E_ca = nprops(4);
    E_r = nprops(5);
    Sm = nprops(7);
    VmidM = nprops(8);
    I_stim = nprops(13);
    
%     keyboard

    mInf = 1./(1 + exp(-Sm*(U-VmidM)));
    
    SYN = zeros(size(U));    
    for i = 1:size(Syn_state,3)
        SYN = SYN + Syn_state(2,1,i)*(Syn_state(1,1,i)-U);
    end
    
%     SYN = Syn_state(2,1,1)*(Syn_state(1,1,1)-U)+Syn_state(2,1,2)*(Syn_state(1,1,2)-U);
    
    h = (G_mem*(E_r - U)+I_stim + SYN)./(mInf.*G_ca.*(U-E_ca));


end