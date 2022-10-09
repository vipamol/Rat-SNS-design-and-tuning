clear all
clc

%% scatter plot
% load ('4_PS.mat')
% load ('4_F.mat')

load ('5-0.1_PS.mat')
load ('5-0.1_F.mat')

figure (1)
hold on
xlabel('Frequency (Hz)')
ylabel('Phase delay  (%)')

pause(3);

for i = 1:size(PS,1)
    scatter(RFD(i,:),-PS(i,:),'*')
    pause(0.5);
end

