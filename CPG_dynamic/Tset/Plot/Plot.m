clear all
clc

time = 5e3;
dt = 1;

Th = 350; %ms
Sh = -.6; % <=================================
VmidH = -60; %mV


h = figure (1);
set(h,'Position',[500,200,800,600])
ylim([0 1])
xlabel('Voltage (mV)')
ylabel('h')
hold on
grid on
tails = 450;
U_Range = -70:.1:-40;

hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5);
plot(U_Range,hInf(U_Range),'g--','linewidth',2)
plot([-60 -60],[0 1],'k--','linewidth',1)

load('V_null_1.mat')
pE1 = plot(U_Range, V_Null(1,:),'r','linewidth',2);
pF1 = plot(U_Range, V_Null(2,:),'b','linewidth',2);

load('V_null_2.mat')
pE2 = plot(U_Range, V_Null(1,:),'m-.','linewidth',2);
pF2 = plot(U_Range, V_Null(2,:),'c-.','linewidth',2);

load('V_null_3.mat')
pE1 = plot(U_Range, V_Null(1,:),'r:','linewidth',2);
pF1 = plot(U_Range, V_Null(2,:),'b:','linewidth',2);

hh = figure (2);
set(hh,'Position',[500,200,800,600])
tSim = 1:dt:time;
xlim([500,max(tSim)])

subplot(3,1,1)
hold on
grid on
load('U_1.mat')
pUE = plot(tSim(500:end),U(1,500:end),'r','linewidth',2);
pUF = plot(tSim(500:end),U(2,500:end),'b','linewidth',2);

subplot(3,1,3)
hold on
grid on
load('U_2.mat')
pUE = plot(tSim(500:end),U(1,500:end),'m-.','linewidth',2);
pUF = plot(tSim(500:end),U(2,500:end),'c-.','linewidth',2);

subplot(3,1,2)
hold on
grid on
load('U_3.mat')
pUE = plot(tSim(500:end),U(1,500:end),'r:','linewidth',2);
pUF = plot(tSim(500:end),U(2,500:end),'b:','linewidth',2);