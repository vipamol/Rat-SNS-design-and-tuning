clear all
clc

%% For inhibition
load ('PRC_0-.mat')
N = phase_shift;
load ('PRC_2-.mat')
D2 = phase_shift;
load ('PRC_4-.mat')
D4 = phase_shift;
% load ('PRC_shift-.mat')
% S = phase_shift;

num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,N(1,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2(1,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D4(1,:),'--','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')

legend('D = 0 Gw = 0.5568','D = 2 Gw =  0.2806','D = 4 Gw = 0.0995')
% legend('D = 0 Gw = 0.7965','D = 2 Gw =  0.4255','D = 4 Gw = 0.2061')

%% For excitation
load ('PRC_0+.mat')
N = phase_shift;
load ('PRC_2+.mat')
D2 = phase_shift;
load ('PRC_4+.mat')
D4 = phase_shift;
% load ('PRC_shift+.mat')
% S = phase_shift;

num_phase = 100;
 
figure(2)
hold on
plot((0:num_phase-1)/num_phase,N(2,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D4(2,:),'--','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
