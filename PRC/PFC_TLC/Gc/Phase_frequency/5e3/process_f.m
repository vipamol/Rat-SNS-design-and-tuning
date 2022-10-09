clear all
clc

G = 0:0.01:2;

load('F1.mat')
PF = F;

load('F2.mat')
fs = F;

load('F3.mat')
fm = F;

load('F4.mat')
fl = F;

figure (1)
hold on 
plot(G,PF,'LineWidth',1)
plot(G,fs,'-.','LineWidth',1.5)
plot(G,fm,'-.','LineWidth',1.5)
plot(G,fl,'-.','LineWidth',1.5)
grid on 

xlabel('Synaptic conductance G_S_y_n (uS)')
ylabel('Frequency (Hz)')
set(gcf,'Position',[500 200 600 400])

col = [0.25, 0.25, 0.25;0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980;0.4940, 0.1840, 0.5560];
colororder(col)

% figure (2)
% subplot(1,4,1)
% plot(G,PF,'k','LineWidth',1)
% grid on 
% xlabel('Synaptic conductance  G_s_y_n (uS)')
% ylabel('Frequency (Hz)')
% subplot(1,4,2)
% plot(G,fs,'k','LineWidth',1)
% grid on 
% xlabel('Synaptic conductance  G_s_y_n (uS)')
% subplot(1,4,3)
% plot(G,fm,'k','LineWidth',1)
% grid on 
% xlabel('Synaptic conductance  G_s_y_n (uS)')
% subplot(1,4,4)
% plot(G,fl,'k','LineWidth',1)
% grid on 
% xlabel('Synaptic conductance  G_s_y_n (uS)')
% 
% ylim([0 3])
% set(gcf,'Position',[500 200 1400 250])