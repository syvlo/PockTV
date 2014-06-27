%% test Lo�c

I = im2double(imread('cameraman.tif'));%im2double(imread('/home/users/lobry/Images/Toy1/Original.png'));%imaNorm;%
nblabels = 2;
[Phi, labels] = ConstructPhi(I,nblabels+1,max(I(:)));
I2 = ConstructImageFromPhi(Phi,labels);
%newimage([I I2]);

nbiter=1500;
%Phi = ConstructPhi(I*0,nblabels+1,max(I(:)));
%P = zeros(size(I,1),size(I,2),numel(labels),3);
P = InitP( Phi, I, labels );
figure;

t1 = 1/sqrt(3);
t2 = 1/sqrt(3);

for k=1:nbiter
    [Phi, P] = Iterate(Phi, P, t1, t2, I, labels);
    imshow(ConstructImageFromPhi(Phi,labels),[]);%sarimage(uint16(ConstructImageFromPhi(Phi,labels)));%
    colorbar;
    title(sprintf('iter %d',k));
    drawnow;
    pause(1E-3);
end
%newimage([I ConstructImageFromPhi(ConstructPhi(I,nblabels+1,max(I(:))),labels) ConstructImageFromPhi(Phi,labels)]);


%%
InputImage = 'naka3_2.imw';%'cropped.imw'
OutputImageName = 'test';

Input = imw2mat9(InputImage);

fprintf('Constructing phi...');
[PhiInit, Labels] = ConstructPhi(Input);
disp('Done.');
fprintf('Constructiong P...');
P = ConstructP(Input, Labels, PhiInit);
disp('Done.');

[Phi, E] = ComputePhi(PhiInit,P,Input,Labels, 1/30, 1/30);

Output = ConstructImageFromPhi(Phi, Labels);

mat2imw9(uint16(Output), OutputImageName);