load ('D-.mat')
D = phase_shift;
load ('Gw-.mat')
Gw = phase_shift;
load ('Gw.1-.mat')
Gw1 = phase_shift;
load ('Gw.3-.mat')
Gw3 = phase_shift;

num_phase = 100;

figure(1)
hold on
plot((0:num_phase-1)/num_phase,Gw,'LineWidth',2)
plot((0:num_phase-1)/num_phase,Gw3,'LineWidth',2)
plot((0:num_phase-1)/num_phase,Gw1,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D,'LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
legend('D = 0  G = 2   Gw = 0.59','D = 2.09  G = 2  Gw = 0.3','D = 4.3719  G = 2  Gw = 0.1','D = 6.0152  G = 2   Gw = 0')

load ('D+.mat')
D = phase_shift;
load ('Gw+.mat')
Gw = phase_shift;
load ('Gw.1+.mat')
Gw1 = phase_shift;
load ('Gw.3+.mat')
Gw3 = phase_shift;

figure(2)
hold on
plot((0:num_phase-1)/num_phase,Gw,'LineWidth',2)
plot((0:num_phase-1)/num_phase,Gw3,'LineWidth',2)
plot((0:num_phase-1)/num_phase,Gw1,'LineWidth',2)
plot((0:num_phase-1)/num_phase,D,'LineWidth',2)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
