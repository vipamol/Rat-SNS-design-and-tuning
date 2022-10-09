clear all
clc
%% Param
% G = 1.5:0.0001:1.63; 
% Gcon = [0.02 0.05 0.1 0.2 0.5 1];
% Gcon = [0.3 0.7];

load('F.mat')
F = F(1:1263);

load('PS1.mat')
G1 = PD(1:1263);
load('PS2.mat')
G2 = PD(1:1263);
load('PS3.mat')
G3 = PD(1:1263);
load('PS4.mat')
G4 = PD(1:1263);
load('PS5.mat')
G5 = PD(1:1263);
load('PS6.mat')
G6 = PD(1:1263);

load('PS7.mat')
G7 = PD(1:1263);
load('PS8.mat')
G8 = PD(1:1263);

%% Frequency

T1 = find(~isnan(G1));% 0.02
T2 = find(~isnan(G2));% 0.05
T3 = find(~isnan(G3));% 0.1
T4 = find(~isnan(G4));% 0.2

T5 = find(~isnan(G5));% 0.5
T6 = find(~isnan(G6));% 1

T7 = find(~isnan(G7));% 0.3 
T8 = find(~isnan(G8));% 0.7

% extract feasible frequency for each conneciton strength
F1 = F(T2); F2 = F(T3); F3 = F(T4); F4 = F(T7); F5 = F(T5); F6 = F(T8); F7 = F(T6);

B1 = [min(F1),max(F1)]; B2 = [min(F2),max(F2)]; B3 = [min(F3),max(F3)]; B4 = [min(F4),max(F4)];
B5 = [min(F5),max(F5)]; B6 = [min(F6),max(F6)]; B7 = [min(F7),max(F7)]; 

% bins = 1:7; 
% Bar = [B1;B2;B3;B4;B5;B6;B7];

bins = 1:5; 
Bar = [B1;B2;B3;B5;B7];

figure(1)
plot([bins; bins], Bar', 'LineWidth',30)

xlim([0 length(bins)+1])

ax = gca;
ax.FontSize = 13; 

% xticklabels({ '','G_c = 0.05', 'G_c = 0.1','G_c = 0.2','G_c = 0.3', 'G_c = 0.5', 'G_c = 0.7','G_c = 1'})
xticklabels({ '','G_c = 0.05', 'G_c = 0.1','G_c = 0.2', 'G_c = 0.5','G_c = 1'})
ylabel('Intrinsic frequency of the PF (Hz)')
set(gcf,'Position',[500 200 600 400])

%% Bar
% 
% B1 = [min(G2),max(G2)]; B2 = [min(G3),max(G3)]; B3 = [min(G4),max(G4)]; B4 = [min(G7),max(G7)];
% B5 = [min(G5),max(G5)]; B6 = [min(G8),max(G8)]; B7 = [min(G6),max(G6)]; 
% 
% % bins = 1:7; 
% % Bar = [B1;B2;B3;B4;B5;B6;B7];
% 
% bins = 1:5; 
% Bar = [B1;B2;B3;B5;B7];
% 
% figure(2)
% plot([bins; bins], Bar', 'LineWidth',30)
% 
% xlim([0 length(bins)+1])
% 
% ax = gca;
% ax.FontSize = 13; 
% 
% % xticklabels({ '','G_c = 0.05', 'G_c = 0.1','G_c = 0.2','G_c = 0.3', 'G_c = 0.5', 'G_c = 0.7','G_c = 1'})
% xticklabels({ '','G_c = 0.05', 'G_c = 0.1','G_c = 0.2', 'G_c = 0.5','G_c = 1'})
% ylabel('Phase shift between two layers (%)')
% set(gcf,'Position',[500 200 600 400])