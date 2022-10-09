clear all
clc

Gw = 0.01;
D = 0;
G_syn = 1.62509765625;

dt = 1; 
t_max = 5e3;

ext_stim = zeros(t_max/dt,8);

G = 1.4:0.0001:1.63;
% G = 1.5:0.0001:1.63;
num_step = length(G);

%% F
% Gc = 0;
% F = zeros(num_step,1);
% 
% tic
% parfor i = 1:num_step
% 
% F(i) = f_G_TLC (D,Gw,Gc,G_syn,G(i),ext_stim,t_max,dt);
% 
% end
% toc
% 
% figure(1)
% hold on 
% grid on
% plot(G,F)

%% PS
% Gcon = [0.02 0.05 0.1 0.2 0.5 1];
Gcon = 1;


PD = zeros(num_step,1);

tic
for k = 1:length(Gcon)
    Gc = Gcon(k);
    
    parfor i = 1:num_step  
        PS = f_PS_TLC (D,Gw,Gc,G_syn,G(i),ext_stim,t_max,dt); 
        PD(i) = mean(PS)/10;
    end

    filename = sprintf ('PS%01d.mat', k);
    save(filename','PD')
end
toc

figure(1)
hold on 
grid on
plot(G,PD)