clear all
clc

dt = 0.00005;

%% load unperturbed data (10 sets)

files = dir('*.txt');

for i=1:length(files)
    Theta{i} = importdata(files(i).name).data(:,2);
    [~,ind_G{i}] = findpeaks(-Theta{i},'MinPeakProminence',0.1);
    
    for j = 1:length(ind_G{i})-1
        st =ind_G{i}(j);et = ind_G{i}(j+1)-1;
        CT = Theta{i}(st:et);
        NT(j,:)= interp1(linspace(0,1,length(CT)),CT,linspace(0,1,1000));
    end
    
    New_Theta{i} = reshape(NT.',1,[])';
    int(i) = ind_G{i}(1);
end

A_Theta = cat(3, New_Theta{:});
G_N = mean(A_Theta, 3); 

save G_N.mat G_N
D_int = mean(int)*dt;
D_arc = 2+ D_int + 0.5;
D_et = D_arc + 0.5;