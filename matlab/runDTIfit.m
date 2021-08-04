function [dti, status] = runDTIfit(dwi, bval, bvec, mask, outpath, logFile)
% 
% Runs FSL's DTIFIT
%
% Usage:
%  [dti, status] = runDTIfit(dwi, bval, bvec, mask, outpath)
% 
% Input
%   dwi         Path to diffusion data.
%   bval        path to b-values file.
%   bvec        path to b-values file.
%   mask        path to brain mask.
%   outpath     path and basename to dti output.
% 
% Output:
%   dti         structure in which are stored the paths to dtifit outputs.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Assigne a step title
stepTitle = 'DTI FIT';

%% First, let's check all the input file exist

% check dwi data
if ~exist( dwi, 'file')
    error('File %s doe''t exist', dwi);
end

% check b-values 
if ~exist( bval, 'file')
    error('File %s doe''t exist', bval);
end

% check b-vectors 
if ~exist( bvec, 'file')
    error('File %s doe''t exist', bvec);
end

% Let's make sure that bet run
if ~exist( mask, 'file')
    error('File %s doe''t exist', mask);
end

%% Next, check the output folder exists. If not create it

% extract topup folder from the baseName
[dtiDir] = fileparts(outpath);

if ~exist(dtiDir, 'dir')
    mkdir(dtiDir);
end

%% DTI shouldn't use b-values higher than 1500 s/mm^2. Split the data if 
% needed and define the DTI input.

dtiInPath = fullfile(dtiDir, 'inputData', 'lt_1500_dwi');


% Split the data if needed else create soft link to input data folder
[dti_in_dwi, dti_in_bval, dti_in_bvec] = getDTIinput(dwi, bval, bvec, dtiInPath);


%% Run DTIFIT

% Run the commnad
[dti, status, result] = runDTIfit_cmd(dti_in_dwi, dti_in_bval, dti_in_bvec, mask, outpath);


%% log the result and check the status

% Log the result into a log file
logResult(stepTitle, result, logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrog in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end