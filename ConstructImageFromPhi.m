function [ Output ] = ConstructImageFromPhi( Phi, LabeLQuantification )
%Construct the ouptut image out of function phi.

    %Is it a good choice? Normally every value in [0;1] should work...
    Thresh = 0.9;
    
    Output = zeros(size(Phi, 1), size(Phi, 2)) + LabeLQuantification(1);
    
    %Use layer cake formula.
    for (i=2:size(LabeLQuantification, 2))
        B = double(Phi(:,:,i) > Thresh);
        Output = Output + (LabeLQuantification(i) - LabeLQuantification(i - 1)) .* B;
    end

end

