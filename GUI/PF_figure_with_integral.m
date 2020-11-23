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


%% Intergral layer
% Neurons
rectangle('Position',[x y-d w h],'FaceColor','c','Curvature',1);% Ia E IN
rectangle('Position',[x+1.5*d y-d w h],'FaceColor','c','Curvature',1);% Ia E IN
rectangle('Position',[x y-2*d w h],'FaceColor','y','Curvature',1);% MN E
rectangle('Position',[x+1.5*d y-2*d w h],'FaceColor','y','Curvature',1);% MN F
rectangle('Position',[x y-3*d w h],'FaceColor','c','Curvature',1);% RE E 
rectangle('Position',[x+1.5*d y-3*d w h],'FaceColor','c','Curvature',1);% RE F

% Synapses
line ([x+w/2 x+w/2],[y y-d+h],'color','k');% PF E -> Ia E IN
line ([x+1.5*d+w/2 x+1.5*d+w/2],[y y-d+h],'color','k');% PF E -> Ia F IN
line ([x+w x+1.5*d],[y-d+h/2 y-d+h/2],'color','k');% Ia E IN ->Ia F IN
line ([x+w x+0.75*d+w/2],[y-d+2/3*h y-d+h],'color','k');
line ([x+0.75*d+w/2 x+1.5*d],[y-d+h y-d+2/3*h],'color','k');% Ia F IN ->Ia E IN
line ([x+w x+1.5*d],[y-d+h/3 y-2*d+3/4*h],'color','k');% Ia E IN ->MN F
line ([x+1.5*d x+w],[y-d+h/3 y-2*d+3/4*h],'color','k');% Ia F IN ->MN E
line ([x+w/2 x+w/2],[y-2*d y-3*d+h],'color','k');% MN E -> RE E
line ([x+1.5*d+w/2 x+1.5*d+w/2],[y-2*d y-3*d+h],'color','k');% MN E -> RE E
line ([x+w x+0.75*d+w/2],[y-3*d+2/3*h y-3*d+h],'color','k');
line ([x+0.75*d+w/2 x+1.5*d],[y-3*d+h y-3*d+2/3*h],'color','k');% RE E ->RE F
line ([x+w x+0.75*d+w/2],[y-3*d+h/3 y-3*d],'color','k');
line ([x+0.75*d+w/2 x+1.5*d],[y-3*d y-3*d+h/3],'color','k');% RE F ->RE E

line ([x x-d],[y-3*d+2/3*h y-2*d+h/2],'color','k');
line ([x-d x],[y-2*d+h/2 y-d+h/3],'color','k');% RE E ->Ia E IN

line ([x+1.5*d+w x+2.5*d+w],[y-3*d+2/3*h y-2*d+h/2],'color','k');
line ([x+2.5*d+w x+1.5*d+w],[y-2*d+h/2 y-d+h/3],'color','k');% RE F ->Ia F IN

line ([x+w x+1.5*w],[y+h/2 y+h/2],'color','k');% PF E -> MN E
line ([x+1.5*w x+1.5*w],[y+h/2  y-2*d+h/2],'color','k');
line ([x+w x+1.5*w],[y-2*d+h/2 y-2*d+h/2],'color','k');

line ([x+1.5*d x+1.5*d-w/2],[y+h/2 y+h/2],'color','k');% PF F -> MN F
line ([x+1.5*d-w/2 x+1.5*d-w/2],[y+h/2  y-2*d+h/2],'color','k');
line ([x+1.5*d x+1.5*d-w/2],[y-2*d+h/2 y-2*d+h/2],'color','k');

% Synapse symbol
plot(x+w/2,y-d+h,'*','color','k','MarkerSize',6); 
plot(x+1.5*d+w/2,y-d+h,'*','color','k','MarkerSize',6); 
plot(x+w,y-2*d+h/2,'*','color','k','MarkerSize',6); 
plot(x+1.5*d,y-2*d+h/2,'*','color','k','MarkerSize',6); 
plot(x+w/2,y-3*d+h,'*','color','k','MarkerSize',6); 
plot(x+1.5*d+w/2,y-3*d+h,'*','color','k','MarkerSize',6); 
plot(x+1.5*d,y-d+h/2,'.','color','k','MarkerSize',15);
plot(x+w,y-d+2/3*h,'.','color','k','MarkerSize',15);
plot(x+1.5*d,y-2*d+3/4*h,'.','color','k','MarkerSize',15);
plot(x+w,y-2*d+3/4*h,'.','color','k','MarkerSize',15);
plot(x+1.5*d,y-3*d+2/3*h,'.','color','k','MarkerSize',15);
plot(x,y-d+h/3,'.','color','k','MarkerSize',15);
plot(x+1.5*d+w,y-d+h/3,'.','color','k','MarkerSize',15);

xlim([0 4])
ylim([-2 4])
axis equal