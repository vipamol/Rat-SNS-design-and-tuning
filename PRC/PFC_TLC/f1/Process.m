clear all
clc

num_phase = 100;

load('Gw_0.01_RG-.mat')
N_RG = RG_phase_shift - phase_shift;
% N_RG(2,:) = [];

load('Gw_0.1_RG-.mat')
S_RG = RG_phase_shift - phase_shift;
% S_RG(1,:) = [];

load('D_1_RG-.mat')
L_RG = RG_phase_shift - phase_shift;

hold on
plot((0:num_phase-1)/num_phase,N_RG,'r-.','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,S_RG,'b--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,L_RG,'k-','LineWidth',1)
grid on
ylim([-0.25 0.25])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase shifts difference between the two layers','Fontsize',12)

% col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];%;0.4940, 0.1840, 0.5560];
% colororder(col)
set(gcf,'Position',[500 200 600 400])
