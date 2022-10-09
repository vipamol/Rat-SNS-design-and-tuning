clear all
clc

Gw = 0;
D = 0;
Gsyn = 1.689505004882813;

dt = 1; 
t_max = 20e3;

ext_stim = zeros(t_max/dt,4);

d_f = 1; %<---- desired frequency

f = @(x)f_RG (x,Gw,Gsyn,ext_stim,t_max,dt)-d_f;
P_val = bisect(f,1.6,1.7,1e-12,1e-12,1000);

P_val
% f_RG (D,Gw,Gsyn,ext_stim,t_max,dt)
%% Frequency and parameters
% f = 1 Hz
% D = 0      Gw = 0.573609924316406
% Gw = 0     D = 5.861865234374999 
% Gw = 0.1   D = 4.239929199218750
% Gw = 0.3   D = 1.982446289062500

% D = 0  Gsyn = 1.617812500000000
% D = 2  Gsyn = 1.773198242187500
% D = 6  Gsyn = 2.007319335937500

% D = 0 Gw = 0.1 Gsyn = 1.689505004882813
% D = 0 Gw = 0.01 Gsyn = 1.62509765625
% D = 1 Gw = 0.01 Gsyn = 1.7077875

% f = 1.6 Hz
% Gsyn = 1.62509765625  Gw = 0.01  D = 0.8;
% Gsyn = 1.62509765625  D = 0      Gw = 0.1140625

% f = 2 Hz
%Gsyn = 1.62509765625  Gw = 0.01  D = 1.6628;
% Gsyn = 1.62509765625 D = 0 Gw = 0.237625
