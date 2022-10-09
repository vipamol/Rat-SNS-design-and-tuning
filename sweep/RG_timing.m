clear all
clc

time = 10e3;
dt = 1;

%% RG_timing
% Just timing of RG

C = 0;    %<-- Conductance between RG and PF
D2 = 0 ;   %<-- Descending command to PF

% Test sets 
Gw = 0;
D1 = 6;
Frequency = TLC(D1,D2,C,Gw,time,dt);
F = Frequency(:,1);
 
Gw = [0;0.1;0.3;0.573609924316406;0.7];
D1 = 0:0.1:10;
F = zeros(length(Gw),length(D1));

figure
hold on 

tic
for i = 1:length(Gw)  
   parfor j = 1:length(D1)
        Frequency = TLC(D1(j),D2,C,Gw(i),time,dt);
        F(i,j) = Frequency(:,1);
   end
   plot(D1,F(i,:),'linewidth',2)
end
toc

disp('simulation done')
set(gcf,'Position',[500 200 600 300])
legend(strcat('Gw =',num2str(Gw)))
ylabel('Frequency (Hz)')
xlabel('External drive (nA)')

ax = gca;
ax.FontSize = 14; 

% interp1(linspace(0,1,current_size),Theta,linspace(0,1,100));
% F1 = F(1,:);
% F1 = F1(F1~=0);
% FN(1,:) = interp1(linspace(0,1,54),F1,linspace(0,1,100));

% figure(1)
% plot(D1,F,'LineWidth',2)
% set(gcf,'Position',[500 200 700 400])
% ax = gca;
% ax.FontSize = 12; 
% legend(strcat('Gw =',num2str(Gw)),'Fontsize',12)
% ylabel('Frequency (Hz)','Fontsize',14)
% xlabel('External drive (nA)','Fontsize',14)