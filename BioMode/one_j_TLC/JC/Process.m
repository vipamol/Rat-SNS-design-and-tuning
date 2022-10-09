clear all
clc

%% Joint compare 1 HZ
% load('Joint.mat')
% 
% N = importdata('angle.txt');
% data = N.data;
% theta = data(:,2);
% [~,ind1] = findpeaks(-theta);
% 
% A_H = Joint(:,3);
% S_H = theta(ind1(2):ind1(3)-1);
% 
% A_H = interp1(linspace(0,1,588),A_H,linspace(0,1,100));
% S_H = interp1(linspace(0,1,20000),S_H,linspace(0,1,100));
% 
% plot(A_H,'r','linewidth',2);
% hold on;
% plot(S_H,'b','linewidth',2);
% set(gca,'XTick',0:50:100);
% ax = gca;
% ax.FontSize = 13;
% ylim([-1 0.5])
% title ('Hip','FontSize',14)
% ylabel('Angle (radians)');
% xlabel('stance                                                  swing')
% plot([46 46],[-1 0.5],'k--')
% legend('Animal data','Simulated data')

%% Joint compare 2 HZ
load('Joint.mat')

N = importdata('D2-angle.txt');
data = N.data;
D_theta = data(:,2);
[~,ind1] = findpeaks(-D_theta);

N = importdata('G2-angle.txt');
data = N.data;
G_theta = data(:,2);
[~,ind2] = findpeaks(-G_theta);

A_H = Joint(:,3);
D_H = D_theta(ind1(2):ind1(3)-1);
S_H = G_theta(ind2(2):ind2(3)-1);

A_H = interp1(linspace(0,1,588),A_H,linspace(0,1,100));
D_H = interp1(linspace(0,1,10000),D_H,linspace(0,1,100));
S_H = interp1(linspace(0,1,10000),S_H,linspace(0,1,100));

% plot(A_H,'r','linewidth',2);
plot(D_H,'-','linewidth',1.5);
hold on;
plot(S_H,'-','linewidth',1.5);
set(gca,'XTick',0:50:100);
ax = gca;
ax.FontSize = 13;
title ('Hip','FontSize',14)
ylabel('Angle (radians)');
xlabel('stance                                                  swing')
plot([46 46],[-1 0.5],'k--')
legend('Simulated data (increase D)','Simulated data (increase G_w)')