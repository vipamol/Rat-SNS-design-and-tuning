clear all
clc

Stim = - 0.02;
dt = 0.0005;

load ('D_P-0.02.mat')
load ('G_P-0.02.mat')

D_P = D_P (1:7001);
G_P = G_P (1:7001);

T = 0:dt:3.5;
I = zeros(length(T),1); I(1001:2001) = Stim;

%%
% figure (1)
% % subplot(3,1,1:2)
% hold on 
% plot(T,D_P,'linewidth',2)
% plot(T,G_P,'linewidth',2);
% 
% plot([0.5 0.5],[-1 1],'k--')
% plot([1 1],[-1 1],'k--')
% plot([1.5 1.5],[-1 1],'k--')
% 
% ax = gca;
% ax.FontSize = 16; 
% 
% % xticklabels([])
% xlim([0 2])
% ylim([-1 1])
% ylabel('Joint angle  (Radians)')
% legend('2 Hz D','2 Hz Gw')
% 
% % subplot(3,1,3)
% % plot(T,I,'k','linewidth',1)
% % 
% % ax = gca;
% % ax.FontSize = 13; 
% % 
% % xlim([0 2])
% % ylim([-0.2 0.2])
% % text(0.6,0.05,'- 0.02 N m')
% xlabel('Time (s)')
% % ylabel('Torque (N m)')
% 
% set(gcf,'Position',[500 200 800 300])

%%
% figure (2)
load ('D_N.mat')
load ('G_N.mat')

D_N = D_N (1:7001);
G_N = G_N (1:7001);

L_D = (D_P-D_N)/(max(D_N)-min(D_N));
L_G = (G_P-G_N)/(max(G_N)-min(G_N));

% Bar1 = [min(L_D),max(L_D)];
% Bar2 = [min(L_G),max(L_G)];
% Bar =  [Bar1;Bar2];
% x = categorical({'2 Hz by raising D','2 Hz by raising G_w'});
% b = bar(x,Bar,'stacked','BarWidth',0.3, 'ShowBaseLine', 'off');

Bar1 = [min(L_D(1001:2001)),max(L_D(1001:2001))];Bar2 = [min(L_D(2001:3001)),max(L_D(2001:3001))];Bar3 = [min(L_D(3001:4001)),max(L_D(3001:4001))];
Bar4 = [min(L_G(1001:2001)),max(L_G(1001:2001))];Bar5 = [min(L_G(2001:3001)),max(L_G(2001:3001))];Bar6 = [min(L_G(3001:4001)),max(L_G(3001:4001))];

groupLabels = categorical({'Applying torque', '1st stride after torque','2nd stride after torque'});
Bar(:,:,1) = [Bar1;Bar2;Bar3]; Bar(:,:,2) = [Bar4;Bar5;Bar6]; 
plotBarStackGroups(Bar, groupLabels)

ax = gca;
ax.FontSize = 16; 

ylabel('Normalized joint angle  (Radians)')
title(' Maximum joint angle offset')
set(gcf,'Position',[500 200 800 400])