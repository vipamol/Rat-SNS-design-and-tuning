function [MN_EXT,MN_FLX] = motorneuon_intergral(PF_EXT,PF_FLX,GE,GF,ext_stim,time,dt)
%%% Common neuron properties
C = 5; %nF
R = 1; %M ohm
Gm = 5; %uS
Eca = 200; %mV 
Vr = -60; %mV 

%No Calcium Channel in this module
% m, the activation variable, is rapid, so m=m_(inf)
% h, the deactivation variable, is slow, 
Tm = 2; %ms
Sm = .1; % <=================================
VmidM = -40; %mV
Th = 1000; %ms
Sh = -.1; % <=================================
VmidH = -100; %mV

%%% Commmon Synapse properties
G = 2; %uS
V_eq = -70; %mV
V_th_low = -60; %mV
V_th_high = -40; %mV

%% construct network
%%% Neuron population set up
% Four neuron nodes represent EXT;FLX;EXT IN and FLX IN
nprops = zeros(8,13);
%Put these values into the proper form:(neuron,property index, time step).
%Each row of nprops outlines the properties of another neuron
nprops(1,:) = [C;R;0;Eca;Vr;0;0;0;0;0;0;0;0]';% Ia E
nprops(2,:) = [C;R;0;Eca;Vr;0;0;0;0;0;0;0;0]';% Ia F
nprops(3,:) = [C;R;0;Eca;-100;0;0;0;0;0;0;0;0]';%MN E
nprops(4,:) = [C;R;0;Eca;-100;0;0;0;0;0;0;0;0]';%MN F
nprops(5,:) = [C;R;0;Eca;Vr;0;0;0;0;0;0;0;0]';% RE E
nprops(6,:) = [C;R;0;Eca;Vr;0;0;0;0;0;0;0;0]';% RE F

% put the PF nodes into nprops
nprops(7,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]'; % PF E
nprops(8,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]'; % PF F

%for neuron state we have (property index, time step, neuron)
nstate = zeros(6,time/dt,8);

%assign the initial condition
n_init(:,1,1) = [-60;0;0;0;0;0];  %V(t),m,h,time,I_ext,h_inf
n_init(:,1,2) = [-60;0;0;0;0;0];
n_init(:,1,3) = [-100;0;0;0;0;0]; 
n_init(:,1,4) = [-100;0;0;0;0;0];
n_init(:,1,5) = [-60;0;0;0;0;0]; 
n_init(:,1,6) = [-60;0;0;0;0;0];

nstate(:,1,1:6) = n_init;

% put the RG nodes into nprops
nstate(:,:,7) = PF_EXT;
nstate(:,:,8) = PF_FLX;

%%% Synapse population set up
sprops = zeros(14,4);

%Each row of sprops outlines the properties of another neuron
sprops(1,:) = [GE;-10;V_th_low;V_th_high]; % PF->MN
sprops(2,:) = [GF;-10;V_th_low;V_th_high]; % PF->MN
sprops(3,:) = [G;-40;V_th_low;V_th_high]; % PF->Ia In
sprops(4,:) = [G;-40;V_th_low;V_th_high]; % PF->Ia In
sprops(5,:) = [G;-70;V_th_low;V_th_high]; % Ia In ~
sprops(6,:) = [G;-70;V_th_low;V_th_high]; % Ia In ~
sprops(7,:) = [G;-100;V_th_low;V_th_high]; % Ia In->MN
sprops(8,:) = [G;-100;V_th_low;V_th_high]; % Ia In->MN
sprops(9,:) = [G;-40;-100;V_th_high]; % MN->RE
sprops(10,:) = [G;-40;-100;V_th_high]; % MN->RE
sprops(11,:) = [G;-70;V_th_low;V_th_high]; % RE ~
sprops(12,:) = [G;-70;V_th_low;V_th_high]; % RE ~
sprops(13,:) = [G;-70;V_th_low;V_th_high]; % RE ->Ia IN
sprops(14,:) = [G;-70;V_th_low;V_th_high]; % RE ->Ia IN

%for synapse state we have (property index, time step,synapse)
sstate = zeros(3,time/dt,14);

s_init(:,1,1) = [0;0;0];%V_pre, V_post, Current %7 -> 3
s_init(:,1,2) = [0;0;0];%V_pre, V_post, Current %8 -> 4
s_init(:,1,3) = [0;0;0];%V_pre, V_post, Current %7 -> 1
s_init(:,1,4) = [0;0;0];%V_pre, V_post, Current %8 -> 2
s_init(:,1,5) = [0;0;0];%V_pre, V_post, Current %1 -> 2
s_init(:,1,6) = [0;0;0];%V_pre, V_post, Current %2 -> 1
s_init(:,1,7) = [0;0;0];%V_pre, V_post, Current %1 -> 4
s_init(:,1,8) = [0;0;0];%V_pre, V_post, Current %2 -> 3
s_init(:,1,9) = [0;0;0];%V_pre, V_post, Current %7 -> 5
s_init(:,1,10) = [0;0;0];%V_pre, V_post, Current %8 -> 6
s_init(:,1,11) = [0;0;0];%V_pre, V_post, Current %5 -> 6
s_init(:,1,12) = [0;0;0];%V_pre, V_post, Current %6 -> 5
s_init(:,1,13) = [0;0;0];%V_pre, V_post, Current %5 -> 1
s_init(:,1,14) = [0;0;0];%V_pre, V_post, Current %6 -> 2

sstate(:,1,:) = s_init;

conn_map = [7 3;8 4;7 1;8 2;1 2;2 1;1 4;2 3;7 5;8 6;5 6;6 5;5 1;6 2];

nstate = simulate_MN(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt); 

MN_EXT = nstate(:,:,3);
MN_FLX = nstate(:,:,4);

end