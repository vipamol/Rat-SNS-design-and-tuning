classdef Connectivity < matlab.mixin.SetGet
    % Functional Subnetworks
    % Pre-defined modulation synaptic connectivies
    properties
        con_num
        Syn_obj
    end
    
    methods
        function obj = Connectivity(Type,k)
            obj.con_num = size(k,2);
            
            if obj.con_num==1
                obj.transimition_net(k);
            elseif obj.con_num>1
                switch Type
                    case 'add'
                        obj.addition_net(k);
                    case 'sub'
                        obj.subtraction_net(k);
                    case 'div'
                        obj.division_net(k);
                    case 'multi'
                        obj.multiplication_net(k);
                    case 'diff'
                        obj.differemtiation_net(k);
                    case 'inter'
                        obj.intergration_net(k);
                end
            end
        end
        %% Transimition connectivies
        function  transimition_net(obj,k)
            % transimition connectivies is an 1 on 1 connection, the equation
            % can be found on Nick's paper. 
            % ! delat(Es)>K*R
            obj.Syn_obj = Synapse();
            
            obj.Syn_obj.Name = 'Syn1';
            obj.Syn_obj.ThreshV = -60;
            obj.Syn_obj.SaturateV = -40;
            R = obj.Syn_obj.SaturateV - obj.Syn_obj.ThreshV;
            
            if k>0 % Equil should be higher than Saturate
                obj.Syn_obj.Equil = -40;
            elseif k<0
                obj.Syn_obj.Equil=-70;
            end
            obj.Syn_obj.SynAmp = k*R/(obj.Syn_obj.Equil-obj.Syn_obj.ThreshV-k*R);
        end
        
        %% Addition netowork
        function addition_net(obj,k)
            for i = 1:obj.con_num
                obj.Syn_obj{i,1} = Synapse();
                obj.Syn_obj{i}.Name = strcat('Syn', num2str(i));
                obj.Syn_obj{i}.ThreshV = -60;
                obj.Syn_obj{i}.SaturateV = -40;
                R(i) = obj.Syn_obj{i}.SaturateV - obj.Syn_obj{i}.ThreshV;
                obj.Syn_obj{i}.Equil = -40;
                obj.Syn_obj{i}.SynAmp = k(i)*R(i)/(obj.Syn_obj{i}.Equil-obj.Syn_obj{i}.ThreshV-k(i)*R(i));  
            end
        end
        %% Subtraction network
        function subtraction_net(obj,k)
            for i = 1:obj.con_num
                obj.Syn_obj{i,1} = Synapse();
                obj.Syn_obj{i}.Name = strcat('Syn', num2str(i));
                obj.Syn_obj{i}.ThreshV = -60;
                obj.Syn_obj{i}.SaturateV = -40;
                R(i) = obj.Syn_obj{i}.SaturateV - obj.Syn_obj{i}.ThreshV;
                
                if k(i)>0
                    obj.Syn_obj{i}.Equil = -40;
                elseif k(i)<0
                    obj.Syn_obj{i}.Equil=-70;
                end
                obj.Syn_obj{i}.SynAmp = k(i)*R(i)/(obj.Syn_obj{i}.Equil-obj.Syn_obj{i}.ThreshV-k(i)*R(i));
            end
        end
        %% Division network
        function division_net(obj,neuron_pool)
            disp('div')
        end
        %% Multiplication network
        function multiplication_net(obj,neuron_pool)
            disp('multi')
        end
        
        %% Differemtiation network
        function differemtiation_net(obj,neuron_pool)
            disp('diff')
        end 
        %% Intergration network
        function intergration_net(obj,neuron_pool)
            disp('inter')
        end
    end
end