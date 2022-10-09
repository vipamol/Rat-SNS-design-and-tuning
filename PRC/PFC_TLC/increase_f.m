clear all
clc
to_plot = 1;

%% f = 1.6
% D = 0.8 -> DP = 0.789375
% Gw = 0.1140625  -> DP = 0.77625
%%
Gweak = 0.1140625;
D = 0;
G_syn = 1.62509765625;
PF_G =  1.61263427734375;
Gc = 0.01;

DP = 0.77625;

dt = 1; 
t_max = 20e3;

phase_to_track = 2.5;
num_phase = 100;
ramp_mag = [-0.5 0.5]; %nA <-------------------------------------------------------
% ramp_mag = -0.5; %nA <-------------------------------------------------------

% ext_stim = zeros(t_max/dt,8);
% f = @(x)f_D_TLC (D,x,Gweak,Gc,G_syn,PF_G,ext_stim,t_max,dt)-1.6;
% DP = bisect(f,0.77,0.78,1e-12,1e-12,1000);

RG_phase_shift = zeros(length(ramp_mag),num_phase);
phase_shift = zeros(length(ramp_mag),num_phase);

tic
    for n = 1:length(Gweak)
        Gw = Gweak; %uS
        % Get unperturbed CPG activities.
        ext_stim = zeros(t_max/dt,8);
        nstate = TLC(D,DP,Gw,Gc,G_syn,PF_G,ext_stim,t_max,dt);
        [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
        RG_frequency-frequency
        keyboard
        
        %  set up tracking time.
        acr = RG_step_start(2);
        sim_time = acr + round(phase_to_track*1000/RG_frequency);
        pd = 1000/(RG_frequency*num_phase);
        stim_time = round(50/RG_frequency); % 5% of oscillation period
        
        
        for i = 1: length(ramp_mag)
            rag = ramp_mag(i);
            parfor j = 1:num_phase
                sim_ext_stim = zeros(sim_time/dt,8);
                sim_ext_stim(acr+round(pd*(j-1)):acr+round(pd*(j-1))+stim_time,4) = rag;
                nstate = TLC(D,DP,Gw,Gc,G_syn,PF_G,sim_ext_stim,sim_time,dt);
                [~,RG_step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
                [~,step_start_new] = ff(nstate(1,:,5),nstate(1,:,6),dt);
                
                if j < (num_phase/2+1)
                    RG_phase_shift(i,j) = (RG_step_start(3)- RG_step_start_new(end-1))*RG_frequency/1000;
                    phase_shift(i,j) = (step_start(3)-step_start_new(end-1))*frequency/1000;
                else
                    RG_phase_shift(i,j) = (RG_step_start(4)- RG_step_start_new(end))*RG_frequency/1000;
                    phase_shift(i,j) = (step_start(4)-step_start_new(end))*frequency/1000;
                end
            end
            
        end
    end
toc
    
     if to_plot 
    
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
    end