clear all
clc

dt = 0.00005;

N = importdata('angle.txt');
data = N.data;
theta = data(:,2);


[~,ind] = findpeaks(-theta);

T = mean(diff(ind))*dt;
f1 = 1/T


