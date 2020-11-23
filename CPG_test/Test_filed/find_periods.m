function [mean_period] = find_periods(V1,V2,dt)
a = 1;

for i = 50:length(V1)
    if V1(i-1)>V2(i-1) && V1(i)<V2(i)
        step_start(a) = i;
        a = a+1;
    end    
end


if a<3
    mean_period = 0;
else
    periods = diff(step_start(1:a-2))*dt;
    if step_start(end)<length(V1)/2
        mean_period = 0;
    else
        mean_period = mean(periods);
    end
end

end