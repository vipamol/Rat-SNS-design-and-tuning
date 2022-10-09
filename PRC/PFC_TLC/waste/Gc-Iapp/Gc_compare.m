clear all
clc

col = [0.75 0.75 0.75;
       0.25, 0.75, 0;
       0, 0.75, 0.75;
       1, 0, 0;];

load ('RG_0.1_in.mat')
F1 = phase_shift(1,:);
R1 = RG_phase_shift(1,:);

load ('RG_0.05_in.mat')
F2 = phase_shift(2,:);
R2 = RG_phase_shift(2,:);

load ('RG_0.01_in.mat')
F3 = phase_shift(4,:);
R3 = RG_phase_shift(4,:);

load ('RG_0.005_in.mat')
F4 = phase_shift(5,:);
R4 = RG_phase_shift(5,:);

num_phase = 100;
F = [F1;F2;F3;F4];
R = [R1;R2;R3;R4];

figure(1)
subplot(2,1,1)
hold on
plot((0:num_phase-1)/num_phase,R,'LineWidth',1)
plot((0:num_phase-1)/num_phase,F,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
% legend('RG phase response','PF phase response')


subplot(2,1,2)
hold on
plot((0:num_phase-1)/num_phase,R-F,'LineWidth',1)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('phase shifts between the two layers')

colororder(col)
set(gcf,'Position',[500 200 600 500])
sgtitle('I_a_p_p = - 0.5, perturb RG')

   