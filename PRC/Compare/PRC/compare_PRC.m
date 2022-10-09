clear all
clc

%% For inhibition
load ('PRC_nodrive-.mat')
N = phase_shift;
load ('PRC_drive-.mat')
D = phase_shift;
load ('PRC_D2-.mat')
D2 = phase_shift;
load ('PRC_shift-.mat')
S = phase_shift;

load ('PRC_Gw-.mat')
G = phase_shift;

num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,N(2,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S(2,:),':','LineWidth',2)
plot((0:num_phase-1)/num_phase,G(2,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2(2,:),'--','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')

% legend('D = 0  G = 1.6198','D = 6  G = 2.0251','G = 2  D = 5.5445',' G = 2 Gw = 0.5568','D = 2  G = 1.7812')
legend('D = 0  G = 1.4592','D = 6  G = 1.9420','G = 2  D = 7.0353','G = 2 Gw = 0.7965','D = 2  G = 1.6761')

%% For excitation
load ('PRC_nodrive+.mat')
N = phase_shift;
load ('PRC_drive+.mat')
D = phase_shift;
load ('PRC_D2+.mat')
D2 = phase_shift;
load ('PRC_shift+.mat')
S = phase_shift;

load ('PRC_Gw+.mat')
G = phase_shift;

num_phase = 100;
 
figure(2)
hold on
plot((0:num_phase-1)/num_phase,N(2,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S(2,:),':','LineWidth',2)
plot((0:num_phase-1)/num_phase,G(2,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2(2,:),'--','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
