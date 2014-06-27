function [ PhiKPlus1, PKPlus1 ] = Iterate( PhiK, PK, StepP, StepD, Input, LabelQuantification )
%Find phi_k+1 and p_k+1 out of phi_k and p_k

Sx = size(PK, 1);
Sy = size(PK, 2);
Sz = size(PK, 3);

options.bound = 'sym';
options.order = 1;

    %Step1
    PhiKPlus1 = PhiK + StepP * div(PK, options);
    
    %Truncate so it stays in D.
    indexes = PhiKPlus1(:,:,:) < 0;
    PhiKPlus1(indexes == true) = 0;
    indexes = PhiKPlus1(:,:,:) > 1;
    PhiKPlus1(indexes == true) = 1;
    %PhiKPlus1 = (PhiKPlus1>0).*( (PhiKPlus1<1).*PhiKPlus1+(PhiKPlus1>=1) );
    PhiKPlus1(:,:,1) = 1;
    PhiKPlus1(:,:,end) = 0;
    
    
    %Step2
    PKPlus1 = PK + StepD * grad(PhiKPlus1, options);
    
    %Project on C.
    for i=1:Sx
        for j=1:Sy
            for k=1:Sz
                denom = max(1, sqrt(PKPlus1(i, j, k, 1)^2 + PKPlus1(i, j, k, 2)^2));
                PKPlus1(i, j, k, 1) = PKPlus1(i, j, k, 1) / max(1, abs(PKPlus1(i, j, k, 1)));%denom;%
                PKPlus1(i, j, k, 2) = PKPlus1(i, j, k, 2) / max(1, abs(PKPlus1(i, j, k, 2)));%denom;%
                PKPlus1(i, j, k, 3) = PKPlus1(i, j, k, 3) / max(1, abs(PKPlus1(i, j, k, 3)) / Rayleigh(Input(i, j), LabelQuantification(k)));
            end
        end
    end

end

