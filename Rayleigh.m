function [ Output ] = Rayleigh( V, U )
%Compute Rayleigh as dataterm.

    if (U > 0.4)
        U = 1;
    else
        U = 0;
    end

    Output = 10 * (V-U)^2 + 1; % debug: on commence par une attache aux donn�es quadratique...
    %Output = V^2 / U^2 + 2*log(U);

    %Do we want to weight the data term ?
    %Output = Output * 0.1;%Mock of beta term...
    
    if (Output <= 0)
        Output = 0.000000001;
        disp(strcat('Output = ', num2str(Output), ' for V = ' , num2str(V), ' and U = ' , num2str(U)));
    end
end

