clear all
clc

PRC_same_frequency = 1;
PRC_DvsG = 0;

PRC_GWvsG = 0;

if PRC_same_frequency 
%% For inhibition
load ('D0-.mat')
N = phase_shift;
load ('D2-.mat')
D2 = phase_shift;
load ('D4-.mat')
D4 = phase_shift;
load ('D6-.mat')
D6 = phase_shift;
load ('Gw-.mat')
G = phase_shift;

num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D4,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,G,'-.','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')

legend('D = 0  G = 1.6198','D = 2  G = 1.7752','D = 4  G = 1.9003','D = 6  G = 2.0098','D = 0 G = 2 Gw = 0.5691')

%% For excitation
load ('D0+.mat')
N = phase_shift;
load ('D2+.mat')
D2 = phase_shift;
load ('D4+.mat')
D4 = phase_shift;
load ('D6+.mat')
D6 = phase_shift;
load ('Gw+.mat')
G = phase_shift;

num_phase = 100;
 
figure(2)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D2,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D4,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,G,'-.','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
end

if PRC_DvsG 
%% For inhibition
load ('D0-.mat')
N = phase_shift;
load ('G1.9-.mat')
S4 = phase_shift;
load ('G2-.mat')
S6 = phase_shift;
load ('D4-.mat')
D4 = phase_shift;
load ('D6-.mat')
D6 = phase_shift;

num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D4,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S4,':','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S6,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')

legend('D = 0     G = 1.6198','D = 4     G = 1.9003','G = 1.9  D = 3.9948','D = 6     G = 2.0098','G = 2     D = 5.8157')

%% For excitation
load ('D0+.mat')
N = phase_shift;
load ('G1.9+.mat')
S4 = phase_shift;
load ('G2+.mat')
S6 = phase_shift;
load ('D4+.mat')
D4 = phase_shift;
load ('D6+.mat')
D6 = phase_shift;

num_phase = 100;
 
figure(2)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D4,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S4,':','LineWidth',2)
plot((0:num_phase-1)/num_phase,D6,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S6,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
end

if PRC_GWvsG 
%% For inhibition
load ('Gw-.mat')
N = phase_shift;
load ('Gw1-.mat')
S1 = phase_shift;
load ('Gw0-.mat')
S0 = phase_shift;
load ('Gw2-.mat')
S2 = phase_shift;


num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,S0,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S1,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S2,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')

legend('G = 2.0   Gw = 0.5691','G = 1.7   Gw = 0.1119','G = 1.9   Gw = 0.41','G = 2.3   Gw = 1.0857')

%% For excitation
load ('Gw+.mat')
N = phase_shift;
load ('Gw1+.mat')
S1 = phase_shift;
load ('Gw0+.mat')
S0 = phase_shift;
load ('Gw2+.mat')
S2 = phase_shift;

num_phase = 100;
 
figure(2)
hold on
hold on
plot((0:num_phase-1)/num_phase,N,'LineWidth',2)
plot((0:num_phase-1)/num_phase,S0,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S1,'--','LineWidth',2)
plot((0:num_phase-1)/num_phase,S2,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
end
