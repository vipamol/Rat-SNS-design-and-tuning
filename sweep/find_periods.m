function [mean_period] = find_periods(V1,V2,dt)
% cop off initial states
Initial = round(length(V1)/5);
V1 = V1(Initial:end);
V2 = V2(Initial:end);

pks = findpeaks(V1);
% keyboard

if std(pks) <0.01
    a = 1;    
    for i = 2:length(V1)
        if V1(i)>=V2(i) && V1(i-1)<V2(i-1)
            step_start(a) = i;
            a = a+1;
        end
    end
    
    if a > 2
        periods = diff(step_start(1:a-1))*dt;
        mean_period = mean(periods);
    else
        mean_period = 0;
    end
else
    mean_period = 0;
end

end
