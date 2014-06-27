function [ Phi, LabelQuantification ] = ConstructPhi( Input, nblevels, maxlevel )
%Get initial phi. (Basically, translates the input image into phi.

LabelQuantification = linspace(min(Input(:)), maxlevel, nblevels);
%     VMax = max(max(Input));
%     
%     %Quantification step.
%     i = 1;
%     curVal = 0;
%     while (curVal < 0.01)
%         LabelQuantification(i) = curVal;
%         curVal = curVal + 0.0005;
%         i = i + 1;
%     end
%     while (curVal < VMax + 0.0001)
%         LabelQuantification(i) = curVal;
%         curVal = curVal + 0.01;
%         i = i + 1;
%     end
[Height, Width] = size(Input);
nblevels = size(LabelQuantification, 2);
Phi = zeros(Height, Width, nblevels);
for i=1:nblevels-1
    Phi(:,:,i) = Input>=LabelQuantification(i);
end
Phi(:,:,end) = 0;

%     VMax = max(max(Input));
%     
%     %Quantification step.
%     i = 1;
%     curVal = 1;
%     while (curVal < 1000)
%         LabelQuantification(i) = curVal;
%         curVal = curVal + 30;
%         i = i + 1;
%     end
%     while (curVal < VMax + 100)
%         LabelQuantification(i) = curVal;
%         curVal = curVal + 200;
%         i = i + 1;
%     end
% 
%     [Height, Width] = size(Input);
%     [tmp,labelsSize] = size(LabelQuantification);
%     Phi = zeros(Height, Width, labelsSize);
%     
%     %Construction using the layer cake idea.
%     for(i=1:labelsSize)
%         [r, v] = find(Input >= LabelQuantification(i)); %FIX ME: Step to speed up!
%         for (j=1:size(r, 1))
%             Phi(r(j), v(j), i) = 1;
%         end
%     end
    
end

