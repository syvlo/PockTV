function [ Output ] = Rayleigh( V, U )
%Compute Rayleigh as dataterm.

    Output = 1E1*(V-U)^2; % debug: on commence par une attache aux donn�es quadratique...
    % Output = double(V)^2 / double(U)^2 + 2*log(double(U));

    %Do we want to weight the data term ?
    Output = Output ./ 10;%Mock of beta term...
end

