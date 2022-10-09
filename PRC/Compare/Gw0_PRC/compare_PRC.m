clear all
clc

%% For inhibition
load ('PRC_nodrive-.mat')
N = phase_shift;
load ('PRC_D2-.mat')
D2 = phase_shift;
load ('PRC_D4-.mat')
D4 = phase_shift;
load ('PRC_D6-.mat')
D6 = phase_shift;
load ('PRC_shift-.mat')
S = phase_shift;

num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,N(2,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D4(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S(2,:),':','LineWidth',2)

grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
% legend('D = 0  G = 1.6198','D = 2  G = 1.7812','D = 4  G = 1.9116','D = 6  G = 2.0251','G = 2  D = 5.5445')
legend('D = 0  G = 1.4592','D = 2  G = 1.6761','D = 4  G = 1.8224','D = 6  G = 1.9420','G = 2  D = 7.0353')
%% For excitation
load ('PRC_nodrive+.mat')
N = phase_shift;
load ('PRC_D2+.mat')
D2 = phase_shift;
load ('PRC_D4+.mat')
D4 = phase_shift;
load ('PRC_D6+.mat')
D6 = phase_shift;
load ('PRC_shift+.mat')
S = phase_shift;

num_phase = 100;
 
figure(2)
hold on
plot((0:num_phase-1)/num_phase,N(2,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D4(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6(2,:),'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S(2,:),':','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
