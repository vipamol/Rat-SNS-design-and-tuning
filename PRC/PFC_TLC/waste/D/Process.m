clear all
clc

num_phase = 100;

load('D_RG-.mat')
N_RG = RG_phase_shift - phase_shift;


hold on
plot((0:num_phase-1)/num_phase,N_RG(1:2,:),'-','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,N_RG(3:4,:),'--','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase shifts difference between the two layers','Fontsize',12)

col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])



% 
% RG_phase_shift(3,:) = [];
% phase_shift(3,:) = [];
% hold on
% plot((0:num_phase-1)/num_phase,RG_phase_shift,'LineWidth',1.5)
% plot((0:num_phase-1)/num_phase,phase_shift,'--','LineWidth',1.5)
% grid on
% ylim([-0.5 0.5])
% xlabel('\phi, normalized phase of stimulus')
% ylabel('normalized phase advancement')
% title('Phase response curve of the system','Fontsize',12)
% 
% col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980;0.4940, 0.1840, 0.5560];
% colororder(col)
% set(gcf,'Position',[500 200 600 300])
% % 
% plot((0:num_phase-1)/num_phase,SF_R(1:2,:),'LineWidth',1,'color',[0.3010, 0.7450, 0.9330])
% plot((0:num_phase-1)/num_phase,SF(1:2,:),'--','LineWidth',1,'color',[0.3010, 0.7450, 0.9330])

% D = 1   I_s = -0.5