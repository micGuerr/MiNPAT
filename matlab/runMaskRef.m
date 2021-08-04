function [farrm_mask, farrm_dt, status] = runMaskRef(dti, mask, logFile)
% 
% Refine brain mask by removing FA ring
% 
% Usage:
%   [farrm_mask, farrm_dt, status] = runMaskRef(dti, mask)
% 
% Inputs:
%   dti         structure containing paths to outputs from dtifit step.
%   mask        path to old brain mask
% 
% Outputs:
%   farrm_mask  path to updated mask
%   farrm_dt    structure containing all paths to updated diffusion tensor
%               images
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Assigne a step title
stepTitle = 'Brain Mask Refinement';

%% First make sure the file exist

% Let's make sure FA exist
if ~exist( dti.FA, 'file')
    error('FA file %s seems to be missing.', dti.FA);
end


% Let's make sure mask exist
if ~exist( mask, 'file')
    error('Mask file %s seems to be missing.', mask);
end

%% Run te FA ring remove step

% the output
[mask_path, mask_name] = niftiFileParts(mask);
farrm_mask = fullfile(mask_path, sprintf('%s_farrm.nii.gz', mask_name));

[farrm_stat, farrm_res] = runFAring_rm(dti.FA, farrm_mask);

%% Use the refined mask to update DTI output

[farrm_dt, mskdt_stat, mskdt_res] = maskDT(dti, farrm_mask);


%% log the result and check the status

% Update status and result of the step
status = ~(~farrm_stat * ~mskdt_stat);
result = sprintf('%s\n%s',farrm_res, mskdt_res);

% Log the result into a log file
logResult(stepTitle, result, logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrog in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end
