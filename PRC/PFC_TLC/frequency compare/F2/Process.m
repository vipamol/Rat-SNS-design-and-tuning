clear all
clc

num_phase = 100;

load('f1.mat')
f1 = RG_phase_shift - phase_shift;

load('Gw_0.01.mat')
fm_G = RG_phase_shift - phase_shift;

load('D_0.01.mat')
fm_D = RG_phase_shift - phase_shift;

%% Plots
% figure(1)
% plot((0:num_phase-1)/num_phase,f1(1,:),'k-','LineWidth',1.2)
% hold on
% plot((0:num_phase-1)/num_phase,fm_G(1,:),'--','LineWidth',2.4)
% plot((0:num_phase-1)/num_phase,fm_D(1,:),'--','LineWidth',2.4)
% 
% % grid on
% ax = gca;
% ax.FontSize = 12; 
% 
% ylim([-0.5 0.5])
% xlabel('\phi, normalized phase of stimulus','Fontsize',14)
% ylabel('normalized phase difference','Fontsize',14)
% title('Phase shifts between the two layers','Fontsize',14)
% 
% col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
% colororder(col)
% 
% set(gcf,'Position',[500 200 600 400])
% legend('1 Hz','2 Hz by raising G_w','2 Hz by adding D','Fontsize',12)

%% Bar

Bar1 = [min(f1(1,:)),max(f1(1,:))];
Bar2 = [min(fm_G),max(fm_G)];
Bar3 = [min(fm_D),max(fm_D)];


x = categorical({'1 Hz ', '2 Hz by raising G_w', '2 Hz by raising D'});
Bar =  [Bar1;Bar2;Bar3];
b = bar(x,Bar,'stacked','BarWidth',0.3, 'ShowBaseLine', 'off');


ylabel('Phase shift between two layers','Fontsize',14)
title(' Max Phase shifts between the layers','Fontsize',14)
ax = gca;
ax.FontSize = 14; 
