clear all
clc

time = 10e3;
dt = 1;
ext_stim = zeros(time/dt,4);
% ext_stim(2000:3000,1) = 1;
% ext_stim(2000:3000,2) = 1;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% [0 5.23] [0.1 3.5] [0.3 0.734]
D1 = 4;
Gw = 0.1;
[RG_EXT,RG_FLX] = RG(D1,Gw,ext_stim,time,dt);

figure(1)
clf
plot(RG_EXT(1,:),'r','Linewidth',2)
hold on 
plot(RG_FLX(1,:),'b','Linewidth',2)
hold off
grid on 
% legend('EXT','FLX');
xlabel('time (ms)')
ylabel('voltage (mV)')
title(['D = ',num2str(D1),'     Gw = ',num2str(Gw)])

set(gcf,'Position',[500 200 600 300])

