clear all
clc

dt = 0.0005;
%% Load unperturbed motion
load ('D_N.mat')
load ('G_N.mat')

D_N = D_N (1:7001);
G_N = G_N (1:7001);

%% perturb with -0.1 Nm
load ('D_P-0.1.mat')
load ('G_P-0.1.mat')

D_P = D_P (1:7001);
G_P = G_P (1:7001);

T = 0:dt:3.5;
figure (1)
hold on 
plot(T,D_N,'linewidth',2);plot(T,D_P,'--','linewidth',2);
plot(T,G_N,'linewidth',2);plot(T,G_P,'--','linewidth',2);

xlim([0 2])
col = [0, 0.4470, 0.7410;0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980;0.8500, 0.3250, 0.0980];
colororder(col)

ax = gca;
ax.FontSize = 15; 

xlabel('Time (s)')
ylabel('Joint angle (Radians)')
set(gcf,'Position',[500 200 800 400])
title ('Hip','FontSize',16)
legend('Normal (D)','Perturbed (D)','Normal (G_w)','Perturbed (G_w)')

%% perturb with -0.1 Nm
load ('D_P-0.02.mat')
load ('G_P-0.02.mat')

D_P = D_P (1:7001);
G_P = G_P (1:7001);

T = 0:dt:3.5;
figure (2)
hold on 
plot(T,D_N,'linewidth',2);plot(T,D_P,'--','linewidth',2);
plot(T,G_N,'linewidth',2);plot(T,G_P,'--','linewidth',2);

xlim([0 2])
col = [0, 0.4470, 0.7410;0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980;0.8500, 0.3250, 0.0980];
colororder(col)

ax = gca;
ax.FontSize = 15; 

xlabel('Time (s)')
ylabel('Joint angle (Radians)')
set(gcf,'Position',[500 200 800 400])
title ('Hip','FontSize',16)
legend('Normal (D)','Perturbed (D)','Normal (G_w)','Perturbed (G_w)')

%% perturb with 0.05 Nm
% load ('D_P0.05.mat')
% load ('G_P0.05.mat')
% 
% D_P = D_P (1:7001);
% G_P = G_P (1:7001);
% 
% T = 0:dt:3.5;
% figure (2)
% hold on 
% plot(T,D_N,'r','linewidth',2);plot(T,D_P,'r--','linewidth',2);
% plot(T,G_N,'b','linewidth',2);plot(T,G_P,'b--','linewidth',2);
% 
% ax = gca;
% ax.FontSize = 15; 
% 
% xlabel('Time (s)')
% ylabel('Joint angle (Radians)')
% set(gcf,'Position',[500 200 800 400])
% title ('Hip','FontSize',16)
% legend('Normal (D)','Perturbed (D)','Normal (G_w)','Perturbed (G_w)')