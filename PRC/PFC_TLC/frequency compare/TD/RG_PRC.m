clear all
clc

num_phase = 100;

load('f1.mat')
RG_f1 = RG_phase_shift;
f1 = phase_shift;

load('f1.6_Gw.mat')
RG_fmG = RG_phase_shift;
fmG = phase_shift;

load('f1.6_D.mat')
RG_fmD = RG_phase_shift;
fmD = phase_shift;

%% f = 1.6
figure (1)
plot((0:num_phase-1)/num_phase,RG_f1(1,:),'k','LineWidth',1)
hold on
plot((0:num_phase-1)/num_phase,f1(1,:),'k--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmG(1,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,RG_fmD(1,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,fmG(1,:),'--','LineWidth',1)
plot((0:num_phase-1)/num_phase,fmD(1,:),'--','LineWidth',1)

% grid on
ax = gca;
ax.FontSize = 12; 

ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus','Fontsize',14)
ylabel('normalized phase advancement','Fontsize',14)
title('Phase response curve of the system','Fontsize',14)
 
col = [0.8500, 0.3250, 0.0980;0, 0.4470, 0.7410];
colororder(col)

set(gcf,'Position',[500 200 600 400])
legend('RG  @ 1 Hz','PF   @ 1 Hz','RG  @ 1.6 Hz by raising G_w','RG  @ 1.6 Hz by adding D','PF   @ 1.6 Hz by rasing G_w','PF   @ 1.6 Hz by adding D')

figure (2)
hold on
plot((0:num_phase-1)/num_phase,RG_f1(2,:),'k','LineWidth',1)
plot((0:num_phase-1)/num_phase,f1(2,:),'k--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmG(2,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmD(2,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fmG(2,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fmD(2,:),'--','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus','Fontsize',12)
ylabel('normalized phase advancement','Fontsize',14)
title('Phase response curve of the system, perturbed by excitatory I_s','Fontsize',13)
 
col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])
% legend('RG  @ 1 Hz','PF   @ 1 Hz','RG  @ 1.6 Hz by increase G_w','RG  @ 1.6 Hz by increase D','PF   @ 1.6 Hz by increase G_w','PF   @ 1.6 Hz by increase D')
