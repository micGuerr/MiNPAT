function [brain, mask, status] = runBET(b0_file, out_dir, f, logFile)
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

%% Assigne a step title
stepTitle = 'Rough brain extraction';

%% First check if the output folder exists, if not create it.

if ~exist(out_dir, 'dir')
    mkdir(out_dir);
end

%% If the b0 has a fourth dimension, compute mean along that direction.

% load the b0
b0 = load_untouch_nii(b0_file);
% check the dimensionality and set bet input
if b0.hdr.dime.dim(5) > 1
    [in_bet, tmean_stat, tmean_res] = compute_tMean(b0_file);
else
    in_bet = b0_file;
end

%% Run the brain extracion

[b0_path, b0_name] = niftiFileParts(b0_file);

% define the outputs
brain = fullfile(out_dir, sprintf('%s_brain.nii.gz', b0_name));
mask = fullfile(out_dir, sprintf('%s_brain_mask.nii.gz', b0_name));

% Run bet command
[bet_stat, bet_res] = runBet_cmd(in_bet, brain, f);

%% log the result and check the status

% Update status and result of the step
status = ~(~tmean_stat * ~bet_stat);
result = sprintf('%s\n%s',tmean_res, bet_res);

% Log the result into a log file
logResult(stepTitle, result, logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrog in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end
