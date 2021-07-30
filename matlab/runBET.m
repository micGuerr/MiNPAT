function [brain, mask, status] = runBET(b0_file, out_dir, f)
% 
% Runs FSL's BET
%
% Usage:
%  [brain, mask, status] = runBET(b0_file, out_dir, f)
% 
% Input
%   b0_file     b0 image from which to extract the brain. If 4d stack, it
%               first compute the mean across volumes
%   out_dir     output directory.
%   f           fractional intensity threshold (0->1); default=0.5; smaller
%               values give larger brain outline estimates.
% 
% Output:
%   brain       Path to output brain. the name is the same as input, but
%   with        "_brain.nii.gz" suffix.
%   mask        PAth to output mask.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% First check if the output folder exists, if not create it.

if ~exist(out_dir, 'dir')
    mkdir(out_dir);
end

%% Neaxt load the b0 and check if it has a fourth dimension.

b0 = load_untouch_nii(b0_file);
% separate path and name, this will be useful later
[b0_path, b0_name] = niftiFileParts(b0_file);

% if the foutrh dimension is greatr then 1, compute the mean along that dim
if b0.hdr.dime.dim(5) > 1
    % create the output name for the mean of the b0s
    b0_mean = fullfile(b0_path, sprintf('%s_mean.nii.gz', b0_name));
    % the command to obtain the mean
    mean_cmd = sprintf('fslmaths %s -Tmean %s', b0, b0_mean);
    % run the command
    [mean_status] = runSystemCmd(mean_cmd, 0);
    % define a new input for bet
    in_bet = b0_mean;
else
    % else the input doesn't change
    in_bet = b0;
end

%% Run the brain extracion

% define the outputs
brain = fullfile(out_dir, sprintf('%s_brain.nii.gz', b0_name));
mask = fullfile(out_dir, sprintf('%s_brain_mask.nii.gz', b0_name));

% make sure the file don't exist already
if ~exist(brain, 'file')

bet_cmd = sprintf('bet %s %s -m -f %f', ...
                    in_bet, b0_mean, f);
% run the command
[status] = runSystemCmd(bet_cmd, 0);

else
    warning('File %s already exist, BET didn''t run !', brain)
end