clear all
clc

num_phase = 100;

load('f1.mat')
RG_f1 = RG_phase_shift;
f1 = phase_shift;

load('Gw_0.01.mat')
RG_fmG = RG_phase_shift;
fmG = phase_shift;

load('D_0.01.mat')
RG_fmD = RG_phase_shift;
fmD = phase_shift;

%% f = 2 no RG PRC
% figure (1)
% hold on
% plot((0:num_phase-1)/num_phase,f1(1,:),'--','LineWidth',2.4)
% plot((0:num_phase-1)/num_phase,fmG(1,:),'--','LineWidth',2)
% plot((0:num_phase-1)/num_phase,fmD(1,:),'--','LineWidth',2)
% 
% % grid on
% ax = gca;
% ax.FontSize = 12; 
% 
% ylim([-0.5 0.5])
% xlabel('\phi, normalized phase of stimulus','Fontsize',14)
% ylabel('normalized phase advancement','Fontsize',14)
% title('Phase response curve of the system','Fontsize',14)
%  
% % col = [0.6350, 0.0780, 0.1840;0.8500, 0.3250, 0.0980;0, 0.4470, 0.7410];
% col = [0.4660, 0.6740, 0.1880;0.8500, 0.3250, 0.0980;0, 0.4470, 0.7410];
% colororder(col)
% 
% set(gcf,'Position',[500 200 600 400])
% legend('PF   @ 1 Hz','PF   @ 2 Hz by rasing G_w','PF   @ 2 Hz by adding D')

%% f = 2
figure (1)
hold on
plot((0:num_phase-1)/num_phase,RG_f1(1,:),'k','LineWidth',1.5)
% plot((0:num_phase-1)/num_phase,f1(1,:),'k--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmD(1,:),'LineWidth',2)
plot((0:num_phase-1)/num_phase,RG_fmG(1,:),'LineWidth',2)
% plot((0:num_phase-1)/num_phase,fmG(1,:),'--','LineWidth',2)
% plot((0:num_phase-1)/num_phase,fmD(1,:),'--','LineWidth',2)


ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus','Fontsize',14)
ylabel('normalized phase advancement','Fontsize',14)
title('Phase response curve of the rhythm generator','Fontsize',14)
 
% col = [0.8500, 0.3250, 0.0980;0, 0.4470, 0.7410];
% colororder(col)
% legend('1 Hz','2 Hz by direct stimulate RG neurons','2 Hz through neuromodulation')
legend('1 Hz','2 Hz driven by D','2 Hz driven by Gw')
set(gcf,'Position',[500 200 600 400])

% legend('RG  @ 1 Hz','PF   @ 1 Hz','RG  @ 2 Hz by raising G_w','RG  @ 2 Hz by adding D','PF   @ 2 Hz by rasing G_w','PF   @ 2 Hz by adding D')
ax = gca;
ax.FontSize = 16; 