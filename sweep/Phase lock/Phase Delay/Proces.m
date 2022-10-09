clear all
clc

%% scatter plot
load ('1_PS.mat')
load ('1_RFD.mat')

% load ('PS_C_0.01.mat')
% load ('RFD_C_0.01.mat')

figure (1)
hold on
xlabel('Frequency difference (%)')
ylabel('Phase delay  (%)')

% pause(3);

for i = 1:size(PS,1)
    scatter(RFD(i,:)*100,-PS(i,:),'*')
    pause(0.5);
%     keyboard
end

% for i = 1:size(PS,2)
%     scatter(RFD(:,i)*100,-PS(:,i),'*')
%     keyboard
% end
