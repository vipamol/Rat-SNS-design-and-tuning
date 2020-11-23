%excitation
k = 0.3;
Connectivity('trans',0.3);
keyboard

%Inhibitation
k = -0.1;
Connectivity('trans',-0.1);
keyboard

%Addition
k = [0.3, 0.15];
Connectivity('add',[0.3, 0.15]);
keyboard

%Subtraction
k = [0.3, -0.1];
Connectivity('sub',[0.3, -0.1]);
keyboard

