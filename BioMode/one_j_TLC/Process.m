clear all
clc

dt = 0.00005;

N = importdata('angle.txt');
data = N.data;
theta = data(:,2);


[~,ind] = findpeaks(-theta);

T = mean(diff(ind))*dt;
f1 = 1/T


%% F
% 2 Hz D = 5.03 G = 0.4374
% 1.6 Hz D = 3.732 G = 0.2458
% 1.4 Hz D = 3.063 G = 0.16828
% 1.2 Hz D = 2.335 G = 0.0984