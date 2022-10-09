function [ ] = plotBarStackGroups(stackData, groupLabels)
%% Plot a set of stacked bars, but group them according to labels provided.
%%
%% Params: 
%%      stackData is a 3D matrix (i.e., stackData(i, j, k) => (Group, Stack, StackElement)) 
%%      groupLabels is a CELL type (i.e., { 'a', 1 , 20, 'because' };)
%%
%% Copyright 2011 Evan Bollig (bollig at scs DOT fsu ANOTHERDOT edu
%%
%% 
NumGroupsPerAxis = size(stackData, 1);
NumStacksPerGroup = size(stackData, 2);


% Count off the number of bins
% groupBins = 1:NumGroupsPerAxis;
groupBins = [1 2 3.3];
MaxGroupWidth = 0.5; % Fraction of 1. If 1, then we have all bars in groups touching
groupOffset = MaxGroupWidth/NumStacksPerGroup;
figure
    hold on; 
for i=1:NumStacksPerGroup

    Y = squeeze(stackData(:,:,i));
    
    % Center the bars:
    
    internalPosCount = i - ((NumStacksPerGroup+1) / 2);
    
    % Offset the group draw positions:
    groupDrawPos = (internalPosCount)* groupOffset + groupBins;
    
    h(i,:) = bar(Y, 'stacked','ShowBaseLine', 'off');
     set(h(i,:),'BarWidth',groupOffset);
    set(h(i,:),'XData',groupDrawPos);
end
hold off;

ax = gca;
ax.FontSize = 14; 

set(gca,'XTickMode','manual');
% set(gca,'XTick',1:NumGroupsPerAxis);
set(gca,'XTick',[0.9 2 3.3]);
set(gca,'XTickLabelMode','manual');
set(gca,'XTickLabel',groupLabels);
set(gcf,'Position',[500 200 800 300])
end 
