clear all
clc

Gc = [0.01:0.01:0.1];
num_phase = 100;

%% RG
% load('RG_0.5.mat')
% 
% figure(1)
% mesh (RG_phase_shift,'edgecolor','r')
% hold on
% mesh (phase_shift,'edgecolor','b')
% yticklabels([0.01 0.1 0.2 0.3 0.4])
% 
% xlabel('normalized phase')
% ylabel('G_c')
% zlabel('normalized phase advancement')
% Gc
% figure (2)
% PD = RG_phase_shift - phase_shift;
% 
% PD_R = [min(PD');max(PD')]';
% bar(PD_R,'stacked','BarWidth',0.35, 'ShowBaseLine', 'off')

%% PF
load('PF_0.5.mat')

figure(1)
mesh (RG_phase_shift,'edgecolor','r')
hold on
mesh (phase_shift,'edgecolor','b')
yticklabels([0.01 0.1 0.2 0.3 0.4])

xlabel('normalized phase')
ylabel('G_c')
zlabel('normalized phase advancement')

figure (2)
PD = RG_phase_shift - phase_shift;

PD_R = [min(PD');max(PD')]';
bar(PD_R,'stacked','BarWidth',0.35, 'ShowBaseLine', 'off')