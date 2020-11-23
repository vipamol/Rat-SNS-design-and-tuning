clear all
clc

%% Initializing the time frame
dt = 1;
time = 5e3;
tic;

%% Constructing the RG layer
RG_ext_stim = zeros(time/dt,4);
[RG_EXT,RG_FLX] = rhythm_generator(RG_ext_stim,time,dt);

%% Constructing the 3 PF layer
% for Hip joint
H_Gc = 1;
Hip_ext_stim = zeros(time/dt,4);
[Hip_EXT,Hip_FLX] = pattern_formation(RG_EXT,RG_FLX,H_Gc,Hip_ext_stim,time,dt);

% for knee joint
K_Gc = 0.5;
Knee_ext_stim = zeros(time/dt,4);
% Knee_ext_stim(1000:1500,1)=4;
[Knee_EXT,Knee_FLX] = pattern_formation(RG_EXT,RG_FLX,K_Gc,Knee_ext_stim,time,dt);

% for Ankle joint
A_Gc = 0.1;
Ankle_ext_stim = zeros(time/dt,4);
% Ankle_ext_stim(2000:3500,1)=-8;
% Ankle_ext_stim(2000:3500,2)=-8;
[Ankle_EXT,Ankle_FLX] = pattern_formation(RG_EXT,RG_FLX,A_Gc,Ankle_ext_stim,time,dt);

%% Plot section

figure(1)
clf
subplot(4,1,1)
plot(RG_EXT(1,:),'r','Linewidth',2)
hold on 
plot(RG_FLX(1,:),'b','Linewidth',2)
hold off
grid on
ylabel('voltage (mV)')
title('RG Voltage')

subplot(4,1,2)
plot(Hip_EXT(1,:),'r','Linewidth',2)
hold on 
plot(Hip_FLX(1,:),'b','Linewidth',2)
hold off
grid on
ylabel('voltage (mV)')
title('Hip PF Voltage')

subplot(4,1,3)
plot(Knee_EXT(1,:),'r','Linewidth',2)
hold on 
plot(Knee_FLX(1,:),'b','Linewidth',2)
hold off
grid on
ylabel('voltage (mV)')
title('Knee PF Voltage')

subplot(4,1,4)
plot(Ankle_EXT(1,:),'r','Linewidth',2)
hold on 
plot(Ankle_FLX(1,:),'b','Linewidth',2)
hold off
grid on
xlabel('time (ms)')
ylabel('voltage (mV)')
title('Ankle PF Voltage')
set(gcf,'Position',[500 100 900 700])


%% Test field
% % -------------------------------------------------------------------------%
% Gc = 0.01:0.01:4;
% ext_stim = zeros(time/dt,4);
% loop = length(Gc);
% T = zeros(loop,1);
% 
% parfor i = 1:loop
%     [EXT,FLX] = pattern_formation(RG_EXT,RG_FLX,Gc(i),ext_stim,time,dt);
%     T(i) = find_periods(EXT(1,:),FLX(1,:),dt);
% end
% 
% figure(1)
% clf
% plot(Gc,T,'k','Linewidth',2)
% ylabel('Oscallation period (ms)')
% xlabel('Gc (uS)')
% title('Gc VS T')

simtime = toc;
disp('simulation done.')