clear all
clc

col = [0 0.5 0;
       0.9290, 0.6940, 0.1250
       0.4940, 0.1840, 0.5560
       0, 0.4470, 0.7410;
       0.8500, 0.3250, 0.0980];

%% For exciation
load ('RG_0.01_ex.mat')
RW = phase_shift;
RW_R = RG_phase_shift;
load ('RG_0.1_ex.mat')
RS = phase_shift;
RS_R = RG_phase_shift;

load ('PF_0.01_ex.mat')
PW = phase_shift;
PW_R = RG_phase_shift;
load ('PF_0.1_ex.mat')
PS = phase_shift;
PS_R = RG_phase_shift;

num_phase = 100;

figure(1)
subplot(2,1,1)
hold on
plot((0:num_phase-1)/num_phase,RW_R,'LineWidth',1)
plot((0:num_phase-1)/num_phase,RW,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
% legend('RG phase response','PF phase response')


subplot(2,1,2)
hold on
plot((0:num_phase-1)/num_phase,RW_R-RW,'LineWidth',1)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('phase shifts between the two layers')

colororder(col)
set(gcf,'Position',[500 200 600 500])
sgtitle('Gc = 0.01, perturb RG')

figure(2)
subplot(2,1,1)
hold on
plot((0:num_phase-1)/num_phase,RS_R,'LineWidth',1)
plot((0:num_phase-1)/num_phase,RS,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
% legend('RG phase response','PF phase response')


subplot(2,1,2)
hold on
plot((0:num_phase-1)/num_phase,RS_R-RS,'LineWidth',1)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('phase shifts between the two layers')

colororder(col)
set(gcf,'Position',[500 200 600 500])
sgtitle('Gc = 0.1, perturb RG')

figure(3)
subplot(2,1,1)
hold on
plot((0:num_phase-1)/num_phase,PW_R,'LineWidth',1)
plot((0:num_phase-1)/num_phase,PW,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
% legend('RG phase response','PF phase response')


subplot(2,1,2)
hold on
plot((0:num_phase-1)/num_phase,PW_R-PW,'LineWidth',1)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('phase shifts between the two layers')

colororder(col)
set(gcf,'Position',[500 200 600 500])
sgtitle('Gc = 0.01, perturb PF')

figure(4)
subplot(2,1,1)
hold on
plot((0:num_phase-1)/num_phase,PS_R,'LineWidth',1)
plot((0:num_phase-1)/num_phase,PS,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
% legend('RG phase response','PF phase response')


subplot(2,1,2)
hold on
plot((0:num_phase-1)/num_phase,PS_R-PS,'LineWidth',1)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('phase shifts between the two layers')

colororder(col)
set(gcf,'Position',[500 200 600 500])
sgtitle('Gc = 0.1, perturb PF')