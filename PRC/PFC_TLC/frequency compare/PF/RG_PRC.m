clear all
clc

num_phase = 100;

load('f1.mat')
RG_f1 = RG_phase_shift;
f1 = phase_shift;

load('f1.6_Gw.mat')
RG_fmG = RG_phase_shift;
fmG = phase_shift;

load('f1.6_D.mat')
RG_fmD = RG_phase_shift;
fmD = phase_shift;

load('f2_Gw.mat')
RG_flG = RG_phase_shift;
flG = phase_shift;

load('f2_D.mat')
RG_flD = RG_phase_shift;
flD = phase_shift;

%% f = 1.6
figure (1)
hold on
plot((0:num_phase-1)/num_phase,RG_f1(1,:),'k','LineWidth',1)
plot((0:num_phase-1)/num_phase,f1(1,:),'k--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmG(1,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmD(1,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fmG(1,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fmD(1,:),'--','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase response curve of the system','Fontsize',12)
 
col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])

figure (2)
hold on
plot((0:num_phase-1)/num_phase,RG_f1(2,:),'k','LineWidth',1)
plot((0:num_phase-1)/num_phase,f1(2,:),'k--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmG(2,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_fmD(2,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fmG(2,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fmD(2,:),'--','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase response curve of the system','Fontsize',12)
 
col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])

%% f = 2
figure (3)
hold on
plot((0:num_phase-1)/num_phase,RG_f1(1,:),'k','LineWidth',1)
plot((0:num_phase-1)/num_phase,f1(1,:),'k--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_flG(1,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_flD(1,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,flG(1,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,flD(1,:),'--','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase response curve of the system','Fontsize',12)
 
col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])

figure (4)
hold on
plot((0:num_phase-1)/num_phase,RG_f1(2,:),'k','LineWidth',1)
plot((0:num_phase-1)/num_phase,f1(2,:),'k--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_flG(2,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,RG_flD(2,:),'LineWidth',1.5)
plot((0:num_phase-1)/num_phase,flG(2,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,flD(2,:),'--','LineWidth',1.5)

grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase response curve of the system','Fontsize',12)
 
col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])