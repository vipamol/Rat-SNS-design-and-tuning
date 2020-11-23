clear all
clc

% Position
x = 1;
y = 2;
w = 0.6;
h = 0.4;
d = 1;

% Neurons
rectangle('Position',[x y w h],'FaceColor','r','Curvature',1);% PF E
rectangle('Position',[x+1.5*d y w h],'FaceColor','b','Curvature',1);% PF F
rectangle('Position',[x y+d w h],'FaceColor','c','Curvature',1);% PF E IN
rectangle('Position',[x+1.5*d y+d w h],'FaceColor','c','Curvature',1);% PF F IN

% Synapses
line ([x+w/2 x+w/2],[y+h y+d],'color','k');% PF E -> PF E IN
line ([x+1.5*d+w/2 x+1.5*d+w/2],[y+h y+d],'color','k'); % PF F -> PF F IN
line ([x+w x+1.5*d+w/5],[y+d+h/4 y+h],'color','k');% PF E IN -> PF F
line ([x+1.5*d x+4/5*w],[y+d+h/4 y+h],'color','k');% PF F IN -> PF E

hold on 

% Synapse symbol
plot(x+1.5*d+w/5,y+h,'.','color','k','MarkerSize',20); 
plot(x+4/5*w,y+h,'.','color','k','MarkerSize',20);
plot(x+w/2,y+d,'*','color','k','MarkerSize',6);
plot(x+1.5*d+w/2,y+d,'*','color','k','MarkerSize',6);


xlim([0 4])
ylim([0 4])
axis equal