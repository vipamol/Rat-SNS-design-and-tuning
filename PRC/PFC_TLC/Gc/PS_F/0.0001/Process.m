clear all
clc

load('F.mat')

load('PS1.mat')
S = PD;
load('PS2.mat')
M = PD;
load('PS3.mat')
L = PD;

G = 1.602:0.0001:1.625;

% figure(1)
% hold on 
% grid on
% plot(G,S)
% plot(G,M)
% plot(G,L)

figure(2)
hold on 
grid on
plot(F,S)
plot(F,M)
plot(F,L)
xlim([0.8 1.2])
xlabel('Frequency of the PF (Hz)')
ylabel('Phase shift between two layers (%)')
set(gcf,'Position',[500 200 600 400])