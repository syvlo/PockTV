function [ Output ] = ConstructImageFromPhi( Phi, LabeLQuantification )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    Output = zeros(size(Phi, 1), size(Phi, 2));
    
    for (i=2:size(LabeLQuantification, 2))
        Output = Output + (LabeLQuantification(i) - LabeLQuantification(i - 1)) .* Phi(:, :, i);
    end

end

