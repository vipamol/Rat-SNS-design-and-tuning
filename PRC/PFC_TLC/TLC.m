function nstate = TLC (D,DP,Gw,Gc,G_syn,G,ext_stim,time,dt)
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
V_noise = 0; %mV
I_stim = D; %nA

%%% Commmon Synapse properties
V_th_low = -60; %mV
V_th_high = -40; %mV

%-------------------------------------------------------------------------%
%%% Neuron population set up
% Four neuron nodes represent EXT;FLX;EXT IN and FLX IN
nprops = zeros(8,13);

%Put these values into the proper form:(neuron,property index, time step).
%Each row of nprops outlines the properties of another neuron
nprops(1,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
nprops(2,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;V_noise;I_stim]';
nprops(3,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(4,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';

nprops(5,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;DP]';
nprops(6,:) = [C;R;Gm;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;DP]';
nprops(7,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';
nprops(8,:) = [C;R;0;Eca;Vr;Tm;Sm;VmidM;Th;Sh;VmidH;0;0]';

%%% Synapse population set up
sprops = zeros(12,4);

%Each row of sprops outlines the properties of another neuron
sprops(1,:) = [G_syn;-40;V_th_low;V_th_high]; 
sprops(2,:) = [G_syn;-40;V_th_low;V_th_high];
sprops(3,:) = [G_syn;-70;V_th_low;V_th_high];
sprops(4,:) = [G_syn;-70;V_th_low;V_th_high]; 
sprops(5,:) = [Gw;-40;V_th_low;V_th_high]; 
sprops(6,:) = [Gw;-40;V_th_low;V_th_high]; 

sprops(7,:) = [Gc;-40;V_th_low;V_th_high];
sprops(8,:) = [Gc;-40;V_th_low;V_th_high]; %<---- RG 2 PF

% sprops(9,:) = [1.619783;-40;V_th_low;V_th_high];
% sprops(10,:) = [1.619783;-40;V_th_low;V_th_high];
% sprops(11,:) = [1.619783;-70;V_th_low;V_th_high];
% sprops(12,:) = [1.619783;-70;V_th_low;V_th_high]; %<---- PF

sprops(9,:) = [G;-40;V_th_low;V_th_high];
sprops(10,:) = [G;-40;V_th_low;V_th_high];
sprops(11,:) = [G;-70;V_th_low;V_th_high];
sprops(12,:) = [G;-70;V_th_low;V_th_high]; %<---- PF

%for nstate we have (property index, time step, neuron)
nstate = zeros(6,time/dt,8);

%% Find SS
%Find the initial equilibrium points
[v_start_low,v_start_high,v_start_interneuron_inh,v_start_interneuron_exc] = RG_find_inhibited_V_ss([],[],nprops,sprops);

hinf = @(v)hinf_of_v(Th,Sh,VmidH,v);
minf = @(v)minf_of_v(Sm,VmidM,v);

% assign the initial condition
m_start_high = minf(v_start_high);
h_start_high = hinf(v_start_high);

m_start_low = minf(v_start_low);
h_start_low = hinf(v_start_low);

n_init(:,1,2) = [v_start_high;m_start_high;h_start_high;0;nprops(1,13);h_start_high]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,1) = [v_start_low; m_start_low;h_start_low;0;nprops(2,13);h_start_low]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,3) = [v_start_interneuron_exc;0;0;0;0;0]; %V(t),m,h,time,I_ext
n_init(:,1,4) = [v_start_interneuron_inh;0;0;0;0;0];

%Find the initial equilibrium points
[start_low,start_high,start_interneuron_inh,start_interneuron_exc] = find_inhibited_V_ss([],[],nprops(5:8,:),sprops(9:12,:));

% assign the initial condition
m_high = minf(start_high);
h_high = hinf(start_high);

m_low = minf(start_low);
h_low = hinf(start_low);

n_init(:,1,6) = [start_high;m_high;h_high;0;nprops(5,13);h_high]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,5) = [start_low;m_low;h_low;0;nprops(6,13);h_low]; %V(t),m,h,time,I_ext,h_inf
n_init(:,1,7) = [start_interneuron_exc;0;0;0;0;0]; %V(t),m,h,time,I_ext
n_init(:,1,8) = [start_interneuron_inh;0;0;0;0;0];

%% Just go
% n_init(:,1,1) = [Vr+1;0;0;0;0;0]; %V(t),m,h,time,I_ext,h_inf
% n_init(:,1,2) = [Vr;0;0;0;0;0];
% n_init(:,1,3) = [Vr;0;0;0;0;0]; %V(t),m,h,time,I_ext
% n_init(:,1,4) = [Vr;0;0;0;0;0];
% 
% n_init(:,1,5) = [Vr;0;0;0;0;0]; %V(t),m,h,time,I_ext,h_inf
% n_init(:,1,6) = [Vr;0;0;0;0;0];
% n_init(:,1,7) = [Vr;0;0;0;0;0]; %V(t),m,h,time,I_ext
% n_init(:,1,8) = [Vr;0;0;0;0;0];

%% Flow
nstate(:,1,:) = n_init;

%for synapse state we have (property index, time step,neuron)
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

conn_map = [1 3;2 4;3 2;4 1;1 2;2 1;1 5;2 6;5 7;6 8;7 6;8 5];
nstate = simulate(nstate,nprops,sstate,sprops,conn_map,ext_stim,time,dt); 
% 
%     figure(1)
%     clf
%     subplot(2,1,1);
%     hold on
%     plot(nstate(1,:,1),'r','Linewidth',2)
%     plot(nstate(1,:,2),'b','Linewidth',2)
%     hold off
%     grid on
%     legend('EXT','FLX');
%     ylabel('voltage (mV)')
%     
%     subplot(2,1,2);
%     hold on
%     plot(nstate(1,:,5),'r','Linewidth',2)
%     plot(nstate(1,:,6),'b','Linewidth',2)
%     hold off
%     grid on
%     legend('EXT','FLX');
%     ylabel('voltage (mV)')
%     keyboard
end