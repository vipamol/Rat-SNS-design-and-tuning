clear all
clc

num_phase = 100;

%% for RG-

load('Gc_0.01_RG-.mat')
RG = RG_phase_shift(2,:);
PFs = phase_shift(2,:);

load('Gc_0.1_RG-.mat')
PFm = phase_shift(2,:);

figure (1)
hold on
plot([0 1],[0 0],'k--','LineWidth',2)

plot((0:num_phase-1)/num_phase,PFs,'--','LineWidth',2.4)
plot((0:num_phase-1)/num_phase,PFm,'--','LineWidth',2.4)

ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus','Fontsize',14)
ylabel('normalized phase advancement','Fontsize',14)
title('Phase response curve of the system','Fontsize',14)

col = [0.6350, 0.0780, 0.1840;0.4660, 0.6740, 0.1880];
colororder(col)

set(gcf,'Position',[500 200 600 400])
legend('PF when G_c = 0','PF when G_c is weak','PF when G_c is strong','Fontsize',12)

ax = gca;
ax.FontSize = 16; 

%% for PF-

load('Gc_0.01_PF-.mat')
RG = RG_phase_shift(2,:);
PFs = phase_shift(2,:);
PFss = phase_shift(1,:);

load('Gc_0.1_PF-.mat')
PFm = phase_shift(2,:);

load('Gc_0.mat')
PF = phase_shift;

figure (2)

hold on
plot((0:num_phase-1)/num_phase,PF,'k--','LineWidth',2)

plot((0:num_phase-1)/num_phase,PFs,'--','LineWidth',2.4)
plot((0:num_phase-1)/num_phase,PFm,'--','LineWidth',2.4)


% grid on

ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus','Fontsize',14)
ylabel('normalized phase advancement','Fontsize',14)
title('Phase response curve of the system','Fontsize',14)

col = [0.6350, 0.0780, 0.1840;0.4660, 0.6740, 0.1880];
colororder(col)

set(gcf,'Position',[500 200 600 400])
legend('PF when G_c = 0','PF when G_c is weak','PF when G_c is strong','Fontsize',12)

ax = gca;
ax.FontSize = 16; 

%% for RG-

% load('Gc_0.01_RG-.mat')
% RG = RG_phase_shift(2,:);
% PFs = phase_shift(2,:);
% % RGss = RG_phase_shift(1,:);
% % PFss = phase_shift(1,:);
% 
% load('Gc_0.1_RG-.mat')
% PFm = phase_shift(2,:);
% 
% figure (1)
% % plot((0:num_phase-1)/num_phase,RG,'k','LineWidth',1.2)
% hold on
% plot([0 1],[0 0],'k--','LineWidth',1.2)
% 
% plot((0:num_phase-1)/num_phase,PFs,'--','LineWidth',2.4)
% plot((0:num_phase-1)/num_phase,PFm,'--','LineWidth',2.4)
% 
% % plot((0:num_phase-1)/num_phase,RGss,'-','LineWidth',1.6)
% % plot((0:num_phase-1)/num_phase,PFss,'--','LineWidth',1.6)
% 
% 
% % grid on
% ax = gca;
% ax.FontSize = 12; 
% 
% ylim([-0.5 0.5])
% xlabel('\phi, normalized phase of stimulus','Fontsize',14)
% ylabel('normalized phase advancement','Fontsize',14)
% title('Phase response curve of the system','Fontsize',14)
% 
% col = [0.4660, 0.6740, 0.1880;0.6350, 0.0780, 0.1840];
% % col = [0.4940, 0.1840, 0.5560;0.75, 0, 0.75;0.4660, 0.6740, 0.1880;0.6350, 0.0780, 0.1840];
% colororder(col)
% 
% set(gcf,'Position',[500 200 600 400])
% legend('RG phase response','PF phase response when G_c = 0','PF phase response when G_c is weak','PF phase response when G_c is strong','Fontsize',12)
% % legend('RG @ I_s = 0.5','PF @ G_c = 0','PF @ G_c = 0.01','PF @ G_c = 0.1','RG @ I_s = 0.05','PF @ G_c = 0.01')

 %% for PF-

% load('Gc_0.01_PF-.mat')
% RG = RG_phase_shift(2,:);
% PFs = phase_shift(2,:);
% PFss = phase_shift(1,:);
% 
% load('Gc_0.1_PF-.mat')
% PFm = phase_shift(2,:);
% 
% load('Gc_0.mat')
% PF = phase_shift;
% 
% figure (2)
% plot((0:num_phase-1)/num_phase,RG,'k','LineWidth',1.2)
% hold on
% plot((0:num_phase-1)/num_phase,PF,'k--','LineWidth',1.2)
% 
% plot((0:num_phase-1)/num_phase,PFs,'--','LineWidth',2.4)
% plot((0:num_phase-1)/num_phase,PFm,'--','LineWidth',2.4)
% 
% % plot((0:num_phase-1)/num_phase,PFss,'--','LineWidth',1.6)
% 
% 
% % grid on
% ax = gca;
% ax.FontSize = 12; 
% 
% ylim([-0.5 0.5])
% xlabel('\phi, normalized phase of stimulus','Fontsize',14)
% ylabel('normalized phase advancement','Fontsize',14)
% title('Phase response curve of the system','Fontsize',14)
% 
% % col = [0.6350, 0.0780, 0.1840;0.4660, 0.6740, 0.1880];
% col = [0.4940, 0.1840, 0.5560;0.75, 0, 0.75;0.4660, 0.6740, 0.1880;0.6350, 0.0780, 0.1840];
% colororder(col)
% 
% set(gcf,'Position',[500 200 600 400])
% legend('RG phase response','PF phase response when G_c = 0','PF phase response when G_c is weak','PF phase response when G_c is strong','Fontsize',12)
% % legend('RG unperturbed','PF @ G_c = 0       I_s = 0.5','PF @ G_c = 0.01  I_s = 0.5','PF @ G_c = 0.1    I_s = 0.5','PF @ G_c = 0.01  I_s = 0.05')
