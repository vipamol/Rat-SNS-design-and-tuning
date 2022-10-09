clear all
clc

%% Baseline
load('Joint.mat')
A_H = Joint(:,3);

[~,I] = max(A_H);

ratio = I/length(A_H);

%% 2Hz
N = importdata('D2-angle.txt');
data = N.data;
D_theta = data(:,2);
D2_ratio = f_ratio(D_theta);

N = importdata('G2-angle.txt');
data = N.data;
G_theta = data(:,2);
G2_ratio = f_ratio(G_theta);

%% 1.6 Hz
N = importdata('D1-angle.txt');
data = N.data;
D_theta = data(:,2);
D1_ratio = f_ratio(D_theta);

N = importdata('G1-angle.txt');
data = N.data;
G_theta = data(:,2);
G1_ratio = f_ratio(G_theta);
%% 1.4 Hz
N = importdata('D0-angle.txt');
data = N.data;
D_theta = data(:,2);
D0_ratio = f_ratio(D_theta);

N = importdata('G0-angle.txt');
data = N.data;
G_theta = data(:,2);
G0_ratio = f_ratio(G_theta);
%% 1.2 Hz
N = importdata('D-angle.txt');
data = N.data;
D_theta = data(:,2);
D_ratio = f_ratio(D_theta);

N = importdata('G-angle.txt');
data = N.data;
G_theta = data(:,2);
G_ratio = f_ratio(G_theta);
%% plot
RD = ([D_ratio D0_ratio D1_ratio D2_ratio]-ratio)*100;
RG = ([ G_ratio G0_ratio G1_ratio G2_ratio]-ratio)*100;

F = [1.2 1.4 1.6 2];

figure(1)
hold on 
plot(F,RD,'linewidth',2)
plot(F,RG,'linewidth',2)
% plot([1.2 2],[ratio ratio]*100,'k--')

ax = gca;
ax.FontSize = 13;

xlabel('Frequencies (Hz)')
ylabel('Relative duiration of stance phase (%)')
set(gcf,'Position',[500 200 600 400])

% figure(2)
% 
% TD = [(D_ratio)/1.2  (D0_ratio)/1.4 (D1_ratio)/1.6 (D2_ratio)/2];
% TG = [(G_ratio)/1.2  (G0_ratio)/1.4  (G1_ratio)/1.6 (G2_ratio)/2];
% 
% hold on 
% plot(F,TD,'linewidth',2)
% plot(F,TG,'linewidth',2)