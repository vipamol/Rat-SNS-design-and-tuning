classdef Neural_controller < matlab.mixin.SetGet
    
    properties
        proj_file;
        organism_name;
        leg_obj = {};
        num_legs;
        mirrored;
    end
    
    methods
        function obj = Neural_controller(proj_file,name,legs_name,mirrored)
            constructor = tic;
           
            obj.proj_file = proj_file;
            obj.organism_name = name;
            obj.num_legs = size(legs_name,2);
            obj.mirrored = mirrored;
                 
            for i=1:obj.num_legs
                obj.leg_obj{i} = Leg(proj_file,name,legs_name{i});
                disp(['Leg ',num2str(i),' constructed.']);
            end
            
            t_construction = toc(constructor)/60;
            fprintf('It took %f minutes to construct the network object.\n',t_construction);
        end
        %% Design a New neural control network for the biomechiancal body
        function success = design_SNS(obj,DM)
            %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            obj.load_network_and_parameters(DM);
            obj.design_CPGs();
            success = 1;
        end
        %%  Load the neurons and parameters from the network
        function load_network_and_parameters(obj,DM)

            for i=1:obj.num_legs
                obj.leg_obj{i}.design_neurons();
                obj.leg_obj{i}.design_synapse(DM);
            end
        end
        %%  Designing the CPG for the leg
        function design_CPGs(obj)
            for i=1:obj.num_legs
                obj.leg_obj{i}.design_RG();
                obj.leg_obj{i}.design_PF();
            end
        end
    end
end