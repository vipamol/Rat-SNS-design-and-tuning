clear all
clc

D = 0;
Gweak = 0.01; 
G_syn = 1.62509765625;
PF_G =  1.61263427734375;
Gc = 0.01;

%%% Initiation
dt = 1;
t_max = 20e3;

phase_to_track = 12;
num_phase = 100;
ramp_mag = - 0.5; %nA

RG_T = zeros(num_phase,phase_to_track);
PF_T = zeros(num_phase,phase_to_track);

tic
for i = 1:length(Gweak)
    Gw = Gweak(i); %uS
    
    % Get unperturbed CPG activities.
    ext_stim = zeros(t_max/dt,8);
    nstate = f_TLC(D,Gw,Gc,G_syn,PF_G,ext_stim,t_max,dt);
    [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
    [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
    
    % set up tracking time.
    acr = RG_step_start(1);
    sim_time = acr + round((phase_to_track+0.5)*1000/frequency);
    pd = 1000/(frequency*num_phase);
    stim_time = round(50/frequency); % 5% of oscillation period
    

    % PRC of CPG
   parfor j = 1:num_phase
        sim_ext_stim = zeros(sim_time/dt,8);
        sim_ext_stim(acr+round(pd*(j-1)):acr+round(pd*(j-1))+stim_time,4) = ramp_mag;
        nstate = f_TLC (D,Gw,Gc,G_syn,PF_G,sim_ext_stim,sim_time,dt);
        [~,RG_step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        [~,step_start_new] = ff(nstate(1,:,5),nstate(1,:,6),dt);
        
        RG_T(j,:) = diff(RG_step_start_new);
        PF_T(j,:) = diff(step_start_new);
    end

end
toc
