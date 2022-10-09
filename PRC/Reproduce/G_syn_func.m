function g = G_syn_func( Vpre, sprops )
%G_SYN_FUNC Summary of this function goes here
%   Detailed explanation goes here
    g = sprops(1)*min(max( (Vpre - sprops(3))/(sprops(4) - sprops(3)),0),1);

end

