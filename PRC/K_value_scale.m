% K = gs*Delta(Es)/(R*(1+gs));
clear all
clc

%% For Ns's insect
%  Deltas =[-2:0.1:-0.2,-0.1:0.01:0.3,0.4:0.1:10];
% load('G_NS.mat')
% 
% R = 40; % R = Ehi-Elow = (-20)-(-60) = 40;
% deltEi = -40; %delEsyn = Einh - Er = (-100)-(-60) = -40;
% deltEe = 360; %delEsyn = Eexc - Er = (300)-(-60) = 360;
% 
% Ke = 0.118*deltEe/(R*(1+0.118));
% for i = 1:length(G)
%     Ki(i) = G(i)*deltEi/(R*(1+G(i)));
% end

%% For rat
% Deltas =[-0.2:0.01:1];
% load('G_rat.mat')

% R = 20; % R = Ehi-Elow = (-40)-(-60) = 20;
% deltEi = -10; %delEsyn = Einh - Er = (-70)-(-60) = -10;
% deltEe = 20; %delEsyn = Eexc - Er = (-40)-(-60) = 20;
% 
% for i = 1:length(G)
%     Ke(i) = G(i)*deltEe/(R*(1+G(i)));
%     Ki(i) = G(i)*deltEi/(R*(1+G(i)));
% end

%% Compare
Deltas = -0.2:0.01:1 ;
% for insect
load('G_NS_scale.mat')

R = 40; % R = Ehi-Elow = (-20)-(-60) = 40;
deltEi = -40; %delEsyn = Einh - Er = (-100)-(-60) = -40;
deltEe = 360; %delEsyn = Eexc - Er = (300)-(-60) = 360;

NS_Ke = 0.118*deltEe/(R*(1+0.118));
for i = 1:length(G)
    NS_Ki(i) = G(i)*deltEi/(R*(1+G(i)));
end

NS_K = NS_Ke* NS_Ki;

% for rat 
load('G_rat.mat')
R = 20; % R = Ehi-Elow = (-40)-(-60) = 20;
deltEi = -10; %delEsyn = Einh - Er = (-70)-(-60) = -10;
deltEe = 20; %delEsyn = Eexc - Er = (-40)-(-60) = 20;

for i = 1:length(G)
    Rat_Ke(i) = G(i)*deltEe/(R*(1+G(i)));
    Rat_Ki(i) = G(i)*deltEi/(R*(1+G(i)));
    Rat_K(i) = Rat_Ke(i)*Rat_Ki(i);
end

figure(1)
hold on 
plot(Deltas,NS_Ki,'b','LineWidth',2)
plot(Deltas,Rat_Ki,'b:','LineWidth',2)
grid on 
set(gcf,'Position',[500 200 600 300])

figure(2)
hold on 
plot([-0.2 1],[NS_Ke NS_Ke],'r','LineWidth',2)
plot(Deltas,Rat_Ke,'r:','LineWidth',2)
grid on 
set(gcf,'Position',[500 200 600 300])

figure(3)
hold on 
plot(Deltas,NS_K,'k')
plot(Deltas,Rat_K,'k:')
grid on 
set(gcf,'Position',[500 200 600 300])
%% Compare set Upre
% % K = gs*Delta(Es)/(R+gs*Upre));
% Deltas = -0.2:0.01:1 ;
% % for insect
% load('G_NS_scale.mat')
% 
% R = 40; % R = Ehi-Elow = (-20)-(-60) = 40;\
% Upre = 30; % Upre = Vmax - Er = (-30)-(-60) = 30;
% deltEi = -40; %delEsyn = Einh - Er = (-100)-(-60) = -40;
% deltEe = 360; %delEsyn = Eexc - Er = (300)-(-60) = 360;
% 
% NS_Ke = 0.118*deltEe/(R+0.118*Upre);
% for i = 1:length(G)
%     NS_Ki(i) = G(i)*deltEi/(R+G(i)*Upre);
% end
% NS_K = NS_Ke*NS_Ki;
% 
% % for rat 
% load('G_rat.mat')
% 
% R = 20; % R = Ehi-Elow = (-40)-(-60) = 20;
% Upre = 3; % Upre = Vmax - Er = (-57)-(-60) = 3;
% deltEi = -10; %delEsyn = Einh - Er = (-70)-(-60) = -10;
% deltEe = 20; %delEsyn = Eexc - Er = (-40)-(-60) = 20;
% 
% for i = 1:length(G)
%     Rat_Ke(i) = G(i)*deltEe/(R+G(i)*Upre);
%     Rat_Ki(i) = G(i)*deltEi/(R+G(i)*Upre);
%     Rat_K(i) = Rat_Ke(i)*Rat_Ki(i);
% end
% 
% figure(1)
% hold on 
% plot(Deltas,NS_Ki,'b','LineWidth',2)
% plot(Deltas,Rat_Ki,'b:','LineWidth',2)
% grid on 
% set(gcf,'Position',[500 200 600 300])
% 
% figure(2)
% hold on 
% plot([-0.2 1],[NS_Ke NS_Ke],'r','LineWidth',2)
% plot(Deltas,Rat_Ke,'r:','LineWidth',2)
% grid on 
% set(gcf,'Position',[500 200 600 300])
% 
% figure(3)
% hold on 
% plot(Deltas,NS_K)
% plot(Deltas,Rat_K)
% grid on 
% set(gcf,'Position',[500 200 600 300])