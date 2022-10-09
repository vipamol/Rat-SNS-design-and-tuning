clear all
clc

time = 5e3;
dt = 1;
% 0.02 4.6 4.7
%% Structure the two layer CPG general model.
% Free parameters: D1, D2, C

D1 = 4;   %<-- Descending command to RG
Gw = 0.1; %<-- Weak conductance between RG
C = 0.1;    %<-- Conductance between RG and PF
D2 = 4;   %<-- Descending command to PF

two_layer_CPG (D1,D2,C,Gw,time,dt,1);
% [Relative_frequency_difference,Phase_shift] = PS_TLC (D1,D2,C,Gw,time,dt);
% Frequency = TLC(D1,D2,C,Gw,time,dt);
% [Drive,Descend] = R_TLC (D1,D2,C,Gw,time,dt);

disp('simulation done')

% plot(Descend(1,:))
% hold on 
% plot(Descend(2,:))

%% Sweep D1&D2//// C = 0.1
% 
% D1 = 2:.1:4.5;
% Gw = 0.1;
% D2 = 0:.1:5;
% C = 0.1;
% 
% DR = zeros(length(D1),length(D2));
% DE = DR;
% tic
% for i = 1:length(D1)
%     parfor j = 1:length(D2)
%         [Drive,Descend] = R_TLC (D1(i),D2(j),C,Gw,time,dt);
%         
%     end
% end
% toc
% disp('simulation done')


%% phase plane
% D1 = 3;   %<-- Descending command to RG
% Gw = 0.1; %<-- Weak conductance between RG
% C = 0.1;    %<-- Conductance between RG and PF
% D2 = 4;   %<-- Descending command to PF
% 
% PL_TLC (D1,D2,C,Gw,time,dt,2);
