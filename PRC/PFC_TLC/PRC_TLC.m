clear all
clc

%% Initializtion
% Gweak = [0.01 0.29165 0.01];
Gweak = 0.01;
D = 0;
G_syn = 1.619783;
Gc = 0.01;

dt = 1; 
t_max = 20e3;

phase_to_track = 2.5;
num_phase = 100;
% ramp_mag = -[1 1 0.5]; %nA <-------------------------------------------------------
ramp_mag = - 1; %nA <-------------------------------------------------------

RG_phase_shift = zeros(length(Gweak),num_phase);
phase_shift = zeros(length(Gweak),num_phase);

for i = 1:length(Gweak)
    Gw = Gweak(i); %uS
    % Get unperturbed CPG activities.
    ext_stim = zeros(t_max/dt,8);
    nstate = TLC(D,Gw,Gc,G_syn,ext_stim,t_max,dt);
    [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
    [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
    
    % set up tracking time.
    acr = RG_step_start(1);
    sim_time = acr + round(phase_to_track*1000/RG_frequency);
    pd = round(1000/(RG_frequency*num_phase));
    stim_time = round(50/RG_frequency); % 5% of oscillation period
    
    % PRC of CPG
    for j = 1:num_phase
        sim_ext_stim = zeros(sim_time/dt,8);
        sim_ext_stim(acr+pd*(j-1):acr+pd*(j-1)+stim_time,4) = ramp_mag(i);
        nstate = TLC (D,Gw,Gc,G_syn,sim_ext_stim,sim_time,dt);
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

RG_phase_shift(RG_phase_shift>0.5) = RG_phase_shift(RG_phase_shift>0.5)-1;
RG_phase_shift(RG_phase_shift<-0.5) = RG_phase_shift(RG_phase_shift<-0.5)+1;
phase_shift(phase_shift>0.5) = phase_shift(phase_shift>0.5)-1;
phase_shift(phase_shift<-0.5) = phase_shift(phase_shift<-0.5)+1;
% save('RG_0.05_in.mat','RG_phase_shift','phase_shift')

figure(1)
subplot(2,1,1)
hold on
plot((0:num_phase-1)/num_phase,RG_phase_shift,'LineWidth',1)
plot((0:num_phase-1)/num_phase,phase_shift,':','LineWidth',2)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase response curve of the system','Fontsize',12)


subplot(2,1,2)
hold on
plot((0:num_phase-1)/num_phase,RG_phase_shift-phase_shift,'LineWidth',1)
grid on
ylim([-0.5 0.5])
xlabel('\phi, normalized phase of stimulus')
ylabel('normalized phase advancement')
title('Phase shifts difference between the two layers','Fontsize',12)

col = [0, 0.4470, 0.7410;0.8500, 0.3250, 0.0980;0.4940, 0.1840, 0.5560];
colororder(col)
set(gcf,'Position',[500 200 600 500])
