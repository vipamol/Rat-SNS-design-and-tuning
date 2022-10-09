clear all
clc

load('F.mat')

load('PS1.mat')
S = PD;
load('PS2.mat')
M = PD;
load('PS3.mat')
L = PD;

%% Bar
% Bar = [S,M,L];
% 
% boxchart(Bar)
% 
% ax = gca;
% ax.FontSize = 13; 
% 
% xticklabels({'G_c = 0.05', 'G_c = 0.1', 'G_c = 1'})
% ylabel('Phase shift between two layers (%)')
% set(gcf,'Position',[500 200 600 400])

%% Frequency

num_of_samples = 100;

Fs = find(~isnan(S));
Fm = find(~isnan(M));
Fl = find(~isnan(L));

S = F(Fs);M = F(Fm);L = F(Fl);

S = interp1(linspace(0,1,length(S)),S,linspace(0,1,num_of_samples));
M = interp1(linspace(0,1,length(M)),M,linspace(0,1,num_of_samples));
L = interp1(linspace(0,1,length(L)),L,linspace(0,1,num_of_samples));


Bar = [S',M',L'];

boxchart(Bar)

ax = gca;
ax.FontSize = 13; 

xticklabels({'G_c = 0.05', 'G_c = 0.1', 'G_c = 1'})
ylabel('Intrinsic frequency of the PF (Hz)')
set(gcf,'Position',[500 200 600 400])