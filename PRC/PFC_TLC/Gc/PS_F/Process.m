clear all
clc

% G = 1.6:0.005:1.625;

load('F.mat')

load('PS1.mat')
S = PD;
load('PS2.mat')
M = PD;
load('PS3.mat')
L = PD;

%% Direct plot
% figure(1)
% hold on 
% % grid on
% plot(F,S,'LineWidth',1.5)
% plot(F,M,'LineWidth',1.5)
% plot(F,L,'LineWidth',1.5)
% xlim([0.8 1.2])
% 
% ax = gca;
% ax.FontSize = 13; 
% 
% col = [0, 0.5, 0;0.6350, 0.0780, 0.1840;0, 0.75, 0.75];
% colororder(col)
% 
% xlabel('Intrinsic frequency of the PF (Hz)')
% ylabel('Phase shift between two layers (%)')
% set(gcf,'Position',[500 200 600 400])
