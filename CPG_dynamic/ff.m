function [frequency,step_start] = ff(V1,V2,dt)
% cop off initial states
Initial = round(length(V1)/5);
V1 = V1(Initial:end);
V2 = V2(Initial:end);

pks = findpeaks(V1);
if std(pks) <0.01    
    a = 1;
    for i = 2:length(V1)
        if V1(i)>=V2(i) && V1(i-1)<V2(i-1)
            step_start(a) = i;
            a = a+1;
        end
    end
    
    
    if a > 2 && mean(abs(V1(end-3:end)-V2(end-3:end)))>0.01
        periods = diff(step_start(1:a-1))*dt;
        mean_period = mean(periods); % in ms
        frequency = 1000/mean_period;
        step_start = step_start+Initial-1;
    else
        frequency = 0;
        step_start = [];
    end
else
    frequency = 0;
    step_start = [];
end
% plot(V1); hold on; plot(V2); legend('E','F')
% keyboard
end