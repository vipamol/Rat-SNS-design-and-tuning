clear all
clc

dt = 0.00005;

%% increase D to 2hz

D = importdata('D_angle.txt');
data = D.data;
D_theta = data(:,2);
[~,ind_D] = findpeaks(-D_theta);

Td = mean(diff(ind_D))*dt;
% f1 = 1/Td
% D_H = D_theta(ind_D(1):ind_D(8)-1);
D_arc = data(ind_D(2),1)+0.5*0.1;
D_et = D_arc + 0.5*0.3;
%% increase G to 2hz
G = importdata('G_angle.txt');
data = G.data;
G_theta = data(:,2);
[~,ind_G] = findpeaks(-G_theta);

Tg = mean(diff(ind_G))*dt;
% f2 = 1/Tg
% G_H = G_theta(ind_G(1):ind_G(8)-1);
G_arc = data(ind_G(2),1)+ +0.5*0.1;
G_et = G_arc  + 0.5*0.3;
%% perturb
load ('D_H.mat')
load ('G_H.mat')

D_P = D_theta(7865:77865);
G_P = G_theta(3231:73231);

% figure(1)
% plot(D_H);hold on; plot(D_P,'--');

% figure(2)
% plot(G_H);hold on; plot(G_P,'--');

T = 0:dt:3.5;
figure (3)
hold on 
plot(T,D_H,'r','linewidth',1);
plot(T,D_P,'r--','linewidth',1);
plot(T,G_H,'b','linewidth',1);
plot(T,G_P,'b--','linewidth',1);

ax = gca;
ax.FontSize = 15; 

xlim([0 2])

xlabel('Time (s)')
ylabel('Joint angle (Radians)')
set(gcf,'Position',[500 200 800 400])
title ('Hip','FontSize',16)
% legend('Normal (D)','Perturbed (D)','Normal (G_w)','Perturbed (G_w)')