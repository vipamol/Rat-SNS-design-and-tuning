clear all
clc

Gc = [0.01 0.02 0.03 0.05 0.1];

%% RG
% load('RG_-0.05.mat')
% PD5 = RG_phase_shift - phase_shift;
% PD_R5 = [min(PD5');max(PD5')];
% load('RG_-0.25.mat')
% PD25 = RG_phase_shift - phase_shift;
% PD_R25 = [min(PD25');max(PD25')];
% load('RG_-0.5.mat')
% PD50 = RG_phase_shift - phase_shift;
% PD_R50 = [min(PD50');max(PD50')];
% 
% groupLabels = categorical({'G_c = 0.01', 'G_c/I_s = 0.02','G_c/I_s = 0.03','G_c/I_s = 0.05','G_c/I_s = 0.1'});
% Bar(:,1,:) = PD_R50';Bar(:,2,:) = PD_R25';Bar(:,3,:) = PD_R5';
% plotBarStackGroups(Bar, groupLabels)
% 
% ylim([-0.25 0.15])

%% PF
load('PF_-0.05.mat')
PD5 = RG_phase_shift - phase_shift;
PD_R5 = [min(PD5');max(PD5')];
load('PF_-0.25.mat')
PD25 = RG_phase_shift - phase_shift;
PD_R25 = [min(PD25');max(PD25')];
load('PF_-0.5.mat')
PD50 = RG_phase_shift - phase_shift;
PD_R50 = [min(PD50');max(PD50')];

groupLabels = categorical({'G_c = 0.01', 'G_c/I_s = 0.02','G_c/I_s = 0.03','G_c/I_s = 0.05','G_c/I_s = 0.1'});
Bar(:,1,:) = PD_R50';Bar(:,2,:) = PD_R25';Bar(:,3,:) = PD_R5';
plotBarStackGroups(Bar, groupLabels)

ylim([-0.25 0.15])