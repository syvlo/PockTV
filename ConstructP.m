function [ P ] = ConstructP( Input, LabelQuantification )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    [Height, Width] = size(Input);
    [~,labelsSize] = size(LabelQuantification);
    P = zeros(Height, Width, labelsSize, 3);
    
    for (i=1:Height)
        for (j=1:Width)
            for (k=1:labelsSize)
%                 P(i, j, k, 1) = rand;
%                 P(i, j, k, 2) = rand;
%                 denom = max(1, sqrt(P(i, j, k, 1)^2 + P(i, j, k, 2)^2));
%                 P(i, j, k, 1) = P(i, j, k, 1) / denom;
%                 P(i, j, k, 2) = P(i, j, k, 2) / denom;
                P(i, j, k, 1) = 0.65;
                P(i, j, k, 2) = 0.75;
                if(LabelQuantification(k) == 0)
                    P(i, j, k, 3) = 10000; %FIXME, hardcoded...
                else
                    P(i, j, k, 3) = Rayleigh(Input(i, j), LabelQuantification(k));
                end
            end
        end
    end

end

