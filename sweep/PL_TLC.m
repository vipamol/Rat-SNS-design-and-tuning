function [FD] = PL_TLC (D1,D2,Gc,Gw,time,dt,p)
%% Common neuron properties
C = 5; %nF
R = 1; %M ohm
Gm = 5; %uS
Vr = -60; %mV
Eca = 200; %mV

%%% Calcium Channel
% m, the activation variable, is rapid, so m=m_(inf)
% h, the deactivation variable, is slow,
Tm = 2; %ms
Sm = .1; % <=================================
VmidM = -40; %mV
Th = 1000; %ms
Sh = -.1; % <=================================
VmidH = -100; %mV

%%% Commmon Synapse properties
V_r = -60; %mV
G = 2; %uS
V_eq = -70; %mV
V_th_low = -60; %mV
V_th_high = -40; %mV

%% Neuron population set up
% Eight neuron nodes represent:
% RG: EXT;FLX;EXT IN and FLX IN
% PF: EXT;FLX;EXT IN and FLX IN

nprops = zeros(8,13);

% Put these values into the proper form:(neuron,property index, time step).
% Each row of nprops outlines the properties of another neuron
nprops(1,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(2,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(3,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(4,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';

nprops(5,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(6,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(7,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(8,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';

% for neuron state we have (property index, time step, neuron)

nstate = zeros(6,time/dt,8);

%assign the initial condition
n_init(:,1,1) = [V_r+1;0;0;0;0;0]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,2) = [V_r;0;0;0;0;0];
n_init(:,1,3) = [V_r;0;0;0;0;0]; %V(t),m,h,time,I_ext
n_init(:,1,4) = [V_r;0;0;0;0;0];
n_init(:,1,5) = [V_r;0;0;0;0;0]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,6) = [V_r;0;0;0;0;0];
n_init(:,1,7) = [V_r;0;0;0;0;0]; %V(t),m,h,time,I_ext
n_init(:,1,8) = [V_r;0;0;0;0;0];

nstate(:,1,:) = n_init;

%% Synapse population set up
%%% Synapse population set up
sprops = zeros(12,4);

%Each row of sprops outlines the properties of another neuron
sprops(1,:) = [G;-40;V_th_low;V_th_high];
sprops(2,:) = [G;-40;V_th_low;V_th_high];
sprops(3,:) = [G;-70;V_th_low;V_th_high];
sprops(4,:) = [G;-70;V_th_low;V_th_high];
sprops(5,:) = [Gw;-40;V_th_low;V_th_high];
sprops(6,:) = [Gw;-40;V_th_low;V_th_high]; %<---- RG

sprops(7,:) = [Gc;-40;V_th_low;V_th_high];
sprops(8,:) = [Gc;-40;V_th_low;V_th_high]; %<---- RG 2 PF

sprops(9,:) = [G;-40;V_th_low;V_th_high];
sprops(10,:) = [G;-40;V_th_low;V_th_high];
sprops(11,:) = [G;-70;V_th_low;V_th_high];
sprops(12,:) = [G;-70;V_th_low;V_th_high]; %<---- PF


%for synapse state we have (property index, time step,Synapse)
sstate = zeros(3,time/dt,12);

%sstate is filled like nstate: (neuron,property index, time step)
s_init(:,1,1) = [0;0;0];%V_pre, V_post, Current %1 -> 3
s_init(:,1,2) = [0;0;0];%V_pre, V_post, Current %2 -> 4
s_init(:,1,3) = [0;0;0];%V_pre, V_post, Current %3 -> 2
s_init(:,1,4) = [0;0;0];%V_pre, V_post, Current %4 -> 1
s_init(:,1,5) = [0;0;0];%V_pre, V_post, Current %1 -> 2
s_init(:,1,6) = [0;0;0];%V_pre, V_post, Current %2 -> 1

s_init(:,1,7) = [0;0;0];%V_pre, V_post, Current %1 -> 5
s_init(:,1,8) = [0;0;0];%V_pre, V_post, Current %2 -> 6

s_init(:,1,9) = [0;0;0];%V_pre, V_post, Current %5 -> 7
s_init(:,1,10) = [0;0;0];%V_pre, V_post, Current %6 -> 8
s_init(:,1,11) = [0;0;0];%V_pre, V_post, Current %7 -> 6
s_init(:,1,12) = [0;0;0];%V_pre, V_post, Current %8 -> 5
sstate(:,1,:) = s_init;

%% Set up connectivity

conn_map = [1 3;2 4;3 2;4 1;1 2;2 1;1 5;2 6;5 7;6 8;7 6;8 5];

ext_stim = zeros(time/dt,8);
ext_stim (:,1:2) = D1;
ext_stim (:,5:6) = D2;

% ext_stim (3000:5000,1:2) = ext_stim (3000:5000,1:2)+2;
% ext_stim (3000:5000,5:6) = ext_stim (3000:5000,5:6)+2;

[ neur_state, neur_derivatives ] = simulate_CPG(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt);
[F_RG,~] = ff(neur_state(1,:,1),neur_state(1,:,2),dt);
[F_PF,~] = ff(neur_state(1,:,5),neur_state(1,:,6),dt);

tails = round(500/1.3);
% tails_2 = round(500/F_PF);
FD = F_RG-F_PF;

U_RG_E = neur_state(1,:,1);
U_RG_F = neur_state(1,:,2);
h_RG_E = neur_state(3,:,1);
h_RG_F = neur_state(3,:,2);

U_PF_E = neur_state(1,:,5);
U_PF_F = neur_state(1,:,6);
h_PF_E = neur_state(3,:,5);
h_PF_F = neur_state(3,:,6);

%% For plot
U_Range = -65:1:-40;
hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5); %Steady-state value of h, as a function of U.

if p == 1
    h = figure;
    set(h,'Position',[500,200,400,600])
    subplot(2,1,1)
    hold on
    grid on
    plot(U_Range,hInf(U_Range),'g:','linewidth',2)
    plot(U_RG_E,h_RG_E,'r','linewidth',2)
    pRE = plot(U_RG_E(1),h_RG_E(1),'o','markersize',10,'linewidth',2);
    plot(U_RG_F,h_RG_F,'b','linewidth',2)
    pRF = plot(U_RG_F(1),h_RG_F(1),'o','markersize',10,'linewidth',2);
    title('RG')
    
    subplot(2,1,2)
    hold on
    grid on
    plot(U_Range,hInf(U_Range),'g:','linewidth',2)
    plot(U_PF_E,h_PF_E,'r','linewidth',2)
    pPE = plot(U_PF_E(1),h_PF_E(1),'o','markersize',10,'linewidth',2);
    plot(U_PF_F,h_PF_F,'b','linewidth',2)
    pPF = plot(U_PF_F(1),h_PF_F(1),'o','markersize',10,'linewidth',2);
    title('PF')
    
    pause(.5);
    for i = 2:time/dt
        pRE.XData = U_RG_E(i);
        pRE.YData = h_RG_E(i);
        
        pRF.XData = U_RG_F(i);
        pRF.YData = h_RG_F(i);
        
        pPE.XData = U_PF_E(i);
        pPE.YData = h_PF_E(i);
        
        pPF.XData = U_PF_F(i);
        pPF.YData = h_PF_F(i);
        pause(1e-3);
    end
end

if p ==2
    h = figure;
    set(h,'Position',[500,200,800,600])
    hold on
    axis square
    grid on
    
    plot(U_Range,hInf(U_Range),'g:','linewidth',2)
    pREs = plot(U_RG_E(1),h_RG_E(1),'r','linewidth',2);
    pRE = plot(U_RG_E(1),h_RG_E(1),'ro','markersize',10,'linewidth',2);
    pRFs = plot(U_RG_F(1),h_RG_F(1),'b','linewidth',2);
    pRF = plot(U_RG_F(1),h_RG_F(1),'bo','markersize',10,'linewidth',2);
    pPEs = plot(U_PF_E(1),h_PF_E(1),'m:','linewidth',2);
    pPE = plot(U_PF_E(1),h_PF_E(1),'mo','markersize',10,'linewidth',2);
    pPFs = plot(U_PF_E(1),h_PF_E(1),'k:','linewidth',2);
    pPF = plot(U_PF_F(1),h_PF_F(1),'ko','markersize',10,'linewidth',2);
    hold off
    
    pause(.5);
    for i = 2:time/dt
        pREs.XData = U_RG_E(max(1,i-tails):i);
        pREs.YData = h_RG_E(max(1,i-tails):i);
        
        pRE.XData = U_RG_E(i);
        pRE.YData = h_RG_E(i);
        
        pRFs.XData = U_RG_F(max(1,i-tails):i);
        pRFs.YData = h_RG_F(max(1,i-tails):i);
        
        pRF.XData = U_RG_F(i);
        pRF.YData = h_RG_F(i);
        
        pPEs.XData = U_PF_E(max(1,i-tails):i);
        pPEs.YData = h_PF_E(max(1,i-tails):i);
        
        pPE.XData = U_PF_E(i);
        pPE.YData = h_PF_E(i);
        
        pPFs.XData = U_PF_F(max(1,i-tails):i);
        pPFs.YData = h_PF_F(max(1,i-tails):i);
        
        pPF.XData = U_PF_F(i);
        pPF.YData = h_PF_F(i);
        pause(1e-3);
    end
end

% keyboard
end