clear all
clc

num_phase = 100;

load('f1.mat')
f1 = RG_phase_shift - phase_shift;

load('f1.6_Gw.mat')
fm_G = RG_phase_shift - phase_shift;

load('f1.6_D.mat')
fm_D = RG_phase_shift - phase_shift;

load('f2_Gw.mat')
fl_G = RG_phase_shift - phase_shift;

load('f2_D.mat')
fl_D = RG_phase_shift - phase_shift;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,f1(1,:),'k-','LineWidth',1)
% plot((0:num_phase-1)/num_phase,fm_G(1,:),'--','LineWidth',1.5)
% plot((0:num_phase-1)/num_phase,fm_D(1,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fl_G(1,:),'-.','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fl_D(1,:),'-.','LineWidth',1.5)
grid on
ylim([-0.25 0.25])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase shifts difference between the two layers','Fontsize',12)

col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])

figure(2)
hold on
plot((0:num_phase-1)/num_phase,f1(2,:),'k-','LineWidth',1)
plot((0:num_phase-1)/num_phase,fm_G(2,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fm_D(2,:),'--','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fl_G(2,:),'-.','LineWidth',1.5)
plot((0:num_phase-1)/num_phase,fl_D(2,:),'-.','LineWidth',1.5)
grid on
ylim([-0.25 0.25])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase shifts difference between the two layers','Fontsize',12)

col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980];
colororder(col)

set(gcf,'Position',[500 200 600 400])