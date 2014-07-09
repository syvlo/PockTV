function [ Output ] = Rayleigh( V, U )
%Compute Rayleigh as dataterm.

    Beta = 0.1;


    %Output = (V-U)^2; % debug: on commence par une attache aux donn�es quadratique...
    Output = Beta * (V.^2 ./ U.^2 + 2*log(U)) + Beta * 12;

    %Do we want to weight the data term ?
    %Output = Output * 10;%Mock of beta term...
    
%     if (Output <= 0.0001)
%         Output = 0.000000001;
%         disp(strcat('Output = ', num2str(Output), ' for V = ' , num2str(V), ' and U = ' , num2str(U)));
%     end
end

