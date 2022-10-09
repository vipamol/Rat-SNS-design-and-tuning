clear all
clc

time = 10e3;
dt = 1;
ext_stim = zeros(time/dt,4);

Gw = 0:0.01:1;
D = 0:0.1:10;

F = zeros(length(Gw),length(D));
d = length(D);

 tic
parfor i = 1:length(Gw)  
    for j = 1:d
        [RG_EXT,RG_FLX] = RG(D(j),Gw(i),ext_stim,time,dt);
%         keyboard
        [Frequency,~] = ff(RG_EXT(1,:),RG_FLX(1,:),dt);
        F(i,j) = Frequency;
    end
end
toc

disp('simulation done')

[X,Y] = meshgrid(Gw,D);
surf(X,Y,F)
colorbar