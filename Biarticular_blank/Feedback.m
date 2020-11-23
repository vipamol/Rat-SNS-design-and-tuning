clear all
clc
 
A = importdata('Angle.txt');
Angle = A.data;

B = importdata('Ia.txt');
Ia = B.data;

C = importdata('Ib.txt');
Ib = C.data;

D = importdata('II.txt');
II = D.data;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Angle = Angle(5902:11669,:);
Ia = Ia(5902:11669,:);
Ib = Ib(5902:11669,:);
II = II(5902:11669,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_of_samples = 100;
current_size = size(Angle,1);

Angle = interp1(linspace(0,1,current_size),Angle,linspace(0,1,num_of_samples));
Ia = interp1(linspace(0,1,current_size),Ia,linspace(0,1,num_of_samples));
Ib = interp1(linspace(0,1,current_size),Ib,linspace(0,1,num_of_samples));
II = interp1(linspace(0,1,current_size),II,linspace(0,1,num_of_samples));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%MN = {'BFA','BFP','GA','IP','RF','SO','TA','VA'};
MN = {'BFA','BFP','VA','GA','TA','SO','IP','RF'};

figure (1)
Ia = Ia(:,[1 2 3 9 4 8 7 5 6]);
for i = 1:8
    subplot(2,4,i)
    plot(Ia(:,i+1),'Linewidth',1.5)
    title(MN{i},'FontSize',9)
end
set(gcf,'Position',[200 100 1200 500])
suptitle('Ia feedback during walking')

figure (2)
for i = 1:8
    subplot(2,4,i)
    plot(Ib(:,i+1),'Linewidth',1.5)
    title(MN{i},'FontSize',9)
end
set(gcf,'Position',[200 100 1200 500])
suptitle('Ib feedback during walking')

figure (3)
II = II(:,[1 2 3 9 4 8 7 5 6]);
for i = 1:8
    subplot(2,4,i)
    plot(II(:,i+1),'Linewidth',1.5)
    title(MN{i},'FontSize',9)
end
set(gcf,'Position',[200 100 1200 500])
suptitle('PE length(II feedback) during walking')