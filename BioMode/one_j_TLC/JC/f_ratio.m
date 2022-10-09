function ratio = f_ratio(Theta)

[~,ind] = findpeaks(-Theta);

N = length(ind);
C = zeros(10000,N-1);
for i = 2:N
    
    L = Theta(ind(i-1):ind(i)-1);
    C(:,i-1) = interp1(linspace(0,1,length(L)),L,linspace(0,1,10000));
end

   W= sum(C,2)/(N-1);
   [~,I] = max(W);

ratio = I/length(W);
end