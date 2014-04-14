function [ Phi, LabelQuantification ] = ConstructPhi( Input )
%Get initial phi. (Basically, translates the input image into phi.

    VMax = max(max(Input));
    
    %Quantification step.
    i = 1;
    curVal = 1;
    while (curVal < 1000)
        LabelQuantification(i) = curVal;
        curVal = curVal + 30;
        i = i + 1;
    end
    while (curVal < VMax + 100)
        LabelQuantification(i) = curVal;
        curVal = curVal + 200;
        i = i + 1;
    end

    [Height, Width] = size(Input);
    [~,labelsSize] = size(LabelQuantification);
    Phi = zeros(Height, Width, labelsSize);
    
    %Construction using the layer cake idea.
    for(i=1:labelsSize)
        [r, v] = find(Input >= LabelQuantification(i)); %FIX ME: Step to speed up!
        for (j=1:size(r, 1))
            Phi(r(j), v(j), i) = 1;
        end
    end
    
end

