function [ PhiKPlus1, PKPlus1 ] = Iterate( PhiK, PK, StepP, StepD, Input, LabelQuantification, LabelsMat )
%Find phi_k+1 and p_k+1 out of phi_k and p_k

Sx = size(PK, 1);
Sy = size(PK, 2);
Sz = size(PK, 3);


    %Step1
    ticphi = tic;
	IShift1 = cat(1, PK(1:Sx - 1, :, :, 1), zeros(2,Sy,Sz));
	IShift2 = cat(1, zeros(1,Sy,Sz), PK(:,:,:,1));
	IDiff = IShift1 - IShift2;
	IDiff = IDiff(1:Sx,:,:);

	JShift1 = cat(2, PK(:, 1:Sy - 1, :,2), zeros(Sx, 2, Sz));
	JShift2 = cat(2, zeros(Sx, 1, Sz), PK(:,:,:,2));
	JDiff = JShift1 - JShift2;
	JDiff = JDiff(:, 1:Sy, :);

	ZShift1 = cat(3, PK(:, :, 1:Sz - 1,3), zeros(Sx, Sy, 2));
	ZShift2 = cat(3, zeros(Sx, Sy, 1), PK(:,:,:,3));
	ZDiff = ZShift1 - ZShift2;
	%Warning! Assume that all quantification steps are equally distributed.
	ZDiff = ZDiff(:, :, 1:Sz) / (LabelQuantification(2)-LabelQuantification(1));

	div = IDiff + JDiff + ZDiff;
   	PhiKPlus1 = PhiK + StepP * div;	%(PK);

    %Truncate so it stays in D.
    indexes = PhiKPlus1(:,:,:) < 0;
    PhiKPlus1(indexes == true) = 0;
    indexes = PhiKPlus1(:,:,:) > 1;
    PhiKPlus1(indexes == true) = 1;
    %PhiKPlus1 = (PhiKPlus1>0).*( (PhiKPlus1<1).*PhiKPlus1+(PhiKPlus1>=1) );
    PhiKPlus1(:,:,1) = 1;
    PhiKPlus1(:,:,end) = 0;
    toc(ticphi);

	%Step2
    ticp = tic;
	IShift1 = cat(1, PhiKPlus1, zeros(1,Sy,Sz));
	IShift2 = cat(1, zeros(1,Sy,Sz), PhiKPlus1);
	IDiff = IShift1 - IShift2;
	IDiff = IDiff(2:Sx, :, :);
	IDiff = cat(1, IDiff, zeros(1, Sy, Sz));
	grad(:,:,:, 1) = IDiff;

	JShift1 = cat(2, PhiKPlus1, zeros(Sx,1,Sz));
	JShift2 = cat(2, zeros(Sx,1,Sz), PhiKPlus1);
	JDiff = JShift1 - JShift2;
	JDiff = JDiff(:, 2:Sy, :);
	JDiff = cat(2, JDiff, zeros(Sx, 1, Sz));
	grad(:,:,:, 2) = JDiff;

	KShift1 = cat(3, PhiKPlus1, zeros(Sx,Sy,1));
	KShift2 = cat(3, zeros(Sx,Sy,1), PhiKPlus1);
	KDiff = KShift1 - KShift2;
	KDiff = KDiff(:, :, 2:Sz);
	KDiff = cat(3, KDiff, zeros(Sx, Sy, 1));
	grad(:,:,:, 3) = KDiff/ (LabelQuantification(2)-LabelQuantification(1));

    PKPlus1 = PK + StepD * grad; %(PhiKPlus1);
    
    %Project on C.
    RayleighV = Rayleigh(repmat(Input, [1 1 size(LabelsMat, 3)]), LabelsMat);
    %Denom = max(1, sqrt(PKPlus1(:,:,:,1) .^ 2 + PKPlus1(:,:,:,2) .^ 2));
    PKPlus1(:,:,:,1) = PKPlus1(:,:,:,1) ./ max(1, abs(PKPlus1(:,:,:,1)));
    PKPlus1(:,:,:,2) = PKPlus1(:,:,:,2) ./ max(1, abs(PKPlus1(:,:,:,2)));
    PKPlus1(:,:,:,3) = PKPlus1(:,:,:,3) ./ max(1, abs(PKPlus1(:,:,:,3)) ./ RayleighV);
    toc(ticp);
end

