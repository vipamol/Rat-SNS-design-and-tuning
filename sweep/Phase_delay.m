%% Phase delay Vs phase ratio
clear all
clc

time = 10e3;
dt = 1;

%% Pick D1, Sweep D2 & C 
% This is the condition where the rhythm is set and see how C and stimulus
% to PF layer affects the out puts.

% Rhythm set!
D1 = 5;
Gw = 0.1;

% D2 = 0:1:10;
% C = [0:.02:0.1,0.2:0.2:1,2:1:5];

% D2 = 0:0.5:10;
% C = [0:.01:0.1,0.2:0.1:1,2:1:5];

D2 = 0:0.1:10;
C = [0:.01:0.2,0.3:0.1:2,2.5:0.5:5];

% keyboard
PS = zeros(length(C),length(D2));   
L = length(D2);

tic
parfor i = 1:length(C)
    for j = 1:L
        [~,Phase_shift] = PS_TLC (D1,D2(j),C(i),Gw,time,dt);
        PS(i,j) = Phase_shift;
    end
end
toc

disp('simulation done')

save('1.mat','PS');
% Plot
[X,Y] = meshgrid(D2,C);
h=gca;
surf(X,Y,PS);
colorbar

set(h,'yscale','log')

% figure (1)
% hold on
% xlabel('Conductance (uS)')
% ylabel('Phase delay  (%)')
% for i = 1:size(PS,1)
%     scatter(C(i,:),PS(i,:),'*')
%  
% end
% set(gca,'xscale','log')

%% Pick D2,Sweep D1&C
% This is the condition where the PF have it's rhythm is and how stimulus
% to RG layer affects the out puts.

D1 = 0:0.1:10;
Gw = 0.1;

D2 = 6;

C = [0:.01:0.1,0.2:0.1:1,2:1:5]; 
% C = [0:.01:0.2,0.3:0.1:2,2.5:0.5:5];


FQ = zeros(length(C),length(D1));
PS = FQ;
L = length(D1);

tic
parfor i = 1:length(C)
    for j = 1:L
        [frequency,Phase_shift] = PS_TLC (D1(j),D2,C(i),Gw,time,dt);
        FQ(i,j) = frequency;
        PS(i,j) = Phase_shift;
    end
end
toc
disp('simulation done')

save('2.mat','PS','FQ');

figure(1)
[X,Y] = meshgrid(D1,C);
surf(X,Y,FQ)
colorbar

figure(2)
surf(X,Y,PS)
colorbar

% figure (3)
% hold on
% xlabel('Frequency (uS)')
% ylabel('Phase delay  (%)')
% for i = 1:size(PS,2)
%     scatter(FQ(:,i),PS(:,i),'*')
% end
% 
% 
% figure (4)
% hold on
% xlabel('Conductance (uS)')
% ylabel('Phase delay  (%)')
% for i = 1:size(PS,1)
%     scatter(C(i,:),PS(i,:),'*') 
% end
% set(gca,'xscale','log')

%% Old process code.
% Below is old process code.
% PS(PS<-50) = PS(PS<-50)+100;
% PS(PS>50) = PS(PS>50)-100;

%% Sweep D2&C(C>0.1)

% D1 = 3;
% Gw = 0.1;
% 
% D2 = 0:0.1:10;
% C = 0.1:.05:5;
% RFD = zeros(length(C),length(D2));
% PS = RFD;
% tic
% for i = 1:length(C)
%     parfor j = 1:length(D2)
%         [Relative_frequency_difference,Phase_shift] = PS_TLC (D1,D2(j),C(i),Gw,time,dt);
%         RFD(i,j) = Relative_frequency_difference;
%         PS(i,j) = Phase_shift;
%     end
% end
% toc
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D2,C);
% surf(X,Y,RFD)
% colorbar
% 
% figure(2)
% surf(X,Y,PS)
% colorbar

%% Sweep D2&C(C<0.2)

% D1 = 3;
% Gw = 0.1;
% 
% D2 = 0:0.1:10;
% C = 0:0.002:0.2;
% RFD = zeros(length(C),length(D2));
% PS = RFD;
% tic
% for i = 1:length(C)
%     parfor j = 1:length(D2)
%         [Relative_frequency_difference,Phase_shift] = PS_TLC (D1,D2(j),C(i),Gw,time,dt);
%         RFD(i,j) = Relative_frequency_difference;
%         PS(i,j) = Phase_shift;
%     end
% end
% toc
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D2,C);
% surf(X,Y,RFD)
% colorbar
% 
% figure(2)
% surf(X,Y,PS)
% colorbar

%% Sweep D1&C(C>0.1)

% D1 = 0:0.1:10;
% Gw = 0.1;
% 
% D2 = 4;
% C = 0.1:.05:5;
% RFD = zeros(length(C),length(D2));
% PS = RFD;
% tic
% for i = 1:length(C)
%     parfor j = 1:length(D1)
%         [Relative_frequency_difference,Phase_shift] = PS_TLC (D1(j),D2,C(i),Gw,time,dt);
%         RFD(i,j) = Relative_frequency_difference;
%         PS(i,j) = Phase_shift;
%     end
% end
% toc
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D1,C);
% surf(X,Y,RFD)
% colorbar
% 
% figure(2)
% surf(X,Y,PS)
% colorbar

%% Sweep D1&C(C<0.2)

% D1 = 0:0.1:10;
% Gw = 0.1;
% 
% D2 = 4;
% C = 0:0.002:0.2;
% RFD = zeros(length(C),length(D2));
% PS = RFD;
% tic
% for i = 1:length(C)
%     parfor j = 1:length(D1)
%         [Relative_frequency_difference,Phase_shift] = PS_TLC (D1(j),D2,C(i),Gw,time,dt);
%         RFD(i,j) = Relative_frequency_difference;
%         PS(i,j) = Phase_shift;
%     end
% end
% toc
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D1,C);
% surf(X,Y,RFD)
% colorbar
% 
% figure(2)
% surf(X,Y,PS)
% colorbar

%% Sweep D1&D2//// C = 0.01; 0.1; 1

% D1 = 1.5:.1:8.5;
% Gw = 0.1;
% D2 = 0:.1:10;
% 
% C = 0.1;
% 
% RFD = zeros(length(D1),length(D2));
% PS = RFD;
% tic
% for i = 1:length(D1)
%     parfor j = 1:length(D2)
%         [Relative_frequency_difference,Phase_shift] = PS_TLC (D1(i),D2(j),C,Gw,time,dt);
%         RFD(i,j) = Relative_frequency_difference;
%         PS(i,j) = Phase_shift;
%     end
% end
% toc
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D2,D1);
% surf(X,Y,RFD)
% colorbar
% 
% figure(2)
% surf(X,Y,PS)
% colorbar
% 
% figure (3)
% hold on
% xlabel('Frequency (uS)')
% ylabel('Phase delay  (%)')
% for i = 1:size(PS,1)
%     scatter(RFD(i,:),PS(i,:),'*')
% end
