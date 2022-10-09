clear all
clc

find_PF_G = 0;
design_Gc = 0;
to_plot = 1;

%% Notes
old_f = 0;
if old_f 
% Gw = [0.01 0.05 0.01]--> [1.607433378112091 1.579519448682277 1.607433378112091];

% Gc = [0.01 0.1 1]; -->[1.607433378112091 1.5642578125 1.522544145070697]
% Gw = 0.05; Gsyn = 1.648531494140625; PF_G = 1.607447173254695

% D = [0.1 0.5] --> [1.598535156250000 1.562010203244062] % Gw = 0.01
% D = [1 2] --> [1.514405147354774 1.4171875] % Gw = 0.01

% Gw = 0.01; D = 1; PF_G = 1.459113278304358; Gc = 0.1;

% Gw = [0.01 0.29165 0.01] --> [1.607433378112091 1.419140625 1.607433378112091];
% G_syn = [1.619783 1.479335 1.619783] --> [1.614562988281250  1.475201522633506 1.614562988281250]
% D = [0.1 0.5 0.1] --> [1.605720969530740 1.569625 1.605720969530740]
% D = [0.1 2.19575 0.1] --> [1.605720969530740 1.406779082410139 1.605720969530740]
end

% Gc = [0.01 0.1 1]; -->1.61263427734375;
% Gw = 0.1 -> 1.61265; D = 1 -> 1.61025;   f = 1 Hz

% f = 1.6 Hz 
% Gw -> 1.541   D->1.5395   //  Gc = 0.1 Gw->1.5025  D->

% f = 2 Hz 
% Gw -> 1.4582   D->1.456 //  Gc = 0.1 Gw->1.4225  D->
%% Initializtion
Gweak = 0.01;
D = 1.6628;
% D = [1 1 2 2];
G_syn = 1.62509765625;
PF_G =  1.4;
Gc = 0.1;

dt = 1; 
t_max = 20e3;

phase_to_track = 2.5;
num_phase = 100;
% ramp_mag = [-0.5 0.5]; %nA <-------------------------------------------------------
ramp_mag = -0.5; %nA <-------------------------------------------------------

tic
if ~find_PF_G 
    G = PF_G;
else
    ext_stim = zeros(t_max/dt,8);
%     [Gw,~,indices] = unique(Gweak);
%     [Gsyn,~,indices] = unique(G_syn);
%     [D,~,indices] = unique(D);
    for i = length(Gc)
%         PF_G(i) = find_G_PF(D,Gw(i),Gc,G_syn,ext_stim,t_max,dt);
%         PF_G(i) = find_G_PF(D,Gweak,Gc,Gsyn(i),ext_stim,t_max,dt);
%         PF_G(i) = find_G_PF(D(i),Gweak,Gc,G_syn,ext_stim,t_max,dt);
        PF_G(i) = find_G_PF(D,Gweak,Gc(i),G_syn,ext_stim,t_max,dt);
    end
%     G = PF_G(indices);
end

if ~design_Gc
    
    RG_phase_shift = zeros(length(Gweak),num_phase);
    phase_shift = zeros(length(Gweak),num_phase);
    
    for i = 1:length(D)
        Gw = Gweak; %uS
        % Get unperturbed CPG activities.
        ext_stim = zeros(t_max/dt,8);
        nstate = f_TLC (D(i),Gw,Gc,G_syn,G(i),ext_stim,t_max,dt);
        [RG_frequency,RG_step_start] = ff(nstate(1,:,1),nstate(1,:,2),dt);
        [frequency,step_start] = ff(nstate(1,:,5),nstate(1,:,6),dt);
        RG_frequency-frequency
        keyboard
        
        % set up tracking time.
        acr = RG_step_start(1);
        sim_time = acr + round(phase_to_track*1000/RG_frequency);
        pd = 1000/(RG_frequency*num_phase);
        stim_time = round(50/RG_frequency); % 5% of oscillation period
        
        
        % PRC of CPG
        for j = 1:num_phase
            sim_ext_stim = zeros(sim_time/dt,8);
            sim_ext_stim(acr+round(pd*(j-1)):acr+round(pd*(j-1))+stim_time,4) = ramp_mag(i);
            nstate = f_TLC (D(i),Gw,Gc,G_syn,G(i),sim_ext_stim,sim_time,dt);
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
    
%     RG_phase_shift(RG_phase_shift>0.5) = RG_phase_shift(RG_phase_shift>0.5)-1;
%     RG_phase_shift(RG_phase_shift<-0.5) = RG_phase_shift(RG_phase_shift<-0.5)+1;
%     phase_shift(phase_shift>0.5) = phase_shift(phase_shift>0.5)-1;
%     phase_shift(phase_shift<-0.5) = phase_shift(phase_shift<-0.5)+1;
    % save('RG_0.05_in.mat','RG_phase_shift','phase_shift')
    
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
    
else
    
    RG_phase_shift = zeros(length(ramp_mag),num_phase);
    phase_shift = zeros(length(ramp_mag),num_phase);
    
    for n = 1:length(Gweak)
        Gw = Gweak; %uS
        % Get unperturbed CPG activities.
        ext_stim = zeros(t_max/dt,8);
        nstate = f_TLC (D,Gw,Gc,G_syn,G,ext_stim,t_max,dt);
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
                nstate = f_TLC (D,Gw,Gc,G_syn,G,sim_ext_stim,sim_time,dt);
                [~,RG_step_start_new] = ff(nstate(1,:,1),nstate(1,:,2),dt);
                [~,step_start_new] = ff(nstate(1,:,5),nstate(1,:,6),dt);
                
                if j < (num_phase/2+1)
                    RG_phase_shift(i,j) = ( RG_step_start(3)- RG_step_start_new(end-1))*RG_frequency/1000;
                    phase_shift(i,j) = (step_start(3)-step_start_new(end-1))*frequency/1000;
                else
                    RG_phase_shift(i,j) = (RG_step_start(4)- RG_step_start_new(end))*RG_frequency/1000;
                    phase_shift(i,j) = (step_start(4)-step_start_new(end))*frequency/1000;
                end
            end
            
        end
    end
    
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
    
    
end
toc