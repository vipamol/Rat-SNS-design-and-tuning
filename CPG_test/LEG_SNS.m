clear all
clc

%% Initializing the time frame
dt = 1;
time = 5e3;
tic;

%% Constructing the RG layer
RG_ext_stim = zeros(time/dt,4);
[RG_EXT,RG_FLX] = rhythm_generator(RG_ext_stim,time,dt);

%% Constructing the PF layer
H_Gc = 1;
Hip_ext_stim = zeros(time/dt,4);
[Hip_EXT,Hip_FLX] = pattern_formation(RG_EXT,RG_FLX,H_Gc,Hip_ext_stim,time,dt);

%% Constructing the MN layer
H_GE = 1; H_GF = 1;
Ia_ext_stim = zeros(time/dt,6);
[MN_EXT,MN_FLX] = motorneuon_intergral(Hip_EXT,Hip_FLX,H_GE,H_GF,Ia_ext_stim,time,dt);

%% Plot section

figure(1)
clf
subplot(3,1,1)
plot(RG_EXT(1,:),'r','Linewidth',2)
hold on 
plot(RG_FLX(1,:),'b','Linewidth',2)
hold off
grid on
ylabel('voltage (mV)')
title('RG Voltage')

subplot(3,1,2)
plot(Hip_EXT(1,:),'r','Linewidth',2)
hold on 
plot(Hip_FLX(1,:),'b','Linewidth',2)
hold off
grid on
ylabel('voltage (mV)')
title('Hip PF Voltage')

subplot(3,1,3)
plot(MN_EXT(1,:),'r','Linewidth',2)
hold on 
plot(MN_FLX(1,:),'b','Linewidth',2)
hold off
grid on
xlabel('time (ms)')
ylabel('voltage (mV)')
title('MN Voltage')
set(gcf,'Position',[500 100 900 700])