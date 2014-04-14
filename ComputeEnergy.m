function [ E ] = ComputeEnergy( Input, Image, Labels )
%Compute the energy (debugging purposes).
    E = 0;
    
    for i=1:size(Image, 1)
        for j=1:size(Image,2)
            %DataTerm
            R = Rayleigh(Input(i, j), Image(i, j));
            if (isnan(R))
                R = 10000;
            end
            E = E + R;
            %TV:
            if (i > 1)
                E = E + abs(Image(i, j) - Image(i - 1, j));
            end
            if (i < size(Image, 1))
                E = E + abs(Image(i + 1, j) - Image(i, j));
            end
            if (j > 1)
                E = E + abs(Image(i, j) - Image(i, j - 1));
            end
            if (j < size(Image, 2))
                E = E + abs(Image(i, j + 1) - Image(i, j));
            end
        end
    end

end

