clear all
clc

Gc = [0.01 0.02 0.03 0.05 0.1];

%%  RG
% load('RG_r5.mat')
% PD = RG_phase_shift - phase_shift;
% PD_R = [min(PD');max(PD')]';
% 
% bar(PD_R*100,'stacked','BarWidth',0.35, 'ShowBaseLine', 'off')

% load('RG_r5.mat')
% PD5 = RG_phase_shift - phase_shift;
% PD_R5 = [min(PD5');max(PD5')];
% load('RG_r10.mat')
% PD10 = RG_phase_shift - phase_shift;
% PD_R10 = [min(PD10');max(PD10')];
% 
% groupLabels = categorical({'G_c = 0.01', 'G_c/I_s = 0.02','G_c/I_s = 0.03','G_c/I_s = 0.05','G_c/I_s = 0.1'});
% Bar(:,:,1) = PD_R5';Bar(:,:,2) = PD_R10';
% plotBarStackGroups(Bar, groupLabels)

%%  PF
load('PF_r5.mat')
PD5 = RG_phase_shift - phase_shift;
PD_R5 = [min(PD5');max(PD5')];
load('PF_r10.mat')
PD10 = RG_phase_shift - phase_shift;
PD_R10 = [min(PD10');max(PD10')];

groupLabels = categorical({'G_c = 0.01', 'G_c/I_s = 0.02','G_c/I_s = 0.03','G_c/I_s = 0.05','G_c/I_s = 0.1'});
Bar(:,:,1) = PD_R5';Bar(:,:,2) = PD_R10';
plotBarStackGroups(Bar, groupLabels)
ylim([-0.15 0.1])
