clear all
clc

%% Gw = 0 delta VS G VS D

%%% Initiation
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


Deltas = 0:0.01:1;
D = 0:0.1:10;
G = NaN(length(Deltas),length(D));

for i = 1:length(Deltas)
    
    delta = Deltas(i);
    v_start_low_des = V_th_low + delta;
    
    for j = 1:length(D)
        
        nprops(1:2,13)=D(j);
        
        f = @(x)find_inhibited_V_ss(x,14,nprops,sprops) - v_start_low_des;
        G(i,j) = bisect(f,0,10,1e-12,1e-12,1000);
    end
end

G(Gw>9.99999) = NaN;

[X,Z] = meshgrid(D,Deltas);
surf(X,G,Z)
colorbar
xlabel('Drive (nA)')
zlabel('\delta, bifurcation parameter ')
ylabel('Conductance (uS)')

[Z,Y] = meshgrid(D,Deltas);
surf(G,Y,Z)
colorbar
zlabel('Drive (nA)')
ylabel('\delta, bifurcation parameter ')
xlabel('Conductance (uS)')