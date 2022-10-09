clear all
clc

%% Find Frequency
% dt = 0.00005;
% 
% N = importdata('angle.txt');
% data = N.data;
% theta = data(:,2);
% 
% 
% [~,ind] = findpeaks(-theta,'MinPeakProminence',0.1);
% 
% T = mean(diff(ind))*dt;
% f1 = 1/T

%% Joint compare 1 HZ
% load('Joint.mat')
% 
% N = importdata('angle.txt');
% data = N.data;
% theta = data(:,2);
% [~,ind1] = findpeaks(-theta,'MinPeakProminence',0.1);
% 
% A_H = Joint(:,3);
% S_H = theta(ind1(2):ind1(3)-1);
% 
% A_H = interp1(linspace(0,1,588),A_H,linspace(0,1,100));
% S_H = interp1(linspace(0,1,length(S_H)),S_H,linspace(0,1,100));
% 
% plot(A_H,'r','linewidth',2);
% hold on;
% plot(S_H,'b','linewidth',2);
% set(gca,'XTick',0:50:100);
% ax = gca;
% ax.FontSize = 13;
% title ('Hip','FontSize',14)
% ylabel('Angle (radians)');
% xlabel('stance                                                  swing')
% plot([46 46],[-1 0.4],'k--')
% legend('Animal data','Simulated data')

% %% Joint compare 2 HZ
% load('Joint.mat')
% 
% N = importdata('D_angle.txt');
% data = N.data;
% D_theta = data(:,2);
% [~,ind1] = findpeaks(-D_theta,'MinPeakProminence',0.1);
% 
% N = importdata('G_angle.txt');
% data = N.data;
% G_theta = data(:,2);
% [~,ind2] = findpeaks(-G_theta,'MinPeakProminence',0.1);
% 
% A_H = Joint(:,3);
% D_H = D_theta(ind1(2):ind1(3)-1);
% S_H = G_theta(ind2(2):ind2(3)-1);
% 
% A_H = interp1(linspace(0,1,588),A_H,linspace(0,1,100));
% D_H = interp1(linspace(0,1,length(D_H)),D_H,linspace(0,1,100));
% S_H = interp1(linspace(0,1,length(S_H)),S_H,linspace(0,1,100));
% 
% % plot(A_H,'r','linewidth',2);
% plot(D_H,'-','linewidth',1.5);
% hold on;
% plot(S_H,'-','linewidth',1.5);
% set(gca,'XTick',0:50:100);
% ax = gca;
% ax.FontSize = 13;
% title ('Hip','FontSize',14)
% ylabel('Angle (radians)');
% xlabel('stance                                                  swing')
% plot([46 46],[-1 0.5],'k--')
% legend('Simulated data (increase D)','Simulated data (increase G_w)')
%% Joint compare 2 HZ average
load('Joint.mat')

load('D_N.mat')
load('G_N.mat')

A_H = Joint(:,3);
D_H = mean(reshape(D_N,[1000,19]),2);
G_H = mean(reshape(G_N,[1000,19]),2);

A_H = interp1(linspace(0,1,588),A_H,linspace(0,1,100));
D_H = interp1(linspace(0,1,1000),D_H,linspace(0,1,100));
G_H = interp1(linspace(0,1,1000),G_H,linspace(0,1,100));

% plot(A_H,'r','linewidth',2);
plot(D_H,'-','linewidth',1.5);
hold on;
plot(G_H,'-','linewidth',1.5);
set(gca,'XTick',0:50:100);
ax = gca;
ax.FontSize = 13;
title ('Hip','FontSize',14)
ylabel('Angle (radians)');
xlabel('stance                                                  swing')
plot([46 46],[-1 0.5],'k--')
legend('Simulated data (increase D)','Simulated data (increase G_w)')