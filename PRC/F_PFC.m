clear all
clc
%% For a same frequency; 
%f = 0.9617 --> 0.961743962

% Gw = 0;
% D = 0;G = 1.619783; 
% D = 2; G = 1.77517; 
% D = 4; G = 1.9003; 
% D = 6; G = 2.009795; 

% G = 1.9; D = 3.9948;
% G = 2; D = 5.8157; 

% D = 0; G = 2; Gw = 0.56913; 
% D = 0; G = 1.9; Gw = 0.410011;
% D = 0; G = 1.7; Gw = 0.11188;
% D = 0; G = 2.3; Gw = 1.08568;


% f = 1.135 --> 1.113526698
% D = 0; Gw = 0; G = 1.610085;
% D = 6.0152; G = 2; Gw = 0;
% D = 0; G = 2; Gw = 0.59;
% D = 2.09001; G = 2; Gw =0.3;
% D = 4.37185; G =2 ;Gw =0.1;

% f = 1.9235 --> 1.923487924
% Gw = 0; D = 0; G = 1.479335;
%% Test
% Gw = 0.01; D = 0; G = 1.619783; %f = 1.0818 --> 1.081805069029466
% Gw = 0.05; D = 0; G = 1.648531494140625; %f = 1.0818 --> 1.081805069029466
% Gw = 0.29165; D = 0; G = 1.619783; %f = 2.1636 --> 2.163610138058933


D = 2;  Gw = 0; G = 1.773183441162110;

%%% Initiation
dt = 1;
t_max = 20e3;

phase_to_track = 2.5;
num_phase = 100;
ramp_mag = -1; %nA

phase_shift = zeros(length(G),num_phase);

for i = 1:length(G)
    G_syn = G(i); %uS
    
    % Get unperturbed CPG activities.
    ext_stim = zeros(t_max/dt,4);
    nstate = HC(D,Gw,G_syn,ext_stim,t_max,dt);
    [frequency,step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
    keyboard
    
    % set up tracking time.
    acr = step_start(1);
    sim_time = acr + round(phase_to_track*1000/frequency);
    pd = round(1000/(frequency*num_phase));
    stim_time = round(50/frequency); % 5% of oscillation period
    
    % PRC of CPG
    for j = 1:num_phase
        sim_ext_stim = zeros(sim_time/dt,4);
        sim_ext_stim(acr+pd*(j-1):acr+pd*(j-1)+stim_time,4) = ramp_mag;
        nstate = HC(D,Gw,G_syn,sim_ext_stim,sim_time,dt);
        [~,step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        
        if j < (num_phase/2+1)
            phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
        else
            phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
        end
    end

end

figure(2)
hold on
plot((0:num_phase-1)/num_phase,phase_shift)
grid on
ylim([-0.5 0.5])
set(gcf,'Position',[500 200 600 300])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')

