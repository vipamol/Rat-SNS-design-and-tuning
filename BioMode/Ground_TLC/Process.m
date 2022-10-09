clear all
clc

dt = 0.00005;

N = importdata('angle.txt');
data = N.data;
theta = data(:,2);

% theta = smoothdata(theta);

[~,ind] = findpeaks(-theta,'MinPeakProminence',0.1);

T = mean(diff(ind))*dt;
f1 = 1/T


