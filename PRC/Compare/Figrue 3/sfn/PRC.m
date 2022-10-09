clear all
clc

%% \phi = 0.2
% load('D_0.2.mat')
% load('G_0.2.mat')
% 
% figure (1)
% 
% plot(D(1,:),'r','Linewidth',2)
% hold on 
% plot(D(2,:),'r--','Linewidth',2)
% 
% plot(G(1,:),'b','Linewidth',2)
% plot(G(2,:),'b--','Linewidth',2)
% 
% xlim([0 2000])
% xticks([0 500 1000 1500 2000])
% xticklabels ([0 0.5 1 1.5 2])
% 
% ylim([-65 -45])
% ax = gca;
% ax.FontSize = 16;
% xlabel('\phi, normalized phase','Fontsize',16)
% ylabel('voltage (mV)','Fontsize',16)
% 
% set(gcf,'Position',[500 200 600 300])

%% \phi = 0.4
load('D_0.4.mat')
load('G_0.4.mat')

figure (1)

plot(D(1,:),'r','Linewidth',2)
hold on 
plot(D(2,:),'r--','Linewidth',2)

plot(G(1,:),'b','Linewidth',2)
plot(G(2,:),'b--','Linewidth',2)

xlim([0 2000])
xticks([0 500 1000 1500 2000])
xticklabels ([0 0.5 1 1.5 2])

ylim([-65 -45])
ax = gca;
ax.FontSize = 16;
xlabel('\phi, normalized phase','Fontsize',16)
ylabel('voltage (mV)','Fontsize',16)

set(gcf,'Position',[500 200 600 300])