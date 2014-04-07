InputImage = 'cropped.imw'%'ProjIMA/Images/PileParis/Inputs/Cropped/Eiffel_20090124.imw';%'ProjIMA/Images/ToyRadar/naka3_2.imw'%

Input = imw2mat9(InputImage);

fprintf('Constructing phi...');
[PhiInit, Labels] = ConstructPhi(Input);
disp('Done.');
fprintf('Constructiong P...');
P = ConstructP(Input, Labels);
disp('Done.');

Phi = ComputePhi(PhiInit,P,Input,Labels);

Output = ConstructImageFromPhi(Phi, Labels);

mat2imw9(uint16(Output), 'test');