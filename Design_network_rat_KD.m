clear workspace
close all
clc

%Decide whether to load a previously made network or design a new one.
%0- Do Nothing
%1- Clear out all network information and make a new one
%2- Load in an neural network file based on AniLoc described below

desgin_net = 1;

%The project file and data of which your Animatlab Animal is being trained.
%  proj_file = 'C:\Users\vipamol\Desktop\Rat network design and tuning\Biarticular_net\Biarticular_net.aproj';

proj_file = 'C:\Users\vipamol\Desktop\Rat network design and tuning\Biarticular_blank\Biarticular_blank.aproj';
% proj_file = 'C:\Users\vipamol\Desktop\Rat network design and tuning\FullMuscle\FullMuscle.aproj';


Data_file = 'C:\Users\vipamol\Desktop\Rat network design and tuning\MN_activation.mat';

if desgin_net == 1
    organism_name = 'rat';
    legs = {'LH'};
    mirrored = [];
    
    % Swith D|M from two types of synapse connectivity,
    % 1 -- load the current synaptics from animatlab
    % 2 -- use embeded synaptics to construct
    Design_method = 1; 
    
    Net = Neural_controller(proj_file,organism_name,legs,mirrored);
    Net.design_SNS(Design_method);
end