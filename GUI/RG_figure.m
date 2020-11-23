clear all
clc

% Position
x = 1;
y = 2;
w = 0.6;
h = 0.4;
d = 1;

% Neurons
rectangle('Position',[x y w h],'FaceColor','r','Curvature',1);% RG E
rectangle('Position',[x+1.5*d y w h],'FaceColor','b','Curvature',1);% RG F
rectangle('Position',[x y+d w h],'FaceColor','c','Curvature',1);% RG E IN
rectangle('Position',[x+1.5*d y+d w h],'FaceColor','c','Curvature',1);% RG F IN

% Synapses
line ([x+w/2 x+w/2],[y+h y+d],'color','k');% RG E -> RG E IN
line ([x+1.5*d+w/2 x+1.5*d+w/2],[y+h y+d],'color','k');% RG F -> RG F IN
line ([x+w x+1.5*d+w/5],[y+d+h/4 y+h],'color','k');% RG E IN -> RG F
line ([x+1.5*d x+4/5*w],[y+d+h/4 y+h],'color','k');% RG F IN -> RG E

line ([x+w x+0.75*d+w/2],[y+2/3*h y+h],'LineStyle',':','color','k');
line ([x+0.75*d+w/2 x+1.5*d],[y+h y+2/3*h],'LineStyle',':','color','k');

line ([x+w x+0.75*d+w/2],[y+h/3 y],'LineStyle',':','color','k');
line ([x+0.75*d+w/2 x+1.5*d],[y y+h/3],'LineStyle',':','color','k');

hold on 

% Synapse symbol
plot(x+1.5*d+w/5,y+h,'.','color','k','MarkerSize',20);
plot(x+4/5*w,y+h,'.','color','k','MarkerSize',20);
plot(x+w/2,y+d,'*','color','k','MarkerSize',6);
plot(x+1.5*d,y+2/3*h,'*','color','k','MarkerSize',6);
plot(x+w,y+h/3,'*','color','k','MarkerSize',6);

xlim([0 4])
ylim([0 4])
axis equal