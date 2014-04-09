function [ PhiKPlus1, PKPlus1 ] = Iterate( PhiK, PK, StepP, StepD, Input, LabelQuantification )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    %Step1
    div = zeros(size(PhiK));
    for i=1:size(PK, 1)
        for j=1:size(PK, 2)
            for k=1:size(PK, 3)
                if (i == 2 && j == 2)
                    IDiff = 0;
                end
                if (i > 1)
                    IDiff = PK(i, j, k, 1) - PK(i - 1, j, k, 1);
                else
                    IDiff = 0;
                end
                if (j > 1)
                    JDiff = PK(i, j, k, 2) - PK(i, j - 1, k, 2);
                else
                    JDiff = 0;
                end
                if (k > 1)
                    KDiff = PK(i, j, k, 3) - PK(i, j, k - 1, 3);
                    Delta = LabelQuantification(k) - LabelQuantification(k - 1);
                else
                    KDiff = 0;
                    Delta = LabelQuantification(2) - LabelQuantification(1);
                end
                div(i, j, k) =  IDiff + JDiff + KDiff / Delta;%FIXME hardcoded...
            end
        end
    end
    PhiKPlus1 = PhiK + StepP .* div;
    
    %Truncate so it stays in D.
    indexes = PhiKPlus1(:,:,:) < 0;
    PhiKPlus1(indexes == true) = 0;
    indexes = PhiKPlus1(:,:,:) > 1;
    PhiKPlus1(indexes == true) = 1;
    PhiKPlus1(:,:,1) = ones(size(PhiK, 1), size(PhiK, 2));
    PhiKPlus1(:,:,size(PhiK, 3)) = zeros(size(PhiK, 1), size(PhiK, 2));
    
    
    %Step2
    grad = zeros(size(PK));
    for i=1:size(PK, 1)
        for j=1:size(PK, 2)
            for k=1:size(PK, 3)
                if (i == 2 && j == 2)
                    test = 0;
                end
                if (i < size(PK, 1))
                    grad(i, j, k, 1) = PhiK(i + 1, j, k) - PhiK(i, j, k);
                else
                    grad(i, j, k, 1) = 0;
                end
                if (j < size(PK, 2))
                    grad(i, j, k, 2) = PhiK(i, j + 1, k) - PhiK(i, j, k);
                else
                    grad(i, j, k, 2) = 0;
                end
                if (k < size(PK, 3))
                    grad(i, j, k, 3) = PhiK(i, j, k + 1) - PhiK(i, j, k);
                else
                    grad(i, j, k, 3) = 0;
                end
            end
        end
    end
    PKPlus1 = PK + StepD * grad;
    
    %Project on C.
    for i=1:size(PK, 1)
        for j=1:size(PK, 2)
            for k=1:size(PK, 3)
                denom = max(1, sqrt(PKPlus1(i, j, k, 1)^2 + PKPlus1(i, j, k, 1)^2));
                PKPlus1(i, j, k, 1) = PKPlus1(i, j, k, 1) / denom;
                PKPlus1(i, j, k, 2) = PKPlus1(i, j, k, 2) / denom;
                PKPlus1(i, j, k, 3) = PKPlus1(i, j, k, 3) / max(1, abs(PKPlus1(i, j, k, 3)) / Rayleigh(Input(i, j), LabelQuantification(k)));
            end
        end
    end

end

