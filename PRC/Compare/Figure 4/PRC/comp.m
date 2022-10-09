clear all
clc

load ('D0.mat')
N = phase_shift;
load ('D1.5.mat')
S = phase_shift;
load ('D3.mat')
M = phase_shift;
load ('D4.5.mat')
L = phase_shift;

num_phase = 100;

figure(1)
plot((0:num_phase-1)/num_phase,N,'-','LineWidth',2)
hold on
plot((0:num_phase-1)/num_phase,S,'-','LineWidth',2)
plot((0:num_phase-1)/num_phase,M,'-','LineWidth',2)
% plot((0:num_phase-1)/num_phase,L,'-','LineWidth',2)
ax = gca;
ax.FontSize = 14; 

ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 320])
xlabel('\phi, normalized phase of when stimulus is applied','FontSize',15)
ylabel('normalized phase advancement','FontSize',15)
legend({'D = 0','D = 1.5','D = 3'})