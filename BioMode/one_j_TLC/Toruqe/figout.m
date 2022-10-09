clear all
clc

%% set up perturbed 
Stim = - 0.1;
dt = 0.00005;

D = importdata('lD_angle.txt');
data = D.data;
D_theta = data(:,2);
[~,ind_D] = findpeaks(-D_theta);

G = importdata('lG_angle.txt');
data = G.data;
G_theta = data(:,2);
[~,ind_G] = findpeaks(-G_theta);

D_P = D_theta(ind_D(1):ind_D(1)+3.5/dt);
G_P = G_theta(ind_G(1):ind_G(1)+3.5/dt);

T = 0:dt:3.5;
I = zeros(length(T),1); I(10001:20001) = Stim;

%% plot
figure (1)
subplot(3,1,1:2)
hold on 
plot(T,D_P,'linewidth',2)
plot(T,G_P,'linewidth',2);

plot([0.5 0.5],[-1 1],'k--')
plot([1 1],[-1 1],'k--')
plot([1.5 1.5],[-1 1],'k--')

ax = gca;
ax.FontSize = 15; 

xticklabels([])
xlim([0 2])
ylim([-1 1])
ylabel('Joint angle  (Radians)')
legend('2 Hz D','2 Hz Gw')

subplot(3,1,3)
plot(T,I,'k','linewidth',1)

ax = gca;
ax.FontSize = 15; 

xlim([0 2])
ylim([-0.2 0.2])
text(0.65,0,'- 0.1 N m')
xlabel('Time (s)')
ylabel('Torque (N m)')

set(gcf,'Position',[500 200 800 400])

figure (2)
load ('D_H.mat')
load ('G_H.mat')

L_D = (D_P-D_H)/(max(D_H)-min(D_H));
L_G = (G_P-G_H)/(max(G_H)-min(G_H));

Bar1 = [min(L_D),max(L_D)];
Bar2 = [min(L_G),max(L_G)];
Bar =  [Bar1;Bar2];

x = categorical({'2 Hz by raising D','2 Hz by raising G_w'});
b = bar(x,Bar,'stacked','BarWidth',0.3, 'ShowBaseLine', 'off');

ax = gca;
ax.FontSize = 15; 

ylabel('Joint angle  (Radians)')
title(' Maximum joint angle offset')
set(gcf,'Position',[500 200 800 300])

%% perturb
% Stim = 0.1;
% 
% load ('D_H.mat')
% load ('G_H.mat')
% 
% D = importdata('D_angle.txt');
% data = D.data;
% D_theta = data(:,2);
% [~,ind_D] = findpeaks(-D_theta);
% 
% G = importdata('G_angle.txt');
% data = G.data;
% G_theta = data(:,2);
% [~,ind_G] = findpeaks(-G_theta);
% 
% D_P = D_theta(7865:77865);
% G_P = G_theta(3231:73231);
% 
% T = 0:dt:3.5;
% I = zeros(length(T),1); I(10001:20001) = Stim;
% 
% figure (1)
% subplot(3,1,1:2)
% hold on 
% plot(T,D_P-D_H,'linewidth',2)
% plot(T,G_P-G_H,'linewidth',2);
% 
% ax = gca;
% ax.FontSize = 15; 
% 
% xticklabels([])
% ylabel('Anlge offset (Radians)')
% legend('2 Hz D','2 Hz G_w')
% 
% % col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
% % colororder(col)
% 
% subplot(3,1,3)
% plot(T,I,'k','linewidth',1)
% ylim([-0.2 0.2])
% text(0.6,0.15,'0.1 N m')
% ylabel('Torque (N m)')
% 
% ax = gca;
% ax.FontSize = 15; 
% 
% xlabel('Time (s)')
% set(gcf,'Position',[500 200 800 400])
% title ('Hip joint','FontSize',16)