clear all
clc

load('muscle.mat')
load('RL.mat')

num = length(muscle_name);
for i = 1:num
    muscle_name{i} = strrep(muscle_name{i},'LH_','');
end
step = length(muscle_length{1});
Ia = cell(num,1);
Ia_RL = Ia;

for i = 1: num
    for j = 1:step
        
        if muscle_velocity{i}(j)> 0 
            sign = 1;
        else
            sign = -1;
        end
        
        Ia{i}(j,1) =4.3*sign*abs(muscle_velocity{i}(j)*1000)^0.6+2*muscle_length{i}(j)*1000;
    end
end


for i = 1: num
    for j = 1:step
        
        if muscle_velocity{i}(j)> 0 
            sign = 1;
        else
            sign = -1;
        end
        
        Ia_RL{i}(j,1) =65*sign*abs(muscle_velocity{i}(j)/RL{i})^0.5+200*muscle_length{i}(j)/RL{i};
    end
end

figure (1)
for i = 1:8
    subplot(2,4,i)
    plot(Ia{i},'Linewidth',1.5)
    title(muscle_name{i},'FontSize',9)
end
set(gcf,'Position',[200 100 1200 500])
suptitle('Ia firing rate during walking')

figure (2)
for i = 1:8
    subplot(2,4,i)
    plot(Ia_RL{i},'Linewidth',1.5)
    title(muscle_name{i},'FontSize',9)
end
set(gcf,'Position',[200 100 1200 500])
suptitle('Ia firing rate during walking (RL)')
