function [ Output ] = Rayleigh( V, U )
%Compute Rayleigh as dataterm.

    Output = double(V)^2 / double(U)^2 + 2*log(double(U));

    %Do we want to weight the data term ?
    %Output = Output ./ 10;%Mock of beta term...
end

