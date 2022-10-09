clear all
clc

num_phase = 100;


%% for RG-

load('Gw_0.01_RG-.mat')
RGs = RG_phase_shift;
PFs = phase_shift;

load('Gw_0.1_RG-.mat')
RGm = RG_phase_shift;
PFm = phase_shift;

load('D_1_RG-.mat')
RGl = RG_phase_shift;
PFl = phase_shift;

figure (1)
hold on
plot((0:num_phase-1)/num_phase,RGs,'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RGm,'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RGl,'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,PFs,'b--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,PFm,'r--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,PFl,'k.','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase response curve of the system','Fontsize',12)

% col = [ 0.9290, 0.6940, 0.1250; 0.4660, 0.6740, 0.1880;
%         0.8500, 0.3250, 0.0980; 0, 0.75, 0.75;
%         0, 0.4470, 0.7410;  0.6350, 0.0780, 0.1840
%         0.25, 0.25, 0.25];
% colororder(col)

set(gcf,'Position',[500 200 600 400])
% legend('RG @ I_s = - 0.05','RG @ I_s = - 0.5','PF @ I_s = - 0.05  G_c = 0.01','PF @ I_s = - 0.5    G_c = 0.01','PF @ I_s = - 0.05  G_c = 0.1','PF @ I_s = - 0.5    G_c = 0.1','PF @ I_s = - 0.5    G_c = 1')

%% for RG+

load('Gw_0.01_RG+.mat')
RG = RG_phase_shift;
PFs = phase_shift;

load('Gw_0.1_RG+.mat')
PFm = phase_shift;

load('Gw_1_RG.mat')
PFl = phase_shift(2,:);

figure (2)
hold on
plot((0:num_phase-1)/num_phase,RG,'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,PFs,'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,PFm,'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,PFl,'.','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase response curve of the system','Fontsize',12)

col = [ 0.9290, 0.6940, 0.1250; 0.4660, 0.6740, 0.1880;
        0.8500, 0.3250, 0.0980; 0, 0.75, 0.75;
        0, 0.4470, 0.7410;  0.6350, 0.0780, 0.1840
        0.25, 0.25, 0.25];
colororder(col)

set(gcf,'Position',[500 200 600 400])
legend('RG @ I_s = 0.05','RG @ I_s = 0.5','PF @ I_s = 0.05  G_c = 0.01','PF @ I_s = 0.5    G_c = 0.01','PF @ I_s = 0.05  G_c = 0.1','PF @ I_s = 0.5    G_c = 0.1','PF @ I_s = 0.5    G_c = 1')