function [ b0idx, n_b0, acqp] = extractB0s(dwi_path, bval_path, sc_path, out_b0_path)
% 
% Extact B0 volumes from 4D stack. Also, for each b0 stores relevant
% acquisition parameters,
% 
% Usage:
%    [ b0idx, n_b0, acqp] = extractB0s(vol, bval_file, sc_file, tmp_b0_path)
% 
% Inputs:
%   vol          path to 4d dwi stack   
%   bval_file    path to bvalue file
%   sc_file      path to sidecar file
%   tmp_b0_path  output b0 4d stack
% 
% Outputs
%   b0idx        indices of the b0 voluems in the 4d dwi stack
%   n_b0         total number of b0s
%   acqp         1x4 matrix containing phase encoding information and
%                Dwell number.
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Start loading the data

bval = load_bVal(bval_path);
sc = read_sc(sc_path);
dwi = load_untouch_nii(dwi_path);

%% Do the job

% Get the b0 indices
b0idx = find(~bval);
% How many b0s?
n_b0 = length(b0idx);
% Create a NIfTI structure and retain only b0s.
b0 = dwi;
b0.img = b0.img(:,:,:,b0idx);
b0.hdr.dime.dim(5) = n_b0;

% save the output
save_untouch_nii(b0, out_b0_path);

%% Save the acqp parameters

acqp = zeros(1,4);
ped = sc.PhaseEncodingDirection;
% Get the PE direction
if strcmp(ped(1), 'i')
    acqp(1) = 1;
elseif strcmp(ped(1), 'j')
    acqp(2) = 1;
elseif strcmp(ped(1), 'k')
    acqp(3) = 1;
end
% Get the PE "verse"
if strcmp(ped(end), '-')
    acqp = -1 * acqp;
end

%%

% Now let's get the Dwell time
% Keep in mind thaa this doesn't matter as long as the volumes have been
% acquired with same readout times (which should cover most of the cases).

% Anyway, to do things right: there are different ways to get last parameter:

% 1.    Prduct of "Echo spacing (in seconds)" and "EPI factor"
%       To my understanding the "EPI factor" should correspond to the fields
%       "AcquisitionMatrixPE" or "ReconMatrixPE" (which are the same).
%       The "Echo spacing" can be chosen between the following fileds:
%       "EffectiveEchoSpacing" or "DerivedVendorReportedEchoSpacing" (which
%       are different). The latter corresponds to the one found in the PDF
%       doucment.

% combination a)
% acqp(4) = sc.AcquisitionMatrixPE*sc.EffectiveEchoSpacing;
% combination b)
acqp(4) = sc.AcquisitionMatrixPE*sc.DerivedVendorReportedEchoSpacing;

% 2.    Another way is to take the inverse of the reciprocal of the PE
%       bandwidth/pixel.

% combination c)
% acqp(4) = 1/sc.BandwidthPerPixelPhaseEncode;

% 3.    Finally it can be calculated as the "dwell time" multiplied by 
%       "number of PE steps - 1" .

% combination d) (THIS LOOK REALLY WRONG!)
% acqp(4) = (sc.PhaseEncodingSteps-1)*sc.DwellTime;

% Combination a) and c) are the same. Combination a) is the one that can be
% obtained from the scannedPDF report...I'll use that.




