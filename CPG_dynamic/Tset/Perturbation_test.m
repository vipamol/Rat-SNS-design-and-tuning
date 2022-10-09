clear all
clc
%% Initial states
% Input explains:
% D - descending command from the brain
% Gw - the conductance of the weak excitation between RG oscillators
% time - the length of simulation time
% dt - time step

time = 20e3;
dt = 1;


D = 0;
Gw = 0.59;
In = 1990;

% The period T = 898;
%% Disturbance sets
to_run = 1;

if to_run == 1
    
    to_plot = 1;
    
    p = 1000; % active time of the stimulus
    
    ext_stim = zeros(time/dt,4);
    [U_E0,U_F0] = HC(D,Gw,ext_stim,time,dt);
    
    ext_stim = zeros(time/dt,4);
    ext_stim (In:In+p,1) = 0.1; % 0% of period
    [U_E1,U_F1] = HC(D,Gw,ext_stim,time,dt);
    
    ext_stim = zeros(time/dt,4);
    ext_stim (In+224:In+224+p,1) = 0.1; % 25% of period
    [U_E2,U_F2] = HC(D,Gw,ext_stim,time,dt);
    
    ext_stim = zeros(time/dt,4);
    ext_stim (In+449:In+449+p,1) = 0.1; % 50% of period
    [U_E3,U_F3] = HC(D,Gw,ext_stim,time,dt);
    
    ext_stim = zeros(time/dt,4);
    ext_stim (In+674:In+674+p,1) = 0.1; % 75% of period
    [U_E4,U_F4] = HC(D,Gw,ext_stim,time,dt);
    
    if to_plot == 1
        % Plot 2T
        set(gcf,'Position',[600,100,600,800])
        xl = In; xh = In+2*898;
        
        subplot(4,1,1)
        hold on
        grid on
        ylim([min(min(U_E1,U_F1))-1,max(max(U_E1,U_F1))+1])
        plot(U_E1(xl:xh),'r','linewidth',2);
        plot(U_F1(xl:xh),'b','linewidth',2);
        plot(U_E0(xl:xh),'r:','linewidth',2);
        plot(U_F0(xl:xh),'b:','linewidth',2);
        xticks([0 224 449 674 898 1122 1347 1572 1796])
        set(gca,'xtickLabel',[])
        title('Perturb at \phi =0 of the normalized phase','FontSize',12)
        
        subplot(4,1,2)
        hold on
        grid on
        ylim([min(min(U_E2,U_F2))-1,max(max(U_E2,U_F2))+1])
        plot(U_E2(xl:xh),'r','linewidth',2);
        plot(U_F2(xl:xh),'b','linewidth',2);
        plot(U_E0(xl:xh),'r:','linewidth',2);
        plot(U_F0(xl:xh),'b:','linewidth',2);
        xticks([0 224 449 674 898 1122 1347 1572 1796])
        set(gca,'xtickLabel',[])
        title('Perturb at \phi =0.25 of the normalized phase','FontSize',12)
        
        subplot(4,1,3)
        hold on
        grid on
        ylim([min(min(U_E3,U_F3))-1,max(max(U_E3,U_F3))+1])
        plot(U_E3(xl:xh),'r','linewidth',2);
        plot(U_F3(xl:xh),'b','linewidth',2);
        plot(U_E0(xl:xh),'r:','linewidth',2);
        plot(U_F0(xl:xh),'b:','linewidth',2);
        xticks([0 224 449 674 898 1122 1347 1572 1796])
        set(gca,'xtickLabel',[])
        title('Perturb at \phi =0.5 of the normalized phase','FontSize',12)
        
        subplot(4,1,4)
        hold on
        grid on
        ylim([min(min(U_E4,U_F4))-1,max(max(U_E4,U_F4))+1])
        plot(U_E4(xl:xh),'r','linewidth',2);
        plot(U_F4(xl:xh),'b','linewidth',2);
        plot(U_E0(xl:xh),'r:','linewidth',2);
        plot(U_F0(xl:xh),'b:','linewidth',2);
        xticks([0 224 449 674 898 1122 1347 1572 1796])
        xticklabels({'0','.25','.5','.75','1','1.25','1.5','1.75','2'})
        title('Perturb at \phi =0.75 of the normalized phase','FontSize',12)
        
    end

end
%% Disturbance set 2
% Initial

% load('U0.mat');
load('U1.mat');

to_run = 0;     to_plot = 1;

ext_stim = zeros(time/dt,4);
t = round(898*0.2); % active time of the stimulus
p = round(898*0.3); % active phase of the stimulus

ext_stim (In+p:In+p+t,1) = 0.5;    
    
if to_run == 1   
    %%% Common neuron properties
    C = 5; %nF
    R = 1; %uS ohm -->Aka GMem
    Gm = 1.5; %uS -->Aka GNa
    Vr = -60; %mV
    Eca = 50; %mV
    
    
    %%% Calcium Channel
    % m, the activation variable, is rapid, so m=m_(inf)
    % h, the deactivation variable, is slow,
    Tm = 2; %ms
    Sm = .2; % <=================================
    VmidM = -40; %mV
    Th = 350; %ms
    Sh = -.6; % <=================================
    VmidH = -60; %mV
    
    %%% noise
    V_noise = 0*.1; %mV
    V_r = -60; %mV
    I_stim = D; %nA
    
    %%% Commmon Synapse properties
    G = 2; %uS or 2.749
    V_th_low = -60; %mV
    V_th_high = -40; %mV
    
    %-------------------------------------------------------------------------%
    %%% Neuron population set up
    % Four neuron nodes represent EXT;FLX;EXT IN and FLX IN
    nprops = zeros(4,13);
    
    %Put these values into the proper form:(neuron,property index, time step).
    %Each row of nprops outlines the properties of another neuron
    nprops(1,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
    nprops(2,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
    nprops(3,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
    nprops(4,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
    
    %for neuron state we have (property index, time step, neuron)
    nstate = zeros(6,time/dt,4);
    
    %assign the initial condition
    n_init(:,1,1) = [V_r+1;0;0;0;0;0]; %V(t),m,h,time,I_ext,h_inf
    n_init(:,1,2) = [V_r;0;0;0;0;0];
    n_init(:,1,3) = [V_r;0;0;0;0;0]; %V(t),m,h,time,I_ext
    n_init(:,1,4) = [V_r;0;0;0;0;0];
    
    nstate(:,1,:) = n_init;
    
    %%% Synapse population set up
    sprops = zeros(6,4);
    
    %Each row of sprops outlines the properties of another neuron
    sprops(1,:) = [G;-40;V_th_low;V_th_high];
    sprops(2,:) = [G;-40;V_th_low;V_th_high];
    sprops(3,:) = [G;-70;V_th_low;V_th_high];
    sprops(4,:) = [G;-70;V_th_low;V_th_high];
    sprops(5,:) = [Gw;-40;V_th_low;V_th_high];
    sprops(6,:) = [Gw;-40;V_th_low;V_th_high];
    
    %for synapse state we have (property index, time step,neuron)
    sstate = zeros(3,time/dt,6);
    
    %sstate is filled like nstate: (neuron,property index, time step)
    s_init(:,1,1) = [0;0;0];%V_pre, V_post, Current %1 -> 3
    s_init(:,1,2) = [0;0;0];%V_pre, V_post, Current %2 -> 4
    s_init(:,1,3) = [0;0;0];%V_pre, V_post, Current %3 -> 2
    s_init(:,1,4) = [0;0;0];%V_pre, V_post, Current %4 -> 1
    s_init(:,1,5) = [0;0;0];%V_pre, V_post, Current %1 -> 2
    s_init(:,1,6) = [0;0;0];%V_pre, V_post, Current %2 -> 1
    
    sstate(:,1,:) = s_init;
    
    conn_map = [1 3;2 4;3 2;4 1;1 2;2 1];
%-------------------------------------------------------------------------%
    [nstate,~,V_null] = simulate(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt);
    
    EXT = nstate(:,:,1);
    FLX = nstate(:,:,2);
    
    E_null = V_null(:,1);
    F_null = V_null(:,2);
    
    U_E = EXT(1,:);
    h_E = EXT(3,:);
    U_F = FLX(1,:);
    h_F = FLX(3,:);  
end
   
if to_plot == 1
    % Plot 2T
    set(gcf,'Position',[500,100,800,800])
    subplot(5,1,1)
    hold on
    grid on
    
    xl = In; xh = In+2*898;
    ylim([min(min(U_E,U_F))-1,max(max(U_E,U_F))+1])
    plot(U_E0(xl:xh),'r:','linewidth',2);
    plot(U_F0(xl:xh),'b:','linewidth',2);
    
    tSim = 0:dt:2*898;
    pUE = plot(tSim(1),U_E(xl),'r','linewidth',2);
    pUF = plot(tSim(1),U_F(xl),'b','linewidth',2);
    
    xticks([0 224 449 674 898 1122 1347 1572 1796])
    xticklabels({'0','.25','.5','.75','1','1.25','1.5','1.75','2'})
    
    subplot(5,1,[2,3,4,5])
    xlim([min(U_E)-1,max(U_E)+1])
    ylim([max(min(h_E(xl:xh))-0.1,0),max(h_E(xl:xh))+0.1])
    xlabel('Voltage (mV)')
    ylabel('h')
    hold on 
    grid on

    U_Range = -70:.1:-40; 
    
    hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5);
    plot(U_Range,hInf(U_Range),'g--','linewidth',2)
    plot([-60 -60],[0 1],'k--','linewidth',1)
    
    pREs = plot(U_E(xl),h_E(xl),'r:','linewidth',2);
    pRE =  plot(U_E(xl),h_E(xl),'ro','markersize',8,'linewidth',1);
    pause(0.5);
    
    for i = xl+1:xh
        
        pUE.XData = tSim(1:i+1-xl);
        pUE.YData = U_E(xl:i);
        
        pUF.XData = tSim(1:i+1-xl);
        pUF.YData = U_F(xl:i);

        pREs.XData = U_E(xl:i);
        pREs.YData = h_E(xl:i);
        
        pRE.XData = U_E(i);
        pRE.YData = h_E(i);

        pause(5e-3);
       
    end
end