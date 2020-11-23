function Plot_test(nstate)

figure(1)
clf
subplot(2,1,1)
plot(nstate(1,:,1),'r','Linewidth',2)
hold on
plot(nstate(1,:,2),'b','Linewidth',2)
hold off
grid on
legend('EXT','FLX');
xlabel('time (ms)')
ylabel('voltage (mV)')
title('PF Voltage')

subplot(2,1,2)
plot(nstate(1,:,3),'r','Linewidth',2)
hold on
plot(nstate(1,:,4),'b','Linewidth',2)
hold off
grid on
legend('EXT IN','FLX IN');
xlabel('time (ms)')
ylabel('Curret(nA)')
title('External Stimulus')

set(gcf,'Position',[500 200 900 600])
end