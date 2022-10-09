clear all
clc

Gc = [0.01 0.02 0.03 0.05 0.1];

%% RG
% load('RG_r5.mat')
% PD5 = RG_phase_shift - phase_shift;
% PD_R5 = [min(PD5');max(PD5')];
% load('RG_r10.mat')
% PD10 = RG_phase_shift - phase_shift;
% PD_R10 = [min(PD10');max(PD10')];
% load('RG_r15.mat')
% PD15 = RG_phase_shift - phase_shift;
% PD_R15 = [min(PD15');max(PD15')];
% load('RG_r20.mat')
% PD20 = RG_phase_shift - phase_shift;
% PD_R20 = [min(PD20');max(PD20')];
% 
% groupLabels = categorical({'G_c = 0.01', 'G_c = 0.02','G_c= 0.03','G_c = 0.04','G_c = 0.05'});
% Bar(:,1,:) = PD_R5';Bar(:,2,:) = PD_R10';Bar(:,3,:) = PD_R15';Bar(:,4,:) = PD_R20';
% plotBarStackGroups(Bar, groupLabels)
% 
% ylim([-0.25 0.15])
% ylabel('Phase shift between layers')
% ax = gca;
% ax.FontSize = 14; 
%% PF
load('PF_r5.mat')
PD5 = RG_phase_shift - phase_shift;
PD_R5 = [min(PD5');max(PD5')];
load('PF_r10.mat')
PD10 = RG_phase_shift - phase_shift;
PD_R10 = [min(PD10');max(PD10')];
load('PF_r15.mat')
PD15 = RG_phase_shift - phase_shift;
PD_R15 = [min(PD15');max(PD15')];
load('PF_r20.mat')
PD20 = RG_phase_shift - phase_shift;
PD_R20 = [min(PD20');max(PD20')];

groupLabels = categorical({'G_c = 0.01', 'G_c = 0.02','G_c= 0.03','G_c = 0.04','G_c = 0.05'});
Bar(:,1,:) = PD_R5';Bar(:,2,:) = PD_R10';Bar(:,3,:) = PD_R15';Bar(:,4,:) = PD_R20';
plotBarStackGroups(Bar, groupLabels)

ylim([-0.25 0.15])
ylabel('Phase shift between layers')
ax = gca;
ax.FontSize = 14; 