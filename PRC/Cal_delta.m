clear all
clc

dt = 1;
time = 5e3;
%% Figure 3
% D = 5.8619;
% Gw = 0; % delta = 0.070655657847709

% D = 0; % delta = 0.030964844462318
% Gw = 0.573609924316406; 

% G = 2; %uS or 2.749
% ext_stim = zeros(time/dt,4);
%% group cal
load ('delta_0.1.mat') % first 20 fine
step  = length (D1);


G = 2; %uS or 2.749
ext_stim = zeros(time/dt,4);
for i = 1:step
    D = D1(1,i); Gw = D1(2,i);
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

[v_start_low,v_start_high,v_start_interneuron_inh,v_start_interneuron_exc,nprops,sprops] = Gw_find_inhibited_V_ss([], [], nprops, sprops);
delta = v_start_low-V_th_low;
DD(i) = delta;
end