clear all
clc


%%
dt = 1;
t_max = 5e3;

%% for diffrent D
Gw = 0;
D = 0:0.3:9;

Deltas = [0.05, 0.1 , 0.2];
freq = zeros(length(Deltas),length(D));
G = freq;

for i = 1:length(Deltas)
    delta = Deltas(i);
    for j = 1:length(D)
        %%% Common neuron properties
        C = 5;%nF
        Gm = 1;%uS
        Er = -60;%mV
        Gna = 1.5;%uS
        Ena = 50;%mV
        
        %%% Calcium Channel
        Tm = 2; %ms
        Sm = 0.2; % <=================================
        VmidM = -40; %mV
        Th = 350; %ms
        Sh = -0.6; % <=================================
        VmidH = -60; %mV
        
        V_noise = 0; %mV
        I_stim = D(j); %nA
        
        %%% Commmon Synapse properties
        G_syn = 2; %uS or 2.749
        V_th_low = -60; %mV
        V_th_high = -40; %mV
        
        ext_stim = zeros(t_max/dt,4);
       
        v_start_low_des = V_th_low + delta;
        
        %-------------------------------------------------------------------------%
        %%% Neuron population set up
        % Four neuron nodes represent EXT;FLX;EXT IN and FLX IN
        nprops = zeros(4,13);
        
        %Put these values into the proper form:(neuron,property index, time step).
        %Each row of nprops outlines the properties of another neuron
        nprops(1,:) = [C;Gm;Gna;Ena;Er;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
        nprops(2,:) = [C;Gm;Gna;Ena;Er;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
        nprops(3,:) = [C;Gm;0;Ena;Er;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
        nprops(4,:) = [C;Gm;0;Ena;Er;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
        
        %%% Synapse population set up
        sprops = zeros(6,4);

        %Each row of sprops outlines the properties of another neuron
        sprops(1,:) = [G_syn;-40;V_th_low;V_th_high];
        sprops(2,:) = [G_syn;-40;V_th_low;V_th_high];
        sprops(3,:) = [G_syn;-70;V_th_low;V_th_high];
        sprops(4,:) = [G_syn;-70;V_th_low;V_th_high];
        sprops(5,:) = [Gw;-40;V_th_low;V_th_high];
        sprops(6,:) = [Gw;-40;V_th_low;V_th_high];
        
        f = @(x)Gw_find_inhibited_V_ss(x,14,nprops,sprops) - v_start_low_des;
        Gw = bisect(f,0,1,1e-12,1e-12,1000);
        
        [v_start_low,v_start_high,v_start_interneuron_inh,v_start_interneuron_exc,nprops,sprops] = Gw_find_inhibited_V_ss(Gw,14,nprops,sprops);   
        G(i,j) = Gw;

        hinf = @(v)hinf_of_v(Th,Sh,VmidH,v);
        minf = @(v)minf_of_v(Sm,VmidM,v);
        
        %for nstate we have (property index, time step, neuron)
        nstate = zeros(6,t_max/dt,4);
        
        %assign the initial condition
        m_start_high = minf(v_start_high);
        [h_start_high,tauh_1] = hinf(v_start_high);
        
        m_start_low = minf(v_start_low);
        [h_start_low,tauh_2] = hinf(v_start_low);
        
        n_init(:,1,2) = [v_start_high;m_start_high;h_start_high;0;nprops(1,13);h_start_high]; %V(t),m,h,time,I_ext,h_inf,tau_h,i_ca
        n_init(:,1,1) = [v_start_low; m_start_low;h_start_low;0;nprops(2,13);h_start_low]; %V(t),m,h,time,I_ext,h_inf,tau_h,i_ca
        n_init(:,1,3) = [v_start_interneuron_exc;0;0;0;0;0]; %V(t),m,h,time,I_ext
        n_init(:,1,4) = [v_start_interneuron_inh;0;0;0;0;0];
        
        nstate(:,1,:) = n_init;
        
        %for synapse state we have (property index, time step,neuron)
        sstate = zeros(3,t_max/dt,6);
        
        %sstate is filled like nstate: (neuron,property index, time step)
        s_init(:,1,1) = [0;0;0];%V_pre, V_post, Current %1 -> 3
        s_init(:,1,2) = [0;0;0];%V_pre, V_post, Current %2 -> 4
        s_init(:,1,3) = [0;0;0];%V_pre, V_post, Current %3 -> 2
        s_init(:,1,4) = [0;0;0];%V_pre, V_post, Current %4 -> 1
        s_init(:,1,5) = [0;0;0];%V_pre, V_post, Current %1 -> 2
        s_init(:,1,6) = [0;0;0];%V_pre, V_post, Current %2 -> 1
        
        sstate(:,1,:) = s_init;
        
        conn_map = [1 3;2 4;3 2;4 1;1 2;2 1];
        
            nstate = simulate(nstate,nprops,sstate,sprops,conn_map,ext_stim,t_max,dt);
            
            freq(i,j) = fs(nstate(1,:,1),nstate(1,:,2),dt);

    end
end

% [X,Y] = meshgrid(Deltas,D);
% figure(1)
% surf(X,Y,G')
% colorbar
% xlabel('delta')
% ylabel('Drive (nA)')
% 
% figure(2)
% surf(X,Y,freq')
% 
% colorbar
% xlabel('delta  \delta ')
% ylabel('Drive \itD (nA)')
% ax = gca;
% ax.FontSize = 14; 
% ylim([0 9])

plot(D,freq(1:3,:))
set(gcf,'Position',[500 200 600 300])
xlabel('Drive \itD (nA)')
ylabel('Frequency (Hz)')
legend({'\delta = 0.05','\delta = 0.1','\delta = 0.2'})
ax = gca;
ax.FontSize = 14; 