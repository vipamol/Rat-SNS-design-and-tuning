function [PF_EXT,PF_FLX] = pattern_formation(RG_EXT,RG_FLX,Gc,ext_stim,time,dt)
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
V_r = -60; %mV
I_stim = 4; %nA

%%% Commmon Synapse properties
G = 2; %uS
V_eq = -70; %mV
V_th_low = -60; %mV
V_th_high = -40; %mV

%% construct network
%%% Neuron population set up
% Four neuron nodes represent EXT;FLX;EXT IN and FLX IN
nprops = zeros(6,13);

%Put these values into the proper form:(neuron,property index, time step).
%Each row of nprops outlines the properties of another neuron
nprops(1,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(2,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(3,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(4,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';

% put the RG nodes into nprops
nprops(5,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
nprops(6,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';

%for neuron state we have (property index, time step, neuron)
nstate = zeros(6,time/dt,6);

%assign the initial condition
n_init(:,1,1) = [V_r;0;0;0;0;0]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,2) = [V_r;0;0;0;0;0];
n_init(:,1,3) = [V_r;0;0;0;0;0]; %V(t),m,h,time,I_ext
n_init(:,1,4) = [V_r;0;0;0;0;0];

nstate(:,1,1:4) = n_init;

% put the RG nodes into nprops
nstate(:,:,5) = RG_EXT;
nstate(:,:,6) = RG_FLX;

%%% Synapse population set up
sprops = zeros(6,4);

%Each row of sprops outlines the properties of another neuron
sprops(1,:) = [G;-40;V_th_low;V_th_high]; 
sprops(2,:) = [G;-40;V_th_low;V_th_high];
sprops(3,:) = [G;-70;V_th_low;V_th_high];
sprops(4,:) = [G;-70;V_th_low;V_th_high]; 
sprops(5,:) = [Gc;-40;V_th_low;V_th_high]; 
sprops(6,:) = [Gc;-40;V_th_low;V_th_high]; 

%for synapse state we have (property index, time step,neuron)
sstate = zeros(3,time/dt,6);

%sstate is filled like nstate: (neuron,property index, time step)
s_init(:,1,1) = [0;0;0];%V_pre, V_post, Current %1 -> 3
s_init(:,1,2) = [0;0;0];%V_pre, V_post, Current %2 -> 4
s_init(:,1,3) = [0;0;0];%V_pre, V_post, Current %3 -> 2
s_init(:,1,4) = [0;0;0];%V_pre, V_post, Current %4 -> 1
s_init(:,1,5) = [0;0;0];%V_pre, V_post, Current %5 -> 1
s_init(:,1,6) = [0;0;0];%V_pre, V_post, Current %6 -> 2

sstate(:,1,:) = s_init;

conn_map = [1 3;2 4;3 2;4 1;5 1;6 2];

nstate = simulate_CPG(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt); 

PF_EXT = nstate(:,:,1);
PF_FLX = nstate(:,:,2);
end