clear all
clc

G = 0:0.01:2;

load('f_PF.mat')
PF = F;
load('f_0.01.mat')
fs = F;
load('f_0.1.mat')
fm = F;
load('f_1.mat')
fl = F;

% figure (1)
% hold on 
% plot(G,PF,'LineWidth',1)
% plot(G,fs,'-.','LineWidth',1.5)
% plot(G,fm,'-.','LineWidth',1.5)
% plot(G,fl,'-.','LineWidth',1.5)
% grid on 
% 
% xlabel('Synaptic conductance G_S_y_n (uS)')
% ylabel('Frequency (Hz)')
% set(gcf,'Position',[500 200 600 400])
% 
% col = [0.25, 0.25, 0.25;0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980;0.4940, 0.1840, 0.5560];
% colororder(col)

%% perturb 
load('f_PF_P.mat')
PF_P = PF_F;

load('f_0.01_RG.mat')
fs_R = PF_F;
load('f_0.01_PF.mat')
fs_P = PF_F;

load('f_0.1_RG.mat')
fm_R = PF_F;
load('f_0.1_PF.mat')
fm_P = PF_F;

load('f_1_RG.mat')
fl_R = PF_F;
load('f_1_PF.mat')
fl_P = PF_F;

figure (2)
subplot(1,4,1)
hold on 
plot(G,PF,'k','LineWidth',1)
plot(G,PF_P,'-.','LineWidth',1)
grid on 
xlabel('Synaptic conductance  G_s_y_n (uS)')
ylabel('Frequency (Hz)')

subplot(1,4,2)
hold on 
plot(G,fs,'k','LineWidth',1)
plot(G,fs_R,'--','LineWidth',1)
plot(G,fs_P,'-.','LineWidth',1)
grid on 
xlabel('Synaptic conductance  G_s_y_n (uS)')

subplot(1,4,3)
hold on 
plot(G,fm,'k','LineWidth',1)
plot(G,fm_R,'--','LineWidth',1)
plot(G,fm_P,'-.','LineWidth',1)
grid on 
xlabel('Synaptic conductance  G_s_y_n (uS)')

subplot(1,4,4)
hold on 
plot(G,fl,'k','LineWidth',1)
plot(G,fl_R,'--','LineWidth',1)
plot(G,fl_P,'-.','LineWidth',1)
grid on 
xlabel('Synaptic conductance  G_s_y_n (uS)')

ylim([0 3])
set(gcf,'Position',[500 200 1400 250])