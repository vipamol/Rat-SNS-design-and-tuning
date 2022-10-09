clear all
clc

time = 5e3;
dt = 1;

%% Structure the two layer CPG general model.
% Free parameters: D1, D2, C

D1 = 3.3;   %<-- Descending command to RG
Gw = 0.1; %<-- Weak conductance between RG
C = 1;    %<-- Conductance between RG and PF
D2 = 0.8 ;   %<-- Descending command to PF

% [2,0.1,1,4]; [2,0.1,0.01,4]; [2,0.1,0.1,10]

two_layer_CPG (D1,D2,C,Gw,time,dt,1);
% Frequency = TLC(D1,D2,C,Gw,time,dt);
[Relative_frequency_difference,Phase_shift] = PS_TLC (D1,D2,C,Gw,time,dt);

disp('simulation done')


%% Pick D1& C, Sweep D2 

% D1 = 3;
% Gw = 0.1;
% C = 0.1;
% 
% D2 = 0:0.05:10;
% T = zeros(length(D2),2);
% parfor i = 1:length(D2)
%     [Periods] = two_layer_CPG (D1,D2(i),C,Gw,time,dt,0);
%     T(i,:) = Periods;
% end
% 
% disp('simulation done')
% 
% figure(1)
% plot(D2,T(:,1),'k--')
% hold on 
% plot(D2,T(:,2))
% hold off
% xlabel('Descending Dive (nA)')
% ylabel('Phase duration (ms)')
% title(['D1 = ',num2str(D1),'     C = ',num2str(C)])
% 
% figure(2)
% plot(D2,T(:,1)-T(:,2))
% xlabel('Descending Dive (nA)')
% ylabel('Phase duration (ms)')
% title(['D1 = ',num2str(D1),'     C = ',num2str(C)])

%% Pick D1& D2, Sweep C 

% D1 = 3;
% Gw = 0.1;
% D2 = 5;
% 
% C = 0:0.1:10;
% T = zeros(length(C),2);
% parfor i = 1:length(C)
%     [Periods] = two_layer_CPG (D1,D2,C(i),Gw,time,dt,0);
%     T(i,:) = Periods;
% end
% 
% disp('simulation done')
% 
% figure(1)
% plot(C,T(:,1),'k--')
% hold on 
% plot(C,T(:,2))
% hold off
% xlabel(' Conductance between RG and PF (uS)')
% ylabel('Phase duration (ms)')
% title(['D1 = ',num2str(D1),'     D2 = ',num2str(D2)])

%% Pick D1, Sweep D2 & C(<0.1)

% D1 = 3;
% Gw = 0.1;
% 
% D2 = 0:0.1:10;
% C = 0:0.01:0.2;
% T = zeros(length(C),length(D2));
% 
% for i = 1:length(C)
%     parfor j = 1:length(D2)
%         [Periods] = two_layer_CPG (D1,D2(j),C(i),Gw,time,dt,0);
%         T(i,j) = Periods(:,2);
%     end
% end
% 
% disp('simulation done')
% 
% [X,Y] = meshgrid(D2,C);
% surf(X,Y,T)
% colorbar

%% Pick D1, Sweep D2 & C(>0.1)

% D1 = 3;
% Gw = 0.1;
% 
% D2 = 0:1:10;
% C = 0:.1:5;
% T = zeros(length(C),length(D2));
% 
% for i = 1:length(C)
%     parfor j = 1:length(D2)
%         [Periods] = two_layer_CPG (D1,D2(j),C(i),Gw,time,dt,0);
%         T(i,j) = Periods(:,2);
%     end
% end
% 
% disp('simulation done')
% 
% [X,Y] = meshgrid(D2,C);
% surf(X,Y,T)
% colorbar

%% Pick new D1

% D1 = 0:0.1:10;
% Gw = 0.1;
% 
% D2 = 4;
% C = 0.01;
% T = zeros(length(D1),2);
% 
% parfor i = 1:length(D1)
%     [Periods] = two_layer_CPG (D1(i),D2,C,Gw,time,dt,0);
%     T(i,:) = Periods;
% end
% 
% disp('simulation done')
% 
% figure(1)
% plot(D1,T(:,1),'k--')
% hold on 
% plot(D1,T(:,2))
% hold off
% xlabel('Descending Dive (nA)')
% ylabel('Phase duration (ms)')
% title(['D2 = ',num2str(D2),'     C = ',num2str(C)])
% 
% figure(2)
% plot(D1,T(:,1)-T(:,2))
% xlabel('Descending Dive (nA)')
% ylabel('Phase duration (ms)')
% title(['D2 = ',num2str(D2),'     C = ',num2str(C)])

%% Sweep D1&C(C>0.1)
% It takes long time to run, so the result saved in Figure 2.
% As Sweep D & C+0.1 format.

% D1 = 0:0.1:10;
% Gw = 0.1;
% 
% D2 = 4;
% C = 0:.1:5;
% T = zeros(length(C),length(D1));
% D = zeros(length(C),length(D1));
% 
% for i = 1:length(C)
%     parfor j = 1:length(D1)
%         [Periods] = two_layer_CPG (D1(j),D2,C(i),Gw,time,dt,0);
%         T(i,j) = Periods(:,2);
%         D(i,j) = Periods(:,1)-Periods(:,2);
%     end
% end
% 
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D1,C);
% surf(X,Y,T)
% colorbar
% 
% figure(2)
% surf(X,Y,D)
% colorbar

%% Sweep D1&C(C<0.2)

% D1 = 0:0.1:10;
% Gw = 0.1;
% 
% D2 = 4;
% C = 0:.01:0.2;
% T = zeros(length(C),length(D1));
% D = zeros(length(C),length(D1));
% 
% for i = 1:length(C)
%     parfor j = 1:length(D1)
%         [Periods] = two_layer_CPG (D1(j),D2,C(i),Gw,time,dt,0);
%         T(i,j) = Periods(:,2);
%         D(i,j) = Periods(:,1)-Periods(:,2);
%     end
% end
% 
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D1,C);
% surf(X,Y,T)
% colorbar
% 
% figure(2)
% surf(X,Y,D)
% colorbar

%% Sweep D1&D2//// C = 0.01; 0.1; 1

% D1 = 0:.1:6;
% Gw = 0.1;
% 
% D2 = 0:.1:10;
% C = 0.01;
% T1 = zeros(length(D1),length(D2));
% T2 = zeros(length(D1),length(D2));
% 
% for i = 1:length(D1)
%     parfor j = 1:length(D2)
%         [Periods] = two_layer_CPG (D1(i),D2(j),C,Gw,time,dt,0);
%         T1(i,j) = Periods(:,1);
%         T2(i,j) = Periods(:,2);
%     end
% end
% 
% D = T1-T2;
% 
% disp('simulation done')
% 
% figure(1)
% [X,Y] = meshgrid(D2,D1);
% surf(X,Y,T1)
% colorbar
% 
% figure(2)
% surf(X,Y,T2)
% colorbar
% 
% figure(3)
% surf(X,Y,D)
% colorbar