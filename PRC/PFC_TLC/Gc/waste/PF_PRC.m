clear all
clc

num_phase = 100;


%% for PF-

load('Gc_0.01_PF-.mat')
RG = RG_phase_shift(1,:);
PFs = phase_shift;

load('Gc_0.1_PF-.mat')
PFm = phase_shift;

load('Gc_1_PF.mat')
PFl = phase_shift(1,:);

figure (1)
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

col = [ 0.9290, 0.6940, 0.1250;
        0.8500, 0.3250, 0.0980; 0, 0.75, 0.75;
        0, 0.4470, 0.7410;  0.6350, 0.0780, 0.1840
        0.25, 0.25, 0.25];
colororder(col)

set(gcf,'Position',[500 200 600 400])
legend('RG  PRC','PF @ I_s = - 0.05  G_c = 0.01','PF @ I_s = - 0.5    G_c = 0.01','PF @ I_s = - 0.05  G_c = 0.1','PF @ I_s = - 0.5    G_c = 0.1','PF @ I_s = - 0.5    G_c = 1')

%% for PF+

load('Gc_0.01_PF+.mat')
RG = RG_phase_shift(1,:);
PFs = phase_shift;

load('Gc_0.1_PF+.mat')
PFm = phase_shift;

load('Gc_1_PF.mat')
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

col = [ 0.9290, 0.6940, 0.1250; 
        0.8500, 0.3250, 0.0980; 0, 0.75, 0.75;
        0, 0.4470, 0.7410;  0.6350, 0.0780, 0.1840
        0.25, 0.25, 0.25];
colororder(col)

set(gcf,'Position',[500 200 600 400])
legend('RG PRC','PF @ I_s = 0.05  G_c = 0.01','PF @ I_s = 0.5    G_c = 0.01','PF @ I_s = 0.05  G_c = 0.1','PF @ I_s = 0.5    G_c = 0.1','PF @ I_s = 0.5    G_c = 1')