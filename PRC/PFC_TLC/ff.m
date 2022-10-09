function [frequency,step_start] = ff(V1,V2,dt)

    a = 1;
    
    for i = 2:length(V1)
        if V2(i)>=V1(i) && V2(i-1)<V1(i-1)
            step_start(a) = i;
            a = a+1;
        end
    end
   
    
    if a > 3 && (step_start(end) > length(V1)/2)
        periods = diff(step_start)*dt;      
        if all(periods>200)
            mean_period = mean(periods); % in ms
            frequency = 1000/mean_period;
        else
            frequency = 0;
        end
    else
        frequency = 0;
        step_start = [];
    end
% plot(V1);hold on; plot(V2);
end