clear all
clc

%% For inhibition
load ('N-.mat')
N = phase_shift;
load ('D-.mat')
D = phase_shift;
load ('Gw-.mat')
Gw = phase_shift;


num_phase = 100;

figure(1)
plot((0:num_phase-1)/num_phase,D,'-','LineWidth',2)
hold on
plot((0:num_phase-1)/num_phase,Gw,'-','LineWidth',2)
% plot((0:num_phase-1)/num_phase,N,'k','LineWidth',1.5)
% grid on
ax = gca;
ax.FontSize = 14; 

ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 320])
xlabel('\phi, normalized phase of when stimulus is applied','FontSize',15)
ylabel('normalized phase advancement','FontSize',15)

legend('D = 5.86  G_w = 0','D = 0   G_w = 0.57')%,'adjusting G_h_y_p')

%% For excitation
load ('N+.mat')
N = phase_shift;
load ('D+.mat')
D = phase_shift;
load ('Gw+.mat')
Gw = phase_shift;


num_phase = 100;

figure(2)
plot((0:num_phase-1)/num_phase,D,'-','LineWidth',2)
hold on
plot((0:num_phase-1)/num_phase,Gw,'-','LineWidth',2)
% plot((0:num_phase-1)/num_phase,N,'k-','LineWidth',1.5)
% grid on
ax = gca;
ax.FontSize = 14; 

ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 320])
xlabel('\phi, normalized phase of when stimulus is applied','FontSize',15)
ylabel('normalized phase advancement','FontSize',15)

legend('D = 5.86  G_w = 0','D = 0   G_w = 0.57')%,'adjusting G_h_y_p')
% legend('D = 5.86     G_w = 0   G_h_y_p = 2','D = 0    G_w = 0.57  G_h_y_p = 2','D = 0    G_w = 0      G_h_y_p =1.62')
