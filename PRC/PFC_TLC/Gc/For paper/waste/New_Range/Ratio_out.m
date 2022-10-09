clear all
clc

Gc = 0.01:0.01:0.1;
% load('PF_G.mat')
% PF_G = PF_G(1:10);
% ramp_mag = -[0.05:0.05:0.5]*5;

%%  RG
% load('RG_r5.mat')
% PD = RG_phase_shift - phase_shift;
% PD_R = [min(PD');max(PD')]';
% 
% bar(PD_R*100,'stacked','BarWidth',0.35, 'ShowBaseLine', 'off')

load('RG_r5.mat')
PD5 = RG_phase_shift - phase_shift;
PD_R5 = [min(PD5');max(PD5')]';
load('RG_r10.mat')
PD10 = RG_phase_shift - phase_shift;
PD_R10 = [min(PD10');max(PD10')]';
load('RG_r25.mat')
PD25 = RG_phase_shift - phase_shift;
PD_R25 = [min(PD25');max(PD25')]';

% groupLabels = categorical({'G_c/I_s = 5', 'G_c/I_s = 10','G_c/I_s = 25'});
% Bar(1,:,:) = PD_R5; Bar(2,:,:) = PD_R10; Bar(3,:,:) = PD_R25;
% plotBarStackGroups(Bar, groupLabels)

%%  PF

load('PF_r5.mat')
PD5 = RG_phase_shift - phase_shift;
PD_R5 = [min(PD5');max(PD5')]';
load('PF_r10.mat')
PD10 = RG_phase_shift - phase_shift;
PD_R10 = [min(PD10');max(PD10')]';
load('PF_r25.mat')
PD25 = RG_phase_shift - phase_shift;
PD_R25 = [min(PD25');max(PD25')]';

