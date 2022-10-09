close all
clear all
clc

%% Plots
num_phase = 100;

% load('Gc_0.01_RG-.mat')
% N_RG = RG_phase_shift - phase_shift;
% % N_RG(2,:) = [];

load('Gc_0.1_RG-.mat')
S_RG = RG_phase_shift - phase_shift;
S_RG(2,:) = [];

% load('Gc_1_RG.mat')
% L_RG = RG_phase_shift - phase_shift;

% plot((0:num_phase-1)/num_phase,N_RG,'-.','LineWidth',1.5)
hold on
plot((0:num_phase-1)/num_phase,S_RG,'--','LineWidth',1.5)
% plot((0:num_phase-1)/num_phase,L_RG(1,:),'k','LineWidth',1)
% grid on

ax = gca;
ax.FontSize = 12; 

ylim([-0.25 0.25])
% xlabel('\phi, normalized phase of stimulus','Fontsize',14)
% ylabel('normalized phase advancement','Fontsize',14)
% title('Phase shifts between the two layers','Fontsize',14)
% 
% col = [0.4940, 0.1840, 0.5560;0.4660, 0.6740, 0.1880;0.6350, 0.0780, 0.1840];
% colororder(col)
% 
% set(gcf,'Position',[500 200 600 400])
% legend('G_c = 0.01   I_s = 0.05','G_c = 0.01   I_s = 0.5','G_c = 0.1     I_s = 0.5')

%% Bar

load('Gc_0.01_RG-.mat')
N_RG = RG_phase_shift - phase_shift;

load('Gc_0.1_RG-.mat')
S_RG = RG_phase_shift - phase_shift;

Bar1 = [min(S_RG(2,:)),max(S_RG(2,:))]*100;
Bar2 = [min(N_RG(1,:)),max(N_RG(1,:))]*100;
Bar3 = [min(N_RG(2,:)),max(N_RG(2,:))]*100;

load('Gc_0.01_PF-.mat')
N_PF = RG_phase_shift - phase_shift;

load('Gc_0.1_PF-.mat')
S_PF = RG_phase_shift - phase_shift;

Bar4 = [min(S_PF(2,:)),max(S_PF(2,:))]*100;
Bar5 = [min(N_PF(1,:)),max(N_PF(1,:))]*100;
Bar6 = [min(N_PF(2,:)),max(N_PF(2,:))]*100;

x = categorical({'G_c is week', 'G_c and I_s week', 'G_c is strong'});
Bar =  [Bar3;Bar1;Bar2]/100;
b = bar(Bar,'stacked','BarWidth',0.35, 'ShowBaseLine', 'off');

set(gca,'xticklabel',{'G_c is weak','G_c is strong', '   G_c and I_s both weak'})

% groupLabels = categorical({'G_c = 0.01 I_s = 0.05', 'G_c = 0.01 I_s = 0.5','G_c = 0.1 I_s = 0.5'});
% Bar(:,:,1) = [Bar2;Bar3;Bar1]; Bar(:,:,2) = [Bar5;Bar6;Bar4]; 
% plotBarStackGroups(Bar, groupLabels)



ylabel('Phase shift between two layers')
title(' Max Phase shifts between the layers')

set(gcf,'Position',[500 200 600 400])

ax = gca;
ax.FontSize = 14;


% set(gca,'xticklabel',{'G_c is week','G_c is strong', 'G_c and I_s both week'},'fontsize',12)