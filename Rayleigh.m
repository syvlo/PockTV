function [ Output ] = Rayleigh( V, U )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    Output = double(V)^2 / double(U)^2 + 2*log(double(U));

end

