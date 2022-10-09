clear all
clc

find_PF_G  = 0;
Pert_PF = 1;

%% Initializtion
Gweak = 0.01;
D = 0;
G_syn = 1.62509765625;

PF_G = 1.61263427734375;

Gc = 0.01:0.001:0.05;
% load('PF_G.mat')

dt = 1; 
t_max = 20e3;

phase_to_track = 2.5;
num_phase = 100;

ext_stim = zeros(t_max/dt,8);
ramp_mag = - 0.5; %nA <-------------------------------------------------------

%% find PG_G
if find_PF_G
%     tic
%     parfor i = 1:length(Gc)
%         PF_G(i) = find_G_PF(D,Gweak,Gc(i),G_syn,ext_stim,t_max,dt);
%     end
%     
%     save('PF_G.mat','PF_G')
%     toc
    
    parfor i = 1:length(Gc)
        T(i) = f_G_TLC (D,Gweak,Gc(i),G_syn,PF_G,ext_stim,t_max,dt);
    end
end

%%
% % Gc = [0.01 0.02 0.03 0.05 0.1];
% 
%  RG_phase_shift = zeros(length(Gc),num_phase);
% phase_shift = zeros(length(Gc),num_phase);
% % 
% if ~Pert_PF
%     
%     for i = 1:length(Gc)
%         Gw = Gweak; %uS
%         % Get unperturbed CPG activities.
%         ext_stim = zeros(t_max/dt,8);
%         nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,ext_stim,t_max,dt);
%         [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
%         [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
% %                 RG_frequency-frequency
% %                 keyboard
%         
%         % set up tracking time.
%         acr = RG_step_start(1);
%         sim_time = acr + round(phase_to_track*1000/RG_frequency);
%         pd = 1000/(RG_frequency*num_phase);
%         stim_time = round(50/RG_frequency); % 5% of oscillation period
%         
%         
%         % PRC of CPG
%         parfor j = 1:num_phase
%             sim_ext_stim = zeros(sim_time/dt,8);
%             sim_ext_stim(acr+round(pd*(j-1)):acr+round(pd*(j-1))+stim_time,4) = ramp_mag;
%             nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,sim_ext_stim,sim_time,dt);
%             [~,RG_step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
%             [~,step_start_new] = ff(nstate(1,:,5),nstate(1,:,6),dt);
%             
%             if j < (num_phase/2+1)
%                 RG_phase_shift(i,j) = ( RG_step_start(2)- RG_step_start_new(end-1))*RG_frequency/1000;
%                 phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
%             else
%                 RG_phase_shift(i,j) = (RG_step_start(3)- RG_step_start_new(end))*RG_frequency/1000;
%                 phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
%             end
%             
%         end
%         
% %         save(sprintf('RG_%d.mat',i),'RG_phase_shift','phase_shift')
%         
%     end
%     
%     save('RG_cone.mat','RG_phase_shift','phase_shift')
% else
%     
%     for i = 1:length(Gc)
%         Gw = Gweak; %uS
%         % Get unperturbed CPG activities.
%         ext_stim = zeros(t_max/dt,8);
%         nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,ext_stim,t_max,dt);
%         [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
%         [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
%         %         RG_frequency-frequency
%         %         keyboard
%         
%         % set up tracking time.
%         acr = RG_step_start(1);
%         sim_time = acr + round(phase_to_track*1000/RG_frequency);
%         pd = 1000/(RG_frequency*num_phase);
%         stim_time = round(50/RG_frequency); % 5% of oscillation period
%         
%         
%         % PRC of CPG
%         parfor j = 1:num_phase
%             sim_ext_stim = zeros(sim_time/dt,8);
%             sim_ext_stim(acr+round(pd*(j-1)):acr+round(pd*(j-1))+stim_time,8) = ramp_mag;
%             nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,sim_ext_stim,sim_time,dt);
%             [~,RG_step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
%             [~,step_start_new] = ff(nstate(1,:,5),nstate(1,:,6),dt);
%             
%             if j < (num_phase/2+1)
%                 RG_phase_shift(i,j) = ( RG_step_start(2)- RG_step_start_new(end-1))*RG_frequency/1000;
%                 phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
%             else
%                 RG_phase_shift(i,j) = (RG_step_start(3)- RG_step_start_new(end))*RG_frequency/1000;
%                 phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
%             end
%             
%         end
%         
% %         save(sprintf('PF_%d.mat',i),'RG_phase_shift','phase_shift')
%         
%     end
%     save('PF_cone.mat','RG_phase_shift','phase_shift')
% end

%% more combineation 
Gc = 0.01:0.01:0.05;
ramp_mag = -[0.05 0.1 0.15 0.2 0.25]*1;

RG_phase_shift = zeros(length(Gc),num_phase);
phase_shift = zeros(length(Gc),num_phase);

tic
if ~Pert_PF
    
    for i = 1:length(Gc)
        Gw = Gweak; %uS
        % Get unperturbed CPG activities.
        ext_stim = zeros(t_max/dt,8);
        nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,ext_stim,t_max,dt);
        [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
        
        % set up tracking time.
        acr = RG_step_start(1);
        sim_time = acr + round(phase_to_track*1000/RG_frequency);
        pd = 1000/(RG_frequency*num_phase);
        stim_time = round(50/RG_frequency); % 5% of oscillation period
        
        
        % PRC of CPG
        parfor j = 1:num_phase
            sim_ext_stim = zeros(sim_time/dt,8);
            sim_ext_stim(acr+round(pd*(j-1)):acr+round(pd*(j-1))+stim_time,4) = ramp_mag(i);
            nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,sim_ext_stim,sim_time,dt);
            [~,RG_step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
            [~,step_start_new] = ff(nstate(1,:,5),nstate(1,:,6),dt);
            
            if j < (num_phase/2+1)
                RG_phase_shift(i,j) = ( RG_step_start(2)- RG_step_start_new(end-1))*RG_frequency/1000;
                phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
            else
                RG_phase_shift(i,j) = (RG_step_start(3)- RG_step_start_new(end))*RG_frequency/1000;
                phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
            end
            
        end
                
    end
    save('RG_r5.mat','RG_phase_shift','phase_shift')
    
else
    
    for i = 1:length(Gc)
        Gw = Gweak; %uS
        % Get unperturbed CPG activities.
        ext_stim = zeros(t_max/dt,8);
        nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,ext_stim,t_max,dt);
        [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
        
        % set up tracking time.
        acr = RG_step_start(1);
        sim_time = acr + round(phase_to_track*1000/RG_frequency);
        pd = 1000/(RG_frequency*num_phase);
        stim_time = round(50/RG_frequency); % 5% of oscillation period
        
        
        % PRC of CPG
        parfor j = 1:num_phase
            sim_ext_stim = zeros(sim_time/dt,8);
            sim_ext_stim(acr+round(pd*(j-1)):acr+round(pd*(j-1))+stim_time,8) = ramp_mag(i);
            nstate = f_TLC (D,Gw,Gc(i),G_syn,PF_G,sim_ext_stim,sim_time,dt);
            [~,RG_step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
            [~,step_start_new] = ff(nstate(1,:,5),nstate(1,:,6),dt);
            
            if j < (num_phase/2+1)
                RG_phase_shift(i,j) = ( RG_step_start(2)- RG_step_start_new(end-1))*RG_frequency/1000;
                phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
            else
                RG_phase_shift(i,j) = (RG_step_start(3)- RG_step_start_new(end))*RG_frequency/1000;
                phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
            end
            
        end
                
    end
    save('PF_r5.mat','RG_phase_shift','phase_shift') 
end
toc
