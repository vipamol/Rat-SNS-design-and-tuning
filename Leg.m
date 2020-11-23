classdef Leg < matlab.mixin.SetGet
    
      properties
          proj_file; %project file
          original_text; %content of the .asim file
          organism_name; %name of the organism in the simulation file that we are interested in
          leg_name;  %name of the leg in the simulation file that we are interested in
          
          neur_inds;
          neur_obj;%cell array of neuron objects (for each neuron in the leg)
          syn_inds;
          syn_obj;%cell array of synpases objects (for each synpases in the leg)
          
          CPG_connects
      end
      
       properties (Access = private)       
        %These are formatted to match AnimatLab, and should never be
        %changed either by this program or the user.
        animatlab_properties = {%neuron
                                {   'TonicStimulus',-1e-06,1e-06,'TonicStimulus',1e-9;...
                                    'RestingPot',-100e-3,100e-3,'RestingPotential',1e-3;...
                                    'Size',1e-06,100,'RelativeSize',1;...
                                    'TimeConst',1e-5,10,'TimeConstant',1e-3;...
                                    'GMaxCa',0,100e-6,'MaxCaConductance Value',1e-6;...
                                    'mMidPoint',-0.2,0.2,'Midpoint Value',1e-3;...
                                    'mSlope',0.010,10,'Slope Value',1;...
                                    'mTimeConstant',0.001,100,'TimeConstant Value',1e-3;...
                                    'hMidPoint',-0.2,0.2,'Midpoint Value',1e-3;...
                                    'hSlope',0.010,10,'Slope Value',1;...
                                    'hTimeConstant',0.001,100,'TimeConstant Value',1e-3;...
                                    'InitialThresh',-100e-3,100e-3,'InitialThreshold Value',1e-3;...
                                    'RelativeAccom',0,1,'RelativeAccomodation Value',1;...
                                    'AccomTimeConst',1e-3,1,'AccomodationTimeConstant Value',1e-3;...
                                    'AHPAmp',0,100e-6,'AHP_Conductance Value',1e-6;...
                                    'AHPTimeConst',1e-3,100e-3,'AHP_TimeConstant Value',1e-3};...
                                %nonspikingsynapse    
                                {   'Equil',-0.1,0.3,'EquilibriumPotential Value',1e-3;...
                                    'SynAmp',0,100e-6,'MaxSynapticConductance Value',1e-6;...
                                    'ThreshV',-0.1,0.3,'PreSynapticThreshold Value',1e-3;...
                                    'SaturateV',-0.1,0.3,'PreSynapticSaturationLevel Value',1e-3};...
                                %spikingsynapse
                                {   'Equil',-100e-3,300e-3,'EquilibriumPotential Value',1e-3;...
                                    'SynAmp',0,100e-6,'SynapticConductance Value',1e-6;...
                                    'Decay',0.01e-3,1000e-3,'DecayRate Value',1e-3;...
                                    'RelFacil',0,10,'RelativeFacilitation Value',1;...
                                    'FacilDecay',0.01e-3,1000e-3,'FacilitationDecay Value',1e-3;...
                                    'MaxRelCond',1,1000,'MaxRelativeConductance Value',1;...
                                    'SatPSPot',-100e-3,100e-3,'SaturatePotential Value',1e-3;...
                                    'ThreshPSPot',-100e-3,100e-3,'ThresholdPotential Value',1e-3};...
                                %electricalsynapse
                                {   'TurnOnV',-100e-3,300e-3,'TurnOnThreshold Value',1e-3;...
                                    'SaturateV',-100e-3,300e-3,'TurnOnSaturate Value',1e-3;...
                                    'LowCoup',0,100e-6,'LowCoupling Value',1e-6;...
                                    'HiCoup',0,100e-6,'HighCoupling Value',1e-6};...
                                %adapter    
                                {   'A',-1e6,1e6,'A Value',1;...
                                    'B',-1e6,1e6,'B Value',1;...
                                    'C',-1e6,1e6,'C Value',1;...
                                    'D',-1e6,1e6,'D Value',1;...
                                    'LowerLimit',-1e18,1e18,'LowerLimitScale',1;...
                                    'UpperLimit',-1e18,1e18,'UpperLimitScale',1;...
                                    'LowerOutput',-1e18,1e18,'LowerOutputScale',1;...
                                    'UpperOutput',-1e18,1e18,'UpperOutputScale',1};...
                                %muscle
                                {   'A',-100e-3,300e-3,'A Value',1;... %x-offset
                                    'B',0,100,'B Value',1;... %amplitude
                                    'C',0,1000,'C Value',1;... %steepness
                                    'D',-10,10,'D Value',1;... %y-offset
                                    'RestingLength',0,1e3,'RestingLength Value',1;...
                                    'Lwidth',0,1e3,'Lwidth Value',1;...
                                    'Kse',0,1e6,'Kse Value',1;...
                                    'Kpe',0,1e6,'Kpe Value',1;...
                                    'damping',0,1e6,'B value',1};...
                                %stimulus    
                                {   'StartTime',0,1000,'StartTime Value',1;...
                                    'EndTime',0,1000,'EndTime Value',1;...
                                    'CurrentOn',-1e-07,1e-07,'CurrentOn Value',1;...
                                    'Equation',-1e9,1e9,'Equation',1;...
                                    'CurrentOnEquation',-1e9,1e9,'Equation',1}
                                };
        
        ca_props = {'GMaxCa';'MidPoint';'Slope';'TimeConstant';'ActivationType'};
    end
      
      methods
           function obj = Leg(proj_file,organism_name,leg_name)
               obj.organism_name = organism_name;
               obj.leg_name = leg_name;
               
               %%  Open the simulation files
               %Read the directory provided by the user.
               dir_file_division = max(strfind(proj_file,'\'));
               proj_folder = proj_file(1:dir_file_division-1);
               sim_files = dir(proj_folder);
               obj.proj_file = proj_file;
               
               %How many files are in that folder?
               len = length(sim_files);
               sim_file_str = [];
               
               %Pull out the simulation file
               for i=1:len
                   name_str = sim_files(i).name;
                   if length(name_str) > 14 && strcmp(name_str(end-14:end),'Standalone.asim')
                       %We've found the file we need
                       sim_file_str = [proj_folder,'\',name_str];
                   end
               end
               
               %Load the text of the simulation file
               try obj.original_text = importdata(sim_file_str);
               catch
                   disp('No simulation file exists. Open AnimatLab and export a standalone simulation.')
                   keyboard
               end
               
               %Find where the list of organisms begins
               organisms_found = contains(obj.original_text,'<Organisms>');
               organisms_lower_limit = find(organisms_found,1,'first');
               
               %Find where the organism we want begins
               organism_found = contains(obj.original_text(organisms_lower_limit:end),['<Name>',obj.organism_name,'</Name>']);
               organism_lower_limit = find(organism_found,1,'first') + organisms_lower_limit - 1;
           end
           %% Design neurons for the neural controller
           function design_neurons(obj)
               % There is three layer of SNS. the RG, the PF, and the MN, so
               % start with setting up the SNS.
               
                %%%Pull the neuron from the sim file
               neuron_found = contains(obj.original_text,'<Neuron>');
               neuron_inds = find(neuron_found);
               
               if size(neuron_inds,1)>0
                   obj.load_neurons(neuron_inds);
               else
                   obj.generate_neurons();
               end
               
                %%% Write neurons into excel files
               row = [size(obj.neur_obj{1},1) size(obj.neur_obj{2},1) size(obj.neur_obj{3},1)];
               Neurons = cell(max(row),3);
               for i = 1: 3
                   for j = 1:max(row)
                       if j<= size(obj.neur_obj{i},1)
                           Neurons{j,i} = obj.neur_obj{i}(j);
                       else
                           Neurons{j,i} = [];
                       end
                   end
               end
                 
%                Neurons = [{'Rhythem Generator','Pattern Formation Layer','Motoneurons'};Neurons];
%                xlswrite('Neurons.xls',Neurons)
           end
           %% Load Neurons from the sim File into objective
           function load_neurons(obj,neuron_inds)
               neuron_name_inds = neuron_inds+2;       
               if ischar(obj.leg_name)
                   neuron_for_this_leg = strfind(obj.original_text(neuron_name_inds),['<Name>',obj.leg_name]);
               elseif iscell(obj.leg_name)
                   neuron_for_this_leg = cell(length(neuron_name_inds),1);
                   for i=1:length(obj.leg_name)
                       temp_neuron_for_this_leg = strfind(obj.original_text(neuron_name_inds),['<Name>',obj.legs_name{i}]);
                       for j=1:length(temp_neuron_for_this_leg)
                           if ~isempty(temp_neuron_for_this_leg{j})
                               neuron_for_this_leg{j} = 1;
                           end
                       end
                   end
               end
               
               %Logically pick all the Neuron from this leg
               neuron_for_this_leg_inds = cellfun(@isempty,neuron_for_this_leg) == 0;
               
               %These are the indices of the names of muscles.
               obj.neur_inds = neuron_name_inds(neuron_for_this_leg_inds);
               
               %Find parameters of neurons.
               neuron_names = obj.original_text(obj.neur_inds);
               RestingPot = obj.original_text(obj.neur_inds+4);
               Size = obj.original_text(obj.neur_inds+5);
               TimeConst = obj.original_text(obj.neur_inds+6);
               GMaxCa = obj.original_text(obj.neur_inds+12);
               
               for i=1:length(neuron_names)
                   neuron_names{i} = strrep(neuron_names{i},'<Name>','');
                   neuron_names{i} = strrep(neuron_names{i},'</Name>','');
                   RestingPot{i} = strrep(RestingPot{i},'<RestingPot>','');
                   RestingPot{i} = strrep(RestingPot{i},'</RestingPot>','');
                   Size{i} = strrep(Size{i},'<Size>','');
                   Size{i} = strrep(Size{i},'</Size>','');
                   TimeConst{i} = strrep(TimeConst{i},'<TimeConst>','');
                   TimeConst{i} = strrep(TimeConst{i},'</TimeConst>','');
                   GMaxCa{i} = strrep(GMaxCa{i},'<GMaxCa>','');
                   GMaxCa{i} = strrep(GMaxCa{i},'</GMaxCa>','');
               end
               Neurons = [neuron_names RestingPot Size TimeConst];
               
               % Assorting the neurons into 3 Layer
               RG_neurons_inds = contains(neuron_names,'RG');
               PF_neurons_inds = contains(neuron_names,'PF');
               MN_neurons_inds = logical(1- RG_neurons_inds-PF_neurons_inds);
               
               RG_neurons = Neurons(RG_neurons_inds,:);
               PF_neurons = Neurons(PF_neurons_inds,:);
               MN_neurons = Neurons(MN_neurons_inds,:);
               
               %%% Saving information into SNS objective
               obj.neur_obj = cell(3,1);
               obj.neur_obj{1} = sortrows(RG_neurons);
               obj.neur_obj{2} = sortrows(PF_neurons);
               obj.neur_obj{3} = sortrows(MN_neurons);
               
               %%% Saving neuron properties into xls;
               Sheet_name = {'Rhythem Generator','Pattern Formation Layer','Motoneurons'};
               for i = 1:3
                   Neuron_Properties = [{'Neuron_Name','RestingPotential','RelativeSize','TimeConstant'};obj.neur_obj{i}];
                   xlswrite('Neurons_Properties.xls',Neuron_Properties,convertCharsToStrings(Sheet_name{i}))
               end
               
               %%% Oscilattor Propeties
               oscillator_inds = str2double(GMaxCa)>0;
               oscillator_name_inds = obj.neur_inds(oscillator_inds);
               
               oscillator_name = neuron_names(oscillator_inds);
               mMidPoint = obj.original_text(oscillator_name_inds+16);
               mSlope = obj.original_text(oscillator_name_inds+17);
               mTimeConstant = obj.original_text(oscillator_name_inds+18);
               hMidPoint =obj.original_text(oscillator_name_inds+23);
               hSlope = obj.original_text(oscillator_name_inds+24);
               hTimeConstant = obj.original_text(oscillator_name_inds+25);
               
               for i = 1:length(oscillator_name)
                   mMidPoint{i} = strrep(mMidPoint{i},'<MidPoint>','');
                   mMidPoint{i} = strrep(mMidPoint{i},'</MidPoint>','');
                   mSlope{i} = strrep(mSlope{i},'<Slope>','');
                   mSlope{i} = strrep(mSlope{i},'</Slope>','');
                   mTimeConstant{i} = strrep(mTimeConstant{i},'<TimeConstant>','');
                   mTimeConstant{i} = strrep(mTimeConstant{i},'</TimeConstant>','');
                   hMidPoint{i} = strrep(hMidPoint{i},'<MidPoint>','');
                   hMidPoint{i} = strrep(hMidPoint{i},'</MidPoint>','');
                   hSlope{i} = strrep(hSlope{i},'<Slope>','');
                   hSlope{i} = strrep(hSlope{i},'</Slope>','');
                   hTimeConstant{i} = strrep(hTimeConstant{i},'<TimeConstant>','');
                   hTimeConstant{i} = strrep(hTimeConstant{i},'</TimeConstant>','');
               end
               GMaxCa = GMaxCa(oscillator_inds);
               Oscillators = [oscillator_name  GMaxCa mMidPoint mSlope mTimeConstant hMidPoint hSlope hTimeConstant];
               Oscillators = [{'Neuron_Name','GMaxCa','mMidPoint','mSlope','mTimeConstant','hMidpoint','hSlope','hTimeConstant'};sortrows(Oscillators)];
               xlswrite('Neurons_Properties.xls',Oscillators,'Oscillators')
           end
           %% Generate Neurons base on muscle numbers
           function generate_neurons(obj)
               % The CPG stucture is set, so we can manually define which
               % neurons in there, if there is future need we can change in
               % the future. thus now we generates the motoneurons pools.
               
               %%% For CPG
               RG = {[obj.leg_name '_RG EXT'];[obj.leg_name '_RG FLX'];[obj.leg_name '_RG IN EXT'];[obj.leg_name '_RG IN FLX']};
               PF = {[obj.leg_name '_Hip PF EXT'];[obj.leg_name '_Hip PF FLX'];[obj.leg_name '_Hip PF IN EXT'];[obj.leg_name '_Hip PF IN FLX'];...
                   [obj.leg_name '_Knee PF EXT'];[obj.leg_name '_Knee PF FLX'];[obj.leg_name '_Knee PF IN EXT'];[obj.leg_name '_Knee PF IN FLX'];...
                   [obj.leg_name '_Ankle PF EXT'];[obj.leg_name '_Ankle PF FLX'];[obj.leg_name '_Ankle PF IN EXT'];[obj.leg_name '_Ankle PF IN FLX']};
               
               %%% For MN, find muscles in that leg.Generate motoneuron pools base on that.
               musc_found = contains(obj.original_text,'<Type>LinearHillMuscle</Type>');
               musc_inds = find(musc_found);
               musc_name_inds = musc_inds-2;
               
               if ischar(obj.leg_name)
                   musc_for_this_leg = strfind(obj.original_text(musc_name_inds),['<Name>',obj.leg_name]);
               elseif iscell(obj.leg_name)
                   musc_for_this_leg = cell(length(musc_name_inds),1);
                   for i=1:length(obj.leg_name)
                       temp_musc_for_this_leg = strfind(obj.original_text(musc_name_inds),['<Name>',obj.leg_name{i}]);
                       for j=1:length(temp_musc_for_this_leg)
                           if ~isempty(temp_musc_for_this_leg{j})
                               musc_for_this_leg{j} = 1;
                           end
                       end
                   end
               end
               
               %Logically pick all the muscle from this leg
               musc_for_this_leg_inds = cellfun(@isempty,musc_for_this_leg) == 0;
               musc_inds = musc_name_inds(musc_for_this_leg_inds);
               
               %Find names of muscles.
               musc_names = obj.original_text(musc_inds);
               for i=1:length(musc_names)
                   musc_names{i} = strrep(musc_names{i},'<Name>','');
                   musc_names{i} = strrep(musc_names{i},'</Name>','');
               end
               
               %Generates MN pools. Each MN pool have 6 neurons:
               % MN; Ia;Ib;II;Renshaw; Ia Interneuron;
               MN = cell(length(musc_names)*6,1);
               for i = 1:length(musc_names)
                  MN{i*6-5} = [musc_names{i} ' MN'];
                  MN{i*6-4} = [musc_names{i} ' Ia'];
                  MN{i*6-3} = [musc_names{i} ' Ib'];
                  MN{i*6-2} = [musc_names{i} ' II'];
                  MN{i*6-1} = [musc_names{i} ' Re'];
                  MN{i*6} = [musc_names{i} ' Ia IN'];
               end
               
               obj.neur_obj = cell(3,1);
               obj.neur_obj{1} = RG;
               obj.neur_obj{2} = PF;
               obj.neur_obj{3} = MN;
           end
           %% Design Sypnase connectivity that transmitt signal between neurons
           function design_synapse(obj,DM)
               % Swith D|M from two types of synapse connectivity,
               % 1 -- load the current synaptics from animatlab 
               % 2 -- use embeded synaptics to construct
               
               if ~ismember(DM,[1 2])
                   fprintf(['Wrong Design Method choosen, please re-enter D|M\n', '1 -- load the current synaptics from animatlab\n', '2 -- use embeded synaptics to construct\n']);
               end
               
               switch DM
                   case 1
                    %% load the current synaptics from animatlab
                       % All the synapses in this network is non-spiking,
                       % so start searching from non-spiking
                       
                       %%%Pull the synapses from the sim file
                       Synapses_found = contains(obj.original_text,'<Type>NonSpikingChemical</Type>');
                       Synapses_inds = find(Synapses_found);
                       Synapses_name_inds =Synapses_inds-2;
                       obj.syn_inds = Synapses_name_inds;

                       %Find properties of synapses.
                       syn_names = obj.original_text(obj.syn_inds);
                       syn_Equil =  obj.original_text(Synapses_inds+1);
                       syn_SynAmp =  obj.original_text(Synapses_inds+2);
                       syn_ThreshV =  obj.original_text(Synapses_inds+3);
                       syn_SaturateV =  obj.original_text(Synapses_inds+4);
                       
                       for i=1:length(syn_names)
                           syn_names{i} = strrep(syn_names{i},'<Name>','');
                           syn_names{i} = strrep(syn_names{i},'</Name>','');
                           syn_Equil{i} = strrep(syn_Equil{i},'<Equil>','');
                           syn_Equil{i} = strrep(syn_Equil{i},'</Equil>','');
                           syn_SynAmp{i} = strrep(syn_SynAmp{i},'<SynAmp>','');
                           syn_SynAmp{i} = strrep(syn_SynAmp{i},'</SynAmp>','');
                           syn_ThreshV{i} = strrep(syn_ThreshV{i},'<ThreshV>','');
                           syn_ThreshV{i} = strrep(syn_ThreshV{i},'</ThreshV>','');
                           syn_SaturateV{i} = strrep(syn_SaturateV{i},'<SaturateV>','');
                           syn_SaturateV{i} = strrep(syn_SaturateV{i},'</SaturateV>','');
                       end
                       
                       obj.syn_obj = [syn_names,syn_Equil,syn_SynAmp,syn_ThreshV,syn_SaturateV];
                       
                   case 2
                       disp('case in construction,please wait till it is finished')
                       keyboard
               end
               
               %% save the synaptic parameters
               Synapse = [{'Synapse Name','Equilibrium Potential','Max Synaptic Conductance','Pre-Syn Saturatation', 'Pre-Syn Threshold'};obj.syn_obj];
               xlswrite('Synapse.xls',Synapse)
           end
           %% Connect the neurons in the CPG, Generating walking oscillator
           function design_RG(obj)
               RG_neurons = obj.neur_obj{1};
               
               if size(obj.syn_inds,1)>0
                   obj.syn_obj;
               else
                   keyboard;
               end
               
               keyboard
           end
           function design_PF(obj)
           end
      end
end