function P = InitP( Phi, Input, LabelQuantification, StepD )
% compute initial value for P

options.bound = 'sym';
options.order = 1;
P = StepD * grad(Phi, options);
    
    %Project on C.
    for i=1:size(P, 1)
        for j=1:size(P, 2)
            for k=1:size(P, 3)
                denom = max(1, sqrt(P(i, j, k, 1)^2 + P(i, j, k, 2)^2));
                P(i, j, k, 1) = P(i, j, k, 1) / max(1, abs(P(i, j, k, 1)));%denom;%
                P(i, j, k, 2) = P(i, j, k, 2) / max(1, abs(P(i, j, k, 2)));%denom;%
                P(i, j, k, 3) = P(i, j, k, 3) / max(1, abs(P(i, j, k, 3)) / Rayleigh(Input(i, j), LabelQuantification(k)));
            end
        end
    end

end

