function [Periods] = two_layer_CPG (D1,D2,Gc,Gw,time,dt,p)
%% Common neuron properties
C = 5; %nF
R = 1; %M ohm
Gm = 1.5; %uS
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

nstate = simulate_CPG(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt);

T_RG = find_periods(nstate(1,:,1),nstate(1,:,2),dt);
T_PF = find_periods(nstate(1,:,5),nstate(1,:,6),dt);

Periods = [T_RG,T_PF];

%% Plot section
if p ==1
    figure(1)
    clf
    subplot(2,1,1)
    plot(nstate(1,:,1),'r','Linewidth',2)
    hold on
    plot(nstate(1,:,2),'b','Linewidth',2)
    hold off
    grid on
    legend('EXT','FLX');
    ylabel('voltage (mV)')
    title('RG')
    
    subplot(2,1,2)
    plot(nstate(1,:,5),'r','Linewidth',2)
    hold on
    plot(nstate(1,:,6),'b','Linewidth',2)
    hold off
    grid on
    legend('EXT','FLX');
    xlabel('time (ms)')
    ylabel('voltage (mV)')
    title('PF')
    set(gcf,'Position',[500 200 900 600])
    
    sgtitle(['D_1 = ',num2str(D1),'       D_2 = ',num2str(D2),'     G_C = ',num2str(Gc)])
end

end