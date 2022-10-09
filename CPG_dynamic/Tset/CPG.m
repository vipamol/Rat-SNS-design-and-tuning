clear all
clc
%% Initial states
% Input explains:
% D - descending command from the brain
% Gw - the conductance of the weak excitation between RG oscillators
% time - the length of simulation time
% dt - time step
% [6.0146 0;0 0.6296][0 0.5899]

D = 0;
Gw = 0.573609924316406;
% D = 5.8619;
% Gw = 0;
time = 5e3;
dt = 1;
G = 2; %uS or 2.749

% Disturbance
ext_stim = zeros(time/dt,4);
% ext_stim (2056:2146,1) = 0.5;
% ext_stim (2000:3000,1) = 0.1;

%% CPG structure
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

% [v1,v2,v3,v4]= find_inhibited_V_ss([],[],nprops,sprops);
% [v1,v2,v3,v4] = find_all_V_ss(nprops,sprops,[]);

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

% [frequency,~] = ff(U_E,U_F,dt)
% 
% keyboard

%% Plot section 
to_plot = 1;

% Plot CPG Voltage
if to_plot == 1
    figure(1)
    clf
    plot(U_E,'r','Linewidth',2)
    hold on
    plot(U_F,'b','Linewidth',2)
    hold off
%     grid on
    % legend('EXT','FLX');
    xlim([500 5000])
    ylim([-65 -45])
    ax = gca;
    ax.FontSize = 16;
    xlabel('time (s)','Fontsize',16)
    ylabel('voltage (mV)','Fontsize',16)
    title(['D = ',num2str(round(D,2)),'     G_w = ',num2str(round(Gw,2))],'Fontsize',16)
    
    set(gcf,'Position',[500 200 600 300])
end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Plot CPG Phase Plane
if to_plot == 2
    
    h = figure (2);
    set(h,'Position',[500,200,800,600])
    ylim([0 1])
    xlabel('Voltage (mV)')
    ylabel('h')
    hold on
    grid on    
    tails = 450;
    U_Range = -70:.1:-40; 
    
    hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5);
    plot(U_Range,hInf(U_Range),'g--','linewidth',2)
    plot([-60 -60],[0 1],'k--','linewidth',1)
    
    pREs = plot(U_E(500),h_E(500),'r:','linewidth',1);
    pRE =  plot(U_E(500),h_E(500),'ro','markersize',8,'linewidth',1);
    pRFs = plot(U_F(500),h_F(500),'b:','linewidth',1);
    pRF = plot(U_F(500),h_F(500),'bo','markersize',8,'linewidth',1);
    
    pEN = plot(U_Range, V_nullcline(U_Range,E_null{500},nprops(1,:)),'r--','linewidth',2);
    pFN = plot(U_Range, V_nullcline(U_Range,F_null{500},nprops(2,:)),'b--','linewidth',2);
    
    pause(0.5);

%     for i = 501:time/dt
    for i = 1876:3672/dt
        pREs.XData = U_E(max(500,i-tails):i);
        pREs.YData = h_E(max(500,i-tails):i);
        
        pRE.XData = U_E(i);
        pRE.YData = h_E(i);
        
        pRFs.XData = U_F(max(500,i-tails):i);
        pRFs.YData = h_F(max(500,i-tails):i);
        
        pRF.XData = U_F(i);
        pRF.YData = h_F(i);
        
        pEN.YData = V_nullcline(U_Range,E_null{i},nprops(1,:));
        pFN.YData = V_nullcline(U_Range,F_null{i},nprops(1,:));
        
        pause(5e-2);
        
    end
end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Plot CPG Voltage & Phase Plane
if to_plot == 3
    
    h = figure (3);
    set(h,'Position',[500,200,800,800])
    subplot(5,1,1)
    hold on
    grid on

    tSim = 0:dt:time;
    xlim([500,max(tSim)])
    ylim([min(min(U_E,U_F))-1,max(max(U_E,U_F))+1])
    pUE = plot(tSim(500),U_E(500),'r','linewidth',2);
    pUF = plot(tSim(500),U_F(500),'b','linewidth',2);
    xlabel('time (ms)')
    ylabel('Voltage (mV)')
    
    subplot(5,1,[2,3,4,5])
    ylim([0 1])
    xlabel('Voltage (mV)')
    ylabel('h')
    hold on 
    grid on
    tails = 440;
    U_Range = -70:.1:-40; 
    
    hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5);
    plot(U_Range,hInf(U_Range),'g--','linewidth',2)
    plot([-60 -60],[0 1],'k--','linewidth',1)
    
    pREs = plot(U_E(500),h_E(500),'r:','linewidth',2);
    pRE =  plot(U_E(500),h_E(500),'ro','markersize',8,'linewidth',1);
    pRFs = plot(U_F(500),h_F(500),'b:','linewidth',2);
    pRF = plot(U_F(500),h_F(500),'bo','markersize',8,'linewidth',1);
    
    pause(0.5);

    for i = 501:time/dt
        
        pUE.XData = tSim(500:i);
        pUE.YData = U_E(500:i);
        
        pUF.XData = tSim(500:i);
        pUF.YData = U_F(500:i);
        
        pREs.XData = U_E(max(500,i-tails):i);
        pREs.YData = h_E(max(500,i-tails):i);
        
        pRE.XData = U_E(i);
        pRE.YData = h_E(i);
        
        pRFs.XData = U_F(max(500,i-tails):i);
        pRFs.YData = h_F(max(500,i-tails):i);
        
        pRF.XData = U_F(i);
        pRF.YData = h_F(i);
       
        pause(1e-3);
        
    end
end

%% Analytical section 
Ana = 0;

if Ana == 1
    h = figure (1);
%     set(h,'Position',[500,200,800,600])
    ylim([0.5 .7])
    xlabel('Voltage (mV)')
    ylabel('h')
    hold on
%     grid on    
    tails = 450;
    U_Range = -70:.1:-50; 
    
    hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5);
    plot(U_Range,hInf(U_Range),'g--','linewidth',2)
    plot([-60 -60],[0 1],'k--','linewidth',1)
    
    Dt = 1000;%[6.0146 0]
%     Dt = 3146;%[0 0.6296]
%     Dt = 3701;%[0 0.5899]
%     pRE = plot(U_E(Dt),h_E(Dt),'ro','markersize',8,'linewidth',1);
    pEN = plot(U_Range, V_nullcline(U_Range,E_null{Dt},nprops(1,:)),'r--','linewidth',2);

%     Dt = 1720;
%     pRF = plot(U_F(Dt),h_F(Dt),'bo','markersize',8,'linewidth',1);
%     pFN = plot(U_Range, V_nullcline(U_Range,F_null{Dt},nprops(2,:)),'b--','linewidth',2);
    xticks([])
    yticks([])
end


% SS = 2000;
% f_Jacobian  = stability_matrix( nprops, sprops );
% f_Jacobian  = stability_matrix_export( nprops, sprops );
% J_matrix = f_Jacobian(U_E(SS),h_E(SS),U_F(SS),h_F(SS));