clear all
clc

%% The set up is for the rhythm generator;
% There is additional connevtion between EXT and FLX
%% Set up neuron and synaptic paramters 
% set up time frame, dt in 1ms.
dt = 1; 
time = 5e3;

%%% Common neuron properties
C = 5; %nF
R = 1; %M ohm
Gm = 5; %uS
Eca = 200; %mV 
Vr = -60; %mV 

%Calcium Channel
% m, the activation variable, is rapid, so m=m_(inf)
% h, the deactivation variable, is slow, 
Tm = 2; %ms
Sm = .1; % <=================================
VmidM = -40; %mV
Th = 1000; %ms
Sh = -.1; % <=================================
VmidH = -100; %mV

% noise
V_noise = 0*.1; %mV
del_t = dt;
V_r = -60; %mV
I_stim = 4; %nA

%%% Commmon Synapse properties
G = 2; %uS
Gw = 0.33;%uS <=================================week connectivity between nodes
V_eq = -70; %mV
V_th_low = -60; %mV
V_th_high = -40; %mV

%% construct network
%%% Neuron population set up
% Four neuron nodes represent EXT;FLX;EXT IN and FLX IN
nprops = zeros(4,13,round(time/dt));

%Put these values into the proper form:(neuron,property index, time step).
%Each row of nprops outlines the properties of another neuron
nprops(1,:,1) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
nprops(2,:,1) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
nprops(3,:,1) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(4,:,1) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';

%for neuron state we have (property index, time step, neuron)
nstate = zeros(6,time/dt,4);

%assign the initial condition
n_init(:,1,1) = [V_r+1;0;0;0;0;0]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,2) = [V_r;0;0;0;0;0];
n_init(:,1,3) = [V_r;0;0;0;0;0]; %V(t),m,h,time,I_ext
n_init(:,1,4) = [V_r;0;0;0;0;0];

nstate(:,1,:) = n_init;

%%% Synapse population set up
sprops = zeros(6,4,round(time/dt));

%Each row of sprops outlines the properties of another neuron
sprops(1,:,1) = [G;-40;V_th_low;V_th_high]; 
sprops(2,:,1) = [G;-40;V_th_low;V_th_high];
sprops(3,:,1) = [G;-70;V_th_low;V_th_high];
sprops(4,:,1) = [G;-70;V_th_low;V_th_high]; 
sprops(5,:,1) = [Gw;-40;V_th_low;V_th_high]; 
sprops(6,:,1) = [Gw;-40;V_th_low;V_th_high]; 

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

%% Simulate CPG
%%% Input external stimulation
ext_stim = zeros(time/dt,4);
% ext_stim(2000:2500,1)=-2;
% ext_stim(2000:2500,3)=2;


nstate = simulate(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt); 
%% Plot section

figure(1)
clf
subplot(2,1,1)
plot(nstate(1,:,1),'r','Linewidth',2)
hold on 
plot(nstate(1,:,2),'b','Linewidth',2)
hold off
grid on
legend('EXT','FLX');
xlabel('time (ms)')
ylabel('voltage (mV)')
title('RG Voltage')

subplot(2,1,2)
plot(nstate(1,:,3),'r','Linewidth',2)
hold on 
plot(nstate(1,:,4),'b','Linewidth',2)
hold off
grid on
legend('EXT IN','FLX IN');
xlabel('time (ms)')
ylabel('voltage (mV)')
title('RG IN Voltage')
set(gcf,'Position',[500 200 900 600])


%-------------------------------------------------------------------------%
% Gw = 0.01:0.01:4;
% loop = length(Gw);
% T = zeros(loop,1);
% 
% for i = 1:loop
%     sprops(5,1,1) = Gw(i);
%     sprops(6,1,1) = Gw(i);
%     nstate = simulate(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt);
%     T(i) = find_periods(nstate(1,:,1),nstate(1,:,2),dt);
% end
% 
% figure(2)
% clf
% plot(Gw,T,'k','Linewidth',2)
% ylabel('Oscallation period (ms)')
% xlabel('Gw (uS)')
% title('Gw VS T')

% find_periods(nstate(1,:,1),nstate(1,:,2),dt);
disp('simulation done.')