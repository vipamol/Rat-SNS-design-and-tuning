clear all
clc

dt = 0.00005;

%% load perturbed data (10 sets) 0.05 Nm

files = dir('*.txt');

for i=1:length(files)
    Theta{i} = importdata(files(i).name).data(:,2);
    [~,ind_D{i}] = findpeaks(-Theta{i},'MinPeakProminence',0.1);
    
    for j = 1:length(ind_D{i})-1
        st =ind_D{i}(j);et = ind_D{i}(j+1)-1;
        CT = Theta{i}(st:et);
        NT(j,:)= interp1(linspace(0,1,length(CT)),CT,linspace(0,1,1000));
    end
    
    New_Theta{i} = reshape(NT.',1,[])';
end

A_Theta = cat(3, New_Theta{:});
D_P = mean(A_Theta, 3); 
save D_P0.05.mat D_P
