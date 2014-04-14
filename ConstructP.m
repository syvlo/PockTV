function [ P ] = ConstructP( Input, LabelQuantification, Phi )
%Construct an inital p in order to be able to iterate.

    [Height, Width] = size(Input);
    [~,labelsSize] = size(LabelQuantification);
    P = zeros(Height, Width, labelsSize, 3);
  
    %FIXME: Dead code....
    %The idea was to try to do the dual step in order to get the p_init
    %by taking p_k = [0].
    
%     grad = zeros(size(P));
%     for i=1:size(P, 1)
%         for j=1:size(P, 2)
%             for k=1:size(P, 3)
%                 if (i == 2 && j == 2)
%                     test = 0;
%                 end
%                 if (i < size(P, 1))
%                     grad(i, j, k, 1) = Phi(i + 1, j, k) - Phi(i, j, k);
%                 else
%                     grad(i, j, k, 1) = 0;
%                 end
%                 if (j < size(P, 2))
%                     grad(i, j, k, 2) = Phi(i, j + 1, k) - Phi(i, j, k);
%                 else
%                     grad(i, j, k, 2) = 0;
%                 end
%                 if (k < size(P, 3))
%                     grad(i, j, k, 3) = Phi(i, j, k + 1) - Phi(i, j, k);
%                 else
%                     grad(i, j, k, 3) = 0;
%                 end
%             end
%         end
%     end
%     P = P + 1/30 * grad;%FIXME Hardcoded...
%     
%     %Project on C.
%     for i=1:size(P, 1)
%         for j=1:size(P, 2)
%             for k=1:size(P, 3)
%                 denom = max(1, sqrt(P(i, j, k, 1)^2 + P(i, j, k, 1)^2));
%                 P(i, j, k, 1) = P(i, j, k, 1) / denom;
%                 P(i, j, k, 2) = P(i, j, k, 2) / denom;
%                 P(i, j, k, 3) = P(i, j, k, 3) / max(1, abs(P(i, j, k, 3)) / Rayleigh(Input(i, j), LabelQuantification(k)));
%             end
%         end
%     end

    %Init p with fixed values.
    for (i=1:Height)
        for (j=1:Width)
            for (k=1:labelsSize)
%                 P(i, j, k, 1) = rand;
%                 P(i, j, k, 2) = rand;
%                 denom = max(1, sqrt(P(i, j, k, 1)^2 + P(i, j, k, 2)^2));
%                 P(i, j, k, 1) = P(i, j, k, 1) / denom;
%                 P(i, j, k, 2) = P(i, j, k, 2) / denom;
                P(i, j, k, 1) = 1/sqrt(2);
                P(i, j, k, 2) = 1/sqrt(2);
                if(LabelQuantification(k) == 0)
                    P(i, j, k, 3) = 10000; %FIXME, hardcoded...
                else
                    P(i, j, k, 3) = Rayleigh(Input(i, j), LabelQuantification(k));
                end
            end
        end
    end

end

