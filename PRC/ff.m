function [frequency,step_start] = ff(V1,V2,dt)

    a = 1;
    
    for i = 2:length(V1)
        if V2(i)>=V1(i) && V2(i-1)<V1(i-1)
            step_start(a) = i;
            a = a+1;
        end
    end
    
    
    if a > 2 && mean(abs(V2(end-3:end)-V1(end-3:end)))>0.01
        periods = diff(step_start(1:a-1))*dt;
        mean_period = mean(periods); % in ms
        frequency = 1000/mean_period;
    else
        frequency = 0;
        step_start = [];
    end

end