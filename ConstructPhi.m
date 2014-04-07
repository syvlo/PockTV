function [ Phi, LabelQuantification ] = ConstructPhi( Input )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    VMax = max(max(Input));
    
    i = 1;
    curVal = 0;
    while (curVal < VMax + 100)
        LabelQuantification(i) = curVal;
        curVal = curVal + 300;
        i = i + 1;
    end

    [Height, Width] = size(Input);
    [~,labelsSize] = size(LabelQuantification);
    Phi = zeros(Height, Width, labelsSize);
    
    for(i=1:labelsSize)
        [r, v] = find(Input >= LabelQuantification(i)); %FIX ME: Step to speed up!
        for (j=1:size(r, 1))
            Phi(r(j), v(j), i) = 1;
        end
    end
    
end

