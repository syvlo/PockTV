function [ P ] = ConstructP( Input, LabelQuantification )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    [Height, Width] = size(Input);
    [~,labelsSize] = size(LabelQuantification);
    P = zeros(Height, Width, labelsSize, 3);
    
    for (i=1:Height)
        for (j=1:Width)
            for (k=1:labelsSize)
                P(i, j, k, 1) = 0.7;
                P(i, j, k, 2) = 0.7;
                P(i, j, k, 3) = Rayleigh(Input(i, j), LabelQuantification(k));
            end
        end
    end

end

