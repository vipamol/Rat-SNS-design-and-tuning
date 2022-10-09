clear all
close all
clc
%% Single delta
to_simulate = false;
to_run = true;

design_low_eq_pt = true;

if to_simulate
    
    %%% Initiation
    delta = 0.01 ;
    dt = 1;
    t_max = 5e3;
    Gw = 0;
    
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
    I_stim = 0; %nA
    
    %%% Commmon Synapse properties
    G_syn = 2; %uS or 2.749
    V_th_low = -60; %mV
    V_th_high = -40; %mV
   
    ext_stim = zeros(t_max/dt,4);
    
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
    
    
    if ~design_low_eq_pt
        
        [v_start_low,v_start_high,v_start_interneuron_inh,v_start_interneuron_exc] = find_inhibited_V_ss([],[],nprops,sprops);
    else
        
        v_start_low_des = V_th_low + delta;
        
        f = @(x)find_inhibited_V_ss(x,14,nprops,sprops) - v_start_low_des;
        G_syn = bisect(f,0,10,1e-12,1e-12,1000)
        
        [v_start_low,v_start_high,v_start_interneuron_inh,v_start_interneuron_exc,nprops,sprops] = find_inhibited_V_ss(G_syn,14,nprops,sprops);
    end
    
    %Find the initial equilibrium points
    [v1,v2,v3,v4] = find_all_V_ss(nprops,sprops,[]);
    
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
    
    if to_run 
        
        nstate = simulate(nstate,nprops,sstate,sprops,conn_map,ext_stim,t_max,dt);

        figure(1)
        clf
        subplot(2,1,1);
        hold on
        plot(nstate(1,:,1),'r','Linewidth',2)
        plot(nstate(1,:,2),'b','Linewidth',2)
        hold off
        grid on
        legend('EXT','FLX');
        ylabel('voltage (mV)')
        
        subplot(2,1,2);
        hold on
        plot(nstate(1,:,3),'r','Linewidth',2)
        plot(nstate(1,:,4),'b','Linewidth',2)
        hold off
        grid on
        legend('IN EXT',' IN FLX');
        xlabel('time (ms)')
        ylabel('voltage (mV)')
        
        sgtitle(['\delta = ',num2str(delta),'     G = ',num2str(G_syn)])
        
        set(gcf,'Position',[500 200 600 300])
    end
end
%% iterating the delta
to_iterate = false;

eq_pt_distance_tol = 1e-6;

if to_iterate   
    Deltas =[-0.2:0.01:1];
    G = NaN(size(Deltas));
    F = G;
    V = [G;G];
    
    for i = 1:length(Deltas)
        %%% Initiation
        delta = Deltas(i);
        dt = 1;
        t_max = 5e3;
        Gw = 0;
        
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
        I_stim = 2; %nA
        
        %%% Commmon Synapse properties
        G_syn = 2; %uS or 2.749
        V_th_low = -60; %mV
        V_th_high = -40; %mV
        
        ext_stim = zeros(t_max/dt,4);
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
        
        v_start_low_des = V_th_low + delta;
        
        f = @(x)find_inhibited_V_ss(x,14,nprops,sprops) - v_start_low_des;
        G_syn = bisect(f,0,5,1e-12,1e-12,1000);
        [v_start_low,v_start_high,v_start_interneuron_inh,v_start_interneuron_exc,nprops,sprops] = find_inhibited_V_ss(G_syn,14,nprops,sprops);
        G(i) = G_syn;
        
        %Find the initial equilibrium points
%         [v1,v2,v3,v4] = find_all_V_ss(nprops,sprops,[]);
%         V(:,i) = [v1;v2];
        
%         if abs(v1 - v2) < eq_pt_distance_tol
%             %one eq pt
%             v1_eq = v1;
%             v2_eq = v2;
%             v3_eq = v3;
%             v4_eq = v4;
%             num_eq_pts(i) = 1;
%         else
%             %two eq pts
%             v1_eq = [v1,v2];
%             v2_eq = [v2,v1];
%             v3_eq = [v3,v4];
%             v4_eq = [v4,v3];
%             num_eq_pts(i) = 2;
%         end
%         
%         disp(['i = ',num2str(i),', there are ',num2str(num_eq_pts(i)),' equilibrium points.']);
            
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
        
        F(i) = ff(nstate(1,:,1),nstate(1,:,2),dt);
    end
    
    figure(1)
    plot(Deltas,G)
    grid on 
    xlabel('\delta, bifurcation parameter')
    ylabel('conductance (uS)')
    set(gcf,'Position',[500 200 600 300])
    
    figure(2)
    F(F==0) = NaN;
    plot(Deltas,F)
    grid on 
    xlabel('\delta, bifurcation parameter')
    ylabel('oscillation frequiency (Hz)')
    set(gcf,'Position',[500 200 600 300])
    
%     figure(3)
%     plot(Deltas,V)
%     grid on 
%     xlabel('\delta, bifurcation parameter')
%     ylabel('equilibrium voltage (mV)')
%     set(gcf,'Position',[500 200 600 300])
    
end

%% Phase response Cure
% delta = [0.01;0.1;0.3]; 
Gw = 0.573609924316406;
D = 0;
G = 2;


%%% Initiation
dt = 1;
t_max = 5e3;

phase_to_track = 2.5;
num_phase = 100;
ramp_mag = -0.5; %nA

phase_shift = zeros(length(G),num_phase);

for i = 1:length(G)
    G_syn = G(i); %uS
    
    % Get unperturbed CPG activities.
    ext_stim = zeros(t_max/dt,4);
    nstate = HC(D,Gw,G_syn,ext_stim,t_max,dt);
    [frequency,step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
    
    % set up tracking time.
    acr = step_start(1);
    sim_time = acr + round(phase_to_track*1000/frequency);
    pd = round(1000/(frequency*num_phase));
    stim_time = round(50/frequency); % 5% of oscillation period
    
    % PRC of CPG
    for j = 1:num_phase
        sim_ext_stim = zeros(sim_time/dt,4);
        sim_ext_stim(acr+pd*(j-1):acr+pd*(j-1)+stim_time,4) = ramp_mag;
        nstate = HC(D,Gw,G_syn,sim_ext_stim,sim_time,dt);
        [~,step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        
%         if ~(size(step_start_new)==3)
%             keyboard
%         end
        
        if j < (num_phase/2+1)
            phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
        else
            phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
        end
%             figure(1)
%             hold on
%             plot(nstate(1,acr:acr+round(1000/frequency),2));
%             keyboard
    end

end

figure(2)
hold on
plot((0:num_phase-1)/num_phase,phase_shift)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
% legend('\delta = 0.01','\delta = 0.1','\delta = 0.3')