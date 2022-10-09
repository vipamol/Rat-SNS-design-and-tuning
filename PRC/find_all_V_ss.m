function [ v_star_low, v_star_high, v_star_interneuron_inh, v_star_interneuron_exc, nprops, sprops ] = find_all_V_ss( nprops, sprops, v_star_high_initial )
    
    bisect_tol = 1e-12;
    bisect_max_it = 1e6;
    
    i = 1;
    eq_pt_max_it = 1e6;
    eq_pt_found = false;
    eq_pt_tol = 1e-12;
    
    vstar = NaN(eq_pt_max_it,2);
    vdiff = NaN(eq_pt_max_it,1);
    dv_dt = NaN(eq_pt_max_it,2);
    dt = 1;
    
    num_neurons = size(nprops,1);
    num_synapse = size(sprops,1);
    
    alpha = 1e-4;
    
    while ~eq_pt_found && i < eq_pt_max_it
    
        if i == 1
            if num_neurons >= 5
                v_star_ext = (nprops(5,5).*nprops(5,2) + nprops(5,13))./nprops(5,2);
            end
            
            if isempty(v_star_high_initial)
%                 g = @(v) dV_dt(v,hinf_of_v(nprops(1,9),nprops(1,10),nprops(1,11),v),0,0,nprops(1,:));
%                 v_star_high = bisect(g,-80,-20,bisect_tol,bisect_tol,bisect_max_it);
                v_star_high = -59;
            else
                v_star_high = v_star_high_initial;
            end
                
            G_dep1 = G_syn_func(v_star_high,sprops(1,:));
            v_star_interneuron_exc = (nprops(3,5).*nprops(3,2) + G_dep1.*sprops(1,2) + nprops(3,13))./(nprops(3,2) + G_dep1);

            G_hyp3 = G_syn_func(v_star_interneuron_exc,sprops(3,:));
            E_hyp3 = sprops(3,2);
            
            if num_synapse > num_neurons
                G_dep5 = G_syn_func(v_star_high,sprops(5,:));
                E_dep5 = sprops(5,2);
                Gsyn = [G_hyp3,G_dep5];
                Esyn = [E_hyp3,E_dep5];
            else
                Gsyn = G_hyp3;
                Esyn = E_hyp3;
            end
            
            g = @(v) dV_dt(v,hinf_of_v(nprops(2,9),nprops(2,10),nprops(2,11),v),Gsyn,Esyn,nprops(2,:));
            
            v_star_low = bisect(g,-80,-20,bisect_tol,bisect_tol,bisect_max_it);
            
            vstar(i,:) = [v_star_high,v_star_low];
        end

        G_dep1 = G_syn_func(vstar(i,1),sprops(1,:));
        v_star_interneuron_exc = (nprops(3,5).*nprops(3,2) + G_dep1.*sprops(1,2) + nprops(3,13))./(nprops(3,2) + G_dep1);

        G_hyp3 = G_syn_func(v_star_interneuron_exc,sprops(3,:));
        E_hyp3 = sprops(3,2);
        
        if num_neurons >= 5
            G_drive2 = G_syn_func(v_star_ext,sprops(6,:));
            E_drive2 = sprops(6,2);
            gsyn2 = [G_hyp3;G_drive2];
            esyn2 = [E_hyp3;E_drive2];
        elseif num_synapse > num_neurons
            G_dep5 = G_syn_func(vstar(i,1),sprops(5,:));
            E_dep5 = sprops(5,2);
            gsyn2 = [G_hyp3,G_dep5];
            esyn2 = [E_hyp3,E_dep5];
        else
            gsyn2 = G_hyp3;
            esyn2 = E_hyp3;
        end       
        
        dv_dt(i,2) = dV_dt(vstar(i,2),hinf_of_v(nprops(2,9),nprops(2,10),nprops(2,11),vstar(i,2)),gsyn2,esyn2,nprops(2,:));

        G_dep2 = G_syn_func(vstar(i,2),sprops(2,:));
        v_star_interneuron_inh = (nprops(4,5).*nprops(4,2) + G_dep2.*sprops(2,2) + nprops(4,13))./(nprops(4,2) + G_dep2);
        
        G_hyp4 = G_syn_func(v_star_interneuron_inh,sprops(4,:));
        E_hyp4 = sprops(4,2);
        
        if num_neurons >= 5
            G_drive1 = G_syn_func(v_star_ext,sprops(5,:));
            E_drive1 = sprops(5,2);
            gsyn1 = [G_hyp4;G_drive1];
            esyn1 = [E_hyp4;E_drive1];
        elseif num_synapse > num_neurons
            G_dep6 = G_syn_func(vstar(i,2),sprops(6,:));
            E_dep6 = sprops(6,2);
            gsyn1 = [G_hyp4,G_dep6];
            esyn1 = [E_hyp4,E_dep6];
        else
            gsyn1 = G_hyp4;
            esyn1 = E_hyp4;
        end
        %now, find what v_star_high would be, given this neuron's voltage.
        dv_dt(i,1) = dV_dt(vstar(i,1),hinf_of_v(nprops(1,9),nprops(1,10),nprops(1,11),vstar(i,1)),gsyn1,esyn1,nprops(1,:));
        
        vstar(i+1,:) = vstar(i,:) + dt*dv_dt(i,:);
        
%         vdiff(i) = abs(vstar(i+1,1) - vstar(i,1)) + abs(vstar(i+1,2) - vstar(i,2));
%         vdiff(i) = norm(vstar(i+1,:) - vstar(i,:));
        vdiff(i) = norm(dt*dv_dt(i,:));
        
        if vdiff(i) <= eq_pt_tol || i >= eq_pt_max_it
            %our voltage has converged, because it is not changing anymore
            eq_pt_found = true;
            v_star_high = max(vstar(i+1,:));
            v_star_low = min(vstar(i+1,:));
        elseif i > 1 && vdiff(i)/vdiff(i-1) > 1/(1 + alpha)
            %we are not shrinking fast enough (or we are growing)
            dt = dt/2;
%             disp(['growing, dt = ',num2str(dt),', i = ',num2str(i)])
            if dt < eps
                %this should never happen
                dt = 1;
            end
        end
        i = i + 1;
%         keyboard
    end
    
%     h1 = figure;
%     hold on
%     grid on
%     plot(vstar)
%     h1.Position = [14,570,560,420];
%     hold off
%     
%     h2 = figure;
%     grid on
%     title('vdiff')
%     semilogy(vdiff)
%     h2.Position = [580,570,560,420];
%     hold off
%     
%     h3 = figure;
%     grid on
%     title('vdiff ratio')
%     semilogy(vdiff(2:end)./vdiff(1:end-1))
%     h3.Position = [1132,570,560,420];
%     hold off
% 
%     keyboard
%     close all
%     clc
end