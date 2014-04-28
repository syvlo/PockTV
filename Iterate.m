function [ PhiKPlus1, PKPlus1 ] = Iterate( PhiK, PK, StepP, StepD, Input, LabelQuantification )
%Find phi_k+1 and p_k+1 out of phi_k and p_k

Sx = size(PK, 1);
Sy = size(PK, 2);
Sz = size(PK, 3);

    %Step1
    div = zeros(size(PhiK));
    for i=1:Sx
        for j=1:Sy
            for k=1:Sz
                
                if(i==1)
                    IDiff = PK(i, j, k, 1);
                end
                if(i==Sx)
                    IDiff = -PK(i-1, j, k, 1);
                else
                    if (i > 1)
                        IDiff = PK(i, j, k, 1) - PK(i - 1, j, k, 1);
                    end
                end

                if(j==1)
                    JDiff = PK(i, j, k, 2);
                end
                if(j==Sy)
                    JDiff = -PK(i, j-1, k, 2);
                else
                    if (j > 1)
                        JDiff = PK(i, j, k, 2) - PK(i, j-1, k, 2);
                    end
                end

                if(k==1)
                    KDiff = PK(i, j, k, 3)/(LabelQuantification(2)-LabelQuantification(1)) ;
                end
                if(k==Sz)
                    KDiff = -PK(i, j, k-1, 3)/(LabelQuantification(end)-LabelQuantification(end-1));
                else
                    if (k > 1)
                        KDiff = PK(i, j, k, 3)/(LabelQuantification(k+1)-LabelQuantification(k))...
                                     - PK(i, j, k-1, 3)/(LabelQuantification(k)-LabelQuantification(k-1));
                    end
                end
                
                div(i, j, k) =  IDiff + JDiff + KDiff;
            end
        end
    end
    PhiKPlus1 = PhiK + StepP * div;%(PK);
    
    %Truncate so it stays in D.
    indexes = PhiKPlus1(:,:,:) < 0;
    PhiKPlus1(indexes == true) = 0;
    indexes = PhiKPlus1(:,:,:) > 1;
    PhiKPlus1(indexes == true) = 1;
    PhiKPlus1 = (PhiKPlus1>0).*( (PhiKPlus1<1).*PhiKPlus1+(PhiKPlus1>=1) );
    PhiKPlus1(:,:,1) = 1;
    PhiKPlus1(:,:,end) = 0;
    
    
    %Step2
    grad = zeros(size(PK));
    for i=1:Sx
        for j=1:Sy
            for k=1:Sz
                if (i < Sx)
                    grad(i, j, k, 1) = PhiKPlus1(i + 1, j, k) - PhiKPlus1(i, j, k);
                else
                    grad(i, j, k, 1) = 0;
                end
                if (j < Sy)
                    grad(i, j, k, 2) = PhiKPlus1(i, j + 1, k) - PhiKPlus1(i, j, k);
                else
                    grad(i, j, k, 2) = 0;
                end
                if (k < Sz)
                    grad(i, j, k, 3) = (PhiKPlus1(i, j, k + 1) - PhiKPlus1(i, j, k))/(LabelQuantification(k+1) - LabelQuantification(k));
                else
                    grad(i, j, k, 3) = 0;
                end
            end
        end
    end
    PKPlus1 = PK + StepD * grad;%(PhiKPlus1);
    
    %Project on C.
    for i=1:Sx
        for j=1:Sy
            for k=1:Sz
                denom = max(1, sqrt(PKPlus1(i, j, k, 1)^2 + PKPlus1(i, j, k, 2)^2));
                PKPlus1(i, j, k, 1) = PKPlus1(i, j, k, 1) / denom;
                PKPlus1(i, j, k, 2) = PKPlus1(i, j, k, 2) / denom;
                PKPlus1(i, j, k, 3) = PKPlus1(i, j, k, 3) / max(1, abs(PKPlus1(i, j, k, 3)) / Rayleigh(Input(i, j), LabelQuantification(k)));
            end
        end
    end

end

