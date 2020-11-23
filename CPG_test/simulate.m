function [ neur_state, neur_derivatives ] = simulate( neur_state, neur_props, syn_state, syn_props, syn_map, ext_cond, time, dt )
%SIMULATE This function runs a complete simulation of the interaction of
%the neurons and synapses passed to it. They are connected by the
%connection map, the simulation runs for time seconds, and the time step is
%dt.
    
%   Detailed explanation goes here
    num_neurons = size(neur_state,3);
    num_synapses = size(syn_map,1);
    post_syn = syn_map(:,2);
    post_syn_ind = cell(1,size(neur_state,3));

    neur_derivatives = zeros(3,num_neurons);
    for i=1:size(neur_state,3)
        %To save run time, find which synapses synapse onto which neurons
        %only once, and save the results in a vector. Put each vector into
        %one cell of an array.
        post_syn_ind{i} = find(post_syn == i);
    end

    for i=2:time/dt
        %Share presynaptic (syn_state(1)) and postsynaptic (syn_state(2)) voltage with synapses
        for j=1:num_synapses
            syn_state(1:2,i-1,j) = [neur_state(1,i-1,syn_map(j,1));neur_state(1,i-1,syn_map(j,2))];
%             keyboard
            syn_state(:,i,j) = NSCS_func(syn_state(:,i-1,j),syn_props(j,:));
        end
        
        for j=1:num_neurons
                neur_state(5,i-1,j) = ext_cond(i-1,j) + sum(syn_state(3,i-1,post_syn_ind{j}));  
                [neur_state(:,i,j),neur_derivatives(:,j)] = NSN_func(neur_state(:,i-1,j),neur_props(j,:),dt);
        end
%         keyboard
    end
end

