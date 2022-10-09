clear all
clc

Gc = 0.01:0.001:0.05;
num_phase = 100;

%% RG
load('RG_cone.mat')

figure(1)
mesh (RG_phase_shift,'edgecolor','r')
hold on
mesh (phase_shift,'edgecolor','b')
% yticklabels([0.01 0.1 0.2 0.3 0.4])

xlabel('normalized phase')
ylabel('G_c')
zlabel('normalized phase advancement')

figure (2)
PD = RG_phase_shift - phase_shift;

PD_R = [min(PD');max(PD')]';
bar(Gc,PD_R,'stacked','BarWidth',0.35, 'ShowBaseLine', 'off')

figure (3)

%number of blocks to average around
avgblocks = 10;
%converted to coefficients for the filtfilt function
coeffblocks = ones(1,avgblocks)/avgblocks;

%For each joint, do the averaging of 10 data points many (originally set to
%50) times
for j=1:2
    for i=1:50
        PD_RS(:,j) = filtfilt(coeffblocks,1,PD_R(:,j));
    end
end

plot(Gc,PD_RS)
xticks([0.01 0.05])
xticklabels({'Weak','Strong'})

xlabel('G_c strength')
ylabel('Phase shift between layers')

set(gcf,'Position',[500 200 600 400])
legend('Max phase delay','Max phase advance','Fontsize',12)
ax = gca;
ax.FontSize = 14; 

%% PF
% load('PF_cone.mat')
% 
% figure(1)
% mesh (RG_phase_shift,'edgecolor','r')
% hold on
% mesh (phase_shift,'edgecolor','b')
% % yticklabels([0.01 0.1 0.2 0.3 0.4])
% 
% xlabel('normalized phase')
% ylabel('G_c')
% zlabel('normalized phase advancement')
% 
% figure (2)
% PD = RG_phase_shift - phase_shift;
% 
% PD_R = [min(PD');max(PD')]';
% bar(Gc,PD_R,'stacked','BarWidth',0.35, 'ShowBaseLine', 'off')
% 
% figure (3)
% 
% %number of blocks to average around
% avgblocks = 10;
% %converted to coefficients for the filtfilt function
% coeffblocks = ones(1,avgblocks)/avgblocks;
% 
% %For each joint, do the averaging of 10 data points many (originally set to
% %50) times
% for j=1:2
%     for i=1:50
%         PD_RS(:,j) = filtfilt(coeffblocks,1,PD_R(:,j));
%     end
% end
% 
% plot(Gc,PD_RS)
% xticks([0.01 0.05])
% xticklabels({'Weak','Strong'})
% 
% xlabel('G_c strength')
% ylabel('Phase shift between layers')
% 
% set(gcf,'Position',[500 200 600 400])
% legend('Max phase delay','Max phase advance','Fontsize',12)
% ax = gca;
% ax.FontSize = 14; 