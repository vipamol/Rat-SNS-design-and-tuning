clear all
clc

load('F.mat')
Fl = F(1:1263);

load('PS2.mat')
G1 = PD(1:1263);
load('PS3.mat')
G2 = PD(1:1263);
load('PS4.mat')
G3 = PD(1:1263);

load('F+.mat')
Fh = F(1:2263);

load('PS1+.mat')
G4 = PD(1:2263);

load('PS2+.mat')
G5 = PD(1:2263);

%% Frequency
T1 = find(~isnan(G1));% 0.05
T2 = find(~isnan(G2));% 0.1
T3 = find(~isnan(G3));% 0.2
T4 = find(~isnan(G4));% 0.5
T5 = find(~isnan(G5));% 1

% extract feasible frequency for each conneciton strength
F1 = Fl(T1); F2 = Fl(T2); F3 = Fl(T3); F4 = Fh(T4); F5 = Fh(T5);

B1 = [min(F1),max(F1)]; B2 = [min(F2),max(F2)]; B3 = [min(F3),max(F3)];
B4 = [min(F4),max(F4)]; B5 = [min(F5),max(F5)];

bins = 1:5; 
Bar = [B1;B2;B3;B4;B5];

figure(1)
plot([bins; bins], Bar', 'LineWidth',30)

xlim([0 length(bins)+1])

text(0.75,0.67,'0.7382','FontSize',14);text(0.75,1.2,'1.1033','FontSize',14);
text(1.75,0.62,'0.6748','FontSize',14);text(1.75,1.55,'1.4627','FontSize',14);
text(2.75,0.62,'0.6748','FontSize',14);text(2.75,1.8,'1.7178','FontSize',14);
text(3.75,0.62,'0.6748','FontSize',14);text(3.75,2.35,'2.2492','FontSize',14);
text(4.75,0.62,'0.6748','FontSize',14);text(4.75,2.35,'2.2507','FontSize',14);

xticklabels({ '','G_c = 0.05', 'G_c = 0.1','G_c = 0.2', 'G_c = 0.5','G_c = 1'})
ylabel('Intrinsic frequency of the PF (Hz)')
set(gcf,'Position',[500 200 730 400])

ax = gca;
ax.FontSize = 16; 

%% Bar

B1 = [min(abs(G1)),max(G1)]; B2 = [min(abs(G2)),max(G2)]; B3 = [min(abs(G3)),max(G3)];
B4 = [min(abs(G4)),max(G4)]; B5 = [min(abs(G5)),max(G5)];

bins = 1:5; 
Bar = [B1;B2;B3;B4;B5];

figure(2)
plot([bins; bins], Bar', 'LineWidth',30)

xlim([0 length(bins)+1])
ylim([-0.5 6])

text(0.85,4.3,'4.46','FontSize',14);text(0.85,5.6,'5.36','FontSize',14);
text(1.9,-0.12,'0.1','FontSize',14);text(1.95,4.2,'4','FontSize',14);
text(2.8,-0.1,'0.06','FontSize',14);text(2.9,3.15,'2.9','FontSize',14);
text(3.95,-0.15,'0','FontSize',14);text(3.9,2.05,'1.8','FontSize',14);
text(4.9,0.1,'0.3','FontSize',14);text(4.9,1.55,'1.3','FontSize',14);

xticklabels({ '','G_c = 0.05', 'G_c = 0.1','G_c = 0.2', 'G_c = 0.5','G_c = 1'})
ylabel('Phase shift between two layers (%)')
set(gcf,'Position',[500 200 730 400])

ax = gca;
ax.FontSize = 16; 