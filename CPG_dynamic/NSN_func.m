function [ new_state, derivatives] = NSN_func( states, props, dt )
%NEURONINT Summary of this function goes here
%   Detailed explanation goes here
    V = states(1,end);
    m = states(2,end);
    h = states(3,end);
    I_ext = states(5,end); %Synaptic and applied currents
    
    C = props(1); %5e-9;
    Gmem = props(2); %1e6;
    Gca = props(3); %5e-6;
    Eca = props(4); %.2;
    Vr = props(5); %-.060;
    Tm = props(6); %.02;
    Sm = props(7); %.1e3;
    VmidM = props(8); %-.030;
    Th = props(9); %.25;
    Sh = props(10); %-.1e3;
    VmidH = props(11); %-.090;
    V_noise = props(12);
    I_stim = props(13);

    gca = Gca*m*h;
    ica = gca*(Eca-V);
    z = exp(-Sm*(V-VmidM));
    minf = 1/(1+z);
    tau = minf*sqrt(z)*Tm;
    dM = (minf-m)*(1-exp(-dt/tau));
    
    z = exp(-Sh*(V-VmidH))*0.5;
    hinf = 1/(1+z);
    tau = hinf*sqrt(z)*Th;
    dH = (hinf-h)*(1-exp(-dt/tau));
    
%     m = m + dM;
    m = minf;
    h = h + dH;
    
%     ica
%     (Vr-V)
%     I_ext
%     I_stim
%     ica + (Vr-V)*Gmem + I_ext + I_stim
    dV = dt/C*(ica + (Vr-V)*Gmem + I_ext + I_stim)+V_noise*2*(rand-.5);
    
    V = V+dV;
    
    time = states(4,end) + dt;
    
    new_state = [V;m;h;time;I_ext;hinf];
    derivatives = [dV/dt;dM/dt;dH/dt];
    
%     keyboard
end

