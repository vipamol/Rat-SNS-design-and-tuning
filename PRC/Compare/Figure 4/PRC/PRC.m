clear all
clc
%%
G = 2;
load ('delta_0.1.mat')
p = 16;

D = D1(1,p); Gw = D1(2,p);

%%% Initiation
dt = 1;
t_max = 5e3;

phase_to_track = 2.5;
num_phase = 100;
ramp_mag = - 0.5; %nA

phase_shift = zeros(length(G),num_phase);

for i = 1:length(G)
    G_syn = G(i); %uS
    
    % Get unperturbed CPG activities.
    ext_stim = zeros(t_max/dt,4);
    nstate = HC(D,Gw,G_syn,ext_stim,t_max,dt);
    [frequency,step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
    
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
        
%         if ~(size(step_start_new)==3)
%             keyboard
%         end
        
        if j < (num_phase/2+1)
            phase_shift(i,j) = (step_start(2)-step_start_new(end-1))*frequency/1000;
        else
            phase_shift(i,j) = (step_start(3)-step_start_new(end))*frequency/1000;
        end
%             figure(1)
%             hold on
%             plot(nstate(1,acr:acr+round(1000/frequency),2));
%             keyboard
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