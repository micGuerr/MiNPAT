function splitDWI_byB(fullDwi, fullBval, fullBvec, splitDwi, splitBval, splitBvec, b_trh)
% 
% Split a diffusion 4D stack based on a threshold b value (b_threshold).
% If b_threshold is positive takes all the volumes with b > b_threshold.
% If b_threshold is negative takes all the volumes with b < - b_threshold.
% Outputs matched bvalue file and bvec file.
%
% Usage:
%   splitDWI_byB(fullDwi, fullBval, fullBvec, splitDwi, splitBval, splitBvec, b_trh)
% 
% Inputs:
%   fullDwi     path to full 4D dwi stack.
%   fullBval    path to full b-value.
%   fullBvec    path to full b-vctors.
%   splitDwi    path to spluitted dwi.
%   splitBval   path to splitted bval.
%   splitBvec   path to splitted bvecs.
%   b_trh       b threshold.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)


%% Load the full data

dwi = load_untouch_nii(fullDwi);
bval = load_bVal(fullBval);
bvec = importdata(fullBvec);


% check dimensions match
if dwi.hdr.dime.dim(5) ~= size(bval, 2) || dwi.hdr.dime.dim(5) ~= size(bvec, 2)
    error('Dimension mismatch !!');
end
%% Get the volume indices

if b_trh > 0
    idx = find(bval > b_trh);
elseif b_trh < 0
    idx = find(bval < - b_trh);
elseif b_trh == 0
    idx = find(bval == b_trh);
end

% Split and save dwis
dwi.img = dwi.img(:,:,:,idx);
dwi.hdr.dime.dim(5) = length(idx);
save_untouch_nii(dwi, splitDwi);

% split and save bValues
bval = bval(idx);
mk_bvalFile(bval, splitBval);

% split and save bValues
bvec = bvec(:,idx);
mk_bvecFile(bvec, splitBvec);