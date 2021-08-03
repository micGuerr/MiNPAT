function [rfield, unwarp_b0, acqp_file, status] = runTopup(dwiData, config, baseName)
% 
% Runs FSL's topup utility
%
% Usage:
%  [topup_outp, status] = runTopup(dwiData)
% 
% Input
%   dwiData         structure...
%   config          ...
%   baseName        is the path and base name in which to save topup output
% 
% Output:
%   rfield  
%   unwarp_b0   
%   acqp_file   structure in which are stored the paths to topup outputs.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

global FSLPATH

%% First thing, let's parse the DWI acquisition information. 
%  Let's check everything needed is there.

CheckDwiDataFields(dwiData)


% Let's also check if topup configuration file is input. If not use default
if isempty(config)
    config = fullfile(FSLPATH,'src','topup','flirtsch','b02b0.cnf');
end

%% Next, check the output folder exists. If not create it

% extract topup folder from the baseName
[topupDir] = fileparts(baseName);

if ~exist(topupDir, 'dir')
    mkdir(topupDir);
end

%% Now, for each acquisition we need to extract the b0s and store some extra info

b0 = getTopupB0s(dwiData, topupDir);

%% Let's merge the b0 volumes together

% the output name is:
all_b0s_path = fullfile(topupDir, 'all_b0.nii.gz');

% merge the b0s
[mrg_cmd, mrg_status] = mergeDwiData(b0, all_b0s_path, [], []);

%% Now let's put the acquisition parameters in a file

% define the output
acqp_file = fullfile(topupDir, 'acqp.txt');

% get the file
getTopupAcqpFile(b0, acqp_file);


%% Finally we can run the Topup command

% Define the outputs
rfield = sprintf('%s_rfield.nii.gz', baseName);
unwarp_b0 = sprintf('%s_b0unwarp.nii.gz', baseName);

% there are two ways to obtain the the unwarped images, depends on whether
% the "blip-Up" and "blip-down" images ave exactly the same acquisition params or not

% Check if the acquisition protocols are the same
is_eq = isSameProtcol(dwiData);

if is_eq
    % If everything is equal then use "Least-Squares Restoration".
    [status] = runTopup_lsr(all_b0s_path, acqp_file, b0, config, baseName, rfield, unwarp_b0);
else
    % else use Jacobian method
    [status] = runTopup_jac(all_b0s_path, acqp_file, config, baseName, rfield, unwarp_b0);
end






