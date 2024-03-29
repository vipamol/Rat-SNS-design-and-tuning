function [ new_state,syn_null ] = NSCS_func( state, props )
    
    V_pre = state(1);
    V_post = state(2);
    
    G = props(1);
    V_eq = props(2);
    V_th_low = props(3);
    V_th_high = props(4);
    
    Current = G * ((V_pre-V_th_low)/(V_th_high-V_th_low) * (V_pre >= V_th_low && V_pre < V_th_high) +...
                (V_pre >= V_th_high)) * (V_eq - V_post);
            
            GS =  G * ((V_pre-V_th_low)/(V_th_high-V_th_low) * (V_pre >= V_th_low && V_pre < V_th_high) +...
                (V_pre >= V_th_high));
            
    new_state = [V_pre;V_post;Current];
    syn_null = [V_eq;GS];
end