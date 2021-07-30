function [eddy_dwi, eddy_bval, eddy_bvec, status] = runEddy(dwiData, topup, mask, acqp_file, baseName)
% 
% Runs FSL's Eddy
%
% Usage:
%  [eddy_outp, status] = runEddy(dwiData, topup, mask, parall)
% 
% Input
%   dwiData     structure.
%   topup       Output of topup step.
%   mask        path to brain mask
%   parall      number of cores to be used for paralle computing. Leave
%               empty if no parallelization is requred.
% 
% Output:
%   eddy_outp   structure in which are stored the paths to topup outputs.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% First thing, let's parse the DWI acquisition information. 
%  Let's check everything needed is there.


% The fields "vol", "bval", "bvec", "sc" are expected for each acquisition
CheckDwiDataFields(dwiData)

% Let's make sure that topup run
if ~exist( [topup, '_fieldcoef.nii.gz'], 'file')
    error('Output from topup seems to be missing');
end

% Let's make sure that bet run
if ~exist( mask, 'file')
    error('Output from bet seems to be missing');
end

%% Next, check the output folder exists. If not create it

% extract topup folder from the baseName
[eddyDir] = fileparts(baseName);

if ~exist(eddyDir, 'dir')
    mkdir(eddyDir);
end


%% Let's now merge all the diffusion volumes together.
% We also need to merge the b-values and bvecs.

% the output being
all_dwis_path = sprintf(eddyDir, 'allDwis.nii.gz');
all_bval_path = sprintf(eddyDir, 'allBval.bval');
all_bvec_path = sprintf(eddyDir, 'allBvec.bvec');

[mrg_status, mrg_res] = mergeDwiData(dwiData, all_dwis_path, all_bval_path, all_bvec_path);


%% Now let's define the idx file. This should have an index correpsonding 
% to the line ...

% define the output indices file
idx_path = fullfile(eddyDir, 'inidices.txt');

getEddyIdxFile(all_dwis_path, all_bval_path, idx_path);


%% Run Eddy

% First define the outputs
eddy_dwi = [baseName '.nii.gz'];
eddy_bvec = [baseName '.eddy_rotated_bvecs'];
eddy_bval = [baseName '.eddy_bvals'];

% there are two ways to combine the dwi data. This depends on whether
% the acquisition images have exactly the same acquisition params or not

% Check if the acquisition protocols are the same
is_eq = isSameProtcol(dwiData);

% based on this the output will have same dimension of the input (no lsr)
% or will have same dimension of a single acquistion input (lsr)
acqs = fieldnames(dwiData);
if ~exist(eddy_bval, 'file')
    if is_eq
        copyfile(dwiData.(acqs{1}).bval, eddy_bval);
    else
        copyfile(all_bval_path, eddy_bval);
    end
else
    warning('file %s already exist', eddy_bval);
end


    % If everything is equal then use "Least-Squares Restoration".
[status, result] = runEddyCmd(all_dwis_path, all_bval_path, all_bvec_path, mask, ...
                                acqp_file, idx_path, topup, ...
                                    is_eq, baseName);

