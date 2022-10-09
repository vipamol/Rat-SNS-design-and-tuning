clear all
clc

%% For inhibition
load ('D0-.mat')
N = phase_shift;
load ('D2-.mat')
D2 = phase_shift;
load ('D6-.mat')
D6 = phase_shift;

num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6,'--','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gca,'YMinorGrid','on');
set(gcf,'Position',[500 200 500 300])
xlabel('\phi, normalized phase of stimulus','FontSize',12)
% ylabel('normalized phase advancement','FontSize',13)

legend('D = 0    G_w = 0','D = 2    G_w = 0','D = 6    G_w = 0')
% legend('D = 0    G_s_y_n = 1.6178','D = 2    G_s_y_n = 1.7732','D = 6    G_s_y_n = 2.0073')

%% For excitation
load ('D0+.mat')
N = phase_shift;
load ('D2+.mat')
D2 = phase_shift;
load ('D6+.mat')
D6 = phase_shift;

num_phase = 100;
 
figure(2)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6,'--','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gca,'YMinorGrid','on');
set(gcf,'Position',[500 200 500 300])
xlabel('\phi, normalized phase of stimulus','FontSize',12)
% ylabel('normalized phase advancement','FontSize',13)

legend('D = 0    G_w = 0','D = 2    G_w = 0','D = 6    G_w = 0')
% legend('D = 0    G_s_y_n = 1.6178','D = 2    G_s_y_n = 1.7732','D = 6    G_s_y_n = 2.0073')

%% For Gw inhibition
load ('D0-.mat')
N = phase_shift;

load ('Gwm-.mat')
M = phase_shift;

load ('Gw-.mat')
G = phase_shift;

figure(3)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,M,'-.','LineWidth',2)
plot((0:num_phase-1)/num_phase,G,'-.','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gca,'YMinorGrid','on');
set(gcf,'Position',[500 200 500 300])
xlabel('\phi, normalized phase of stimulus')
% ylabel('normalized phase advancement')

legend('D = 0    G_w = 0','D = 0    G_w = 0.1','D = 0    G_w = 0.5736')
% legend('Gw = 0             G_s_y_n = 1.6178','Gw = 0.1          G_s_y_n = 1.6895','Gw = 0.5736    G_s_y_n = 2')

%% For Gw excitation
load ('D0+.mat')
N = phase_shift;

load ('Gwm+.mat')
M = phase_shift;

load ('Gw+.mat')
G = phase_shift;

figure(4)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,M,'-.','LineWidth',2)
plot((0:num_phase-1)/num_phase,G,'-.','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gca,'YMinorGrid','on');
set(gcf,'Position',[500 200 500 300])
xlabel('\phi, normalized phase of stimulus')
% ylabel('normalized phase advancement')

legend('D = 0    G_w = 0','D = 0    G_w = 0.1','D = 0    G_w = 0.5736')
% legend('Gw = 0             G_s_y_n = 1.6178','Gw = 0.1          G_s_y_n = 1.6895','Gw = 0.5736    G_s_y_n = 2')