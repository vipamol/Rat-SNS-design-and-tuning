clear all
clc

%% Setting cases

Gw = 0;

% % No drive situation
% D = 0;
% G_syn = 1.5711; % delta = 0.1

% % With drive situation
% D = 6;
% G_syn = 1.9992;

% % Tuning the drive
% D = 6.0144;% delta = 0.1
% G_syn = 2; 

% Tuning the drive
Gw = 0.6296;% delta = 0.1
D = 0;% delta = 0.1
G_syn = 2; 

%% Simulation
%%% Initiation
dt = 1;
t_max = 20e3;

phase_to_track = 2.5;
num_phase = 100;

% Get unperturbed CPG activities.
ext_stim = zeros(t_max/dt,4);
nstate = HC(D,Gw,G_syn,ext_stim,t_max,dt);
[frequency,step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);

% set up tracking time.
acr = step_start(1);
sim_time = acr + round(phase_to_track*1000/frequency);
pd = round(1000/(frequency*num_phase));
stim_time = round(50/frequency); % 5% of oscillation period

% ramp_mag = 0:0.1:5; %nA
ramp_mag =0:-0.1:-5;%nA

phase_shift = zeros(length(ramp_mag),num_phase);

parfor i = 1:length(ramp_mag)
    % PRC of CPG
    for j = 1:num_phase
        sim_ext_stim = zeros(sim_time/dt,4);
        sim_ext_stim(acr+pd*(j-1):acr+pd*(j-1)+stim_time,4) = ramp_mag(i);
        nstate = HC(D,Gw,G_syn,sim_ext_stim,sim_time,dt);
        [~,step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        
%         if ~(size(step_start_new)==3)
%             keyboard
%         end
        
        if j < (num_phase/2+1)
            phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
        else
            phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
        end
        
    end
end

disp('Simulation done.')

figure(1)
[X,Y] = meshgrid((0:num_phase-1)/num_phase,ramp_mag);
surf(X,Y,phase_shift)
colorbar

xlabel('\phi, normalized phase of stimulus')
ylabel('stimulus (nA)')
zlabel('normalized phase advancement')