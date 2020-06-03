function [lifetime, en] = multihop_transmission(x, y, en, SinkX, SinkY, nn_dist, mv)
%DIRECT_TRANSMISSION Summary of this function goes here
%   Detailed explanation goes here
    lifetime = 0;
    n = size(x, 2);
    energy = 0;
    dist_direct(1 : n) = 0;
    dead = 0;
    Rounds = 0;
    
    Elec = 50*0.000000001; % Eelec = 50nJ/bit energy tranfer and receive
    Efs = 10*0.000000000001 ;% energy free space
    Emp = 0.0013*0.000000000001; %energy multi path
    Kbit = 2000; % size  
    
    d0 = sqrt(Efs / Emp);
    
    for i = 1 : n
            dist_direct(i)= sqrt( (x(i)-SinkX)^2 + (y(i)-SinkY)^2 );
    end
    
    while dead == 0
        Rounds = Rounds + 1;
        for i = 1 : n
            if (nn_dist(i) <= d0)
                energy = mv(i) * Kbit * Elec + Efs * nn_dist(i) * Kbit + (mv(i)-1) * Kbit * Elec;
            else
                energy = mv(i) * Kbit * Elec + Emp * nn_dist(i) * Kbit + (mv(i)-1) * Kbit * Elec;                
            end
            en(i) = en(i) - energy;
            if en(i) <= 0
                en(i) = 0;
                lifetime = Rounds;
                dead = 1;
                return
            end
        end
    end
end
