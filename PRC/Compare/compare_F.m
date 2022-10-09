clear all
clc

%% For inhibition
load ('Gw0-D0.mat')
N = F;
load ('Gw0-D6.mat')
D6 = F;
load ('Gw0-D2.mat')
D2 = F;
load ('Gw0-Ds.mat')
S = F;
load ('Gw-D0.mat')
G= F;


Deltas =[-0.2:0.01:1];

figure(1)
grid on
hold on
plot(Deltas,N,'LineWidth',2)
plot(Deltas,D6,'--','LineWidth',2)
plot(Deltas,S,':','LineWidth',2)
plot(Deltas,G,'LineWidth',2)
plot(Deltas,D2,'--','LineWidth',2)
xlim([0 0.4])
ylim([0 3])
set(gcf,'Position',[500 200 600 300])
xlabel('\delta, bifurcation parameter')
ylabel('oscillation frequiency (Hz)')

