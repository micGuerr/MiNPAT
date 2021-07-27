function [prepData, status] = anatDataPrep(anatData)
% 
% Prepares data for anatomcial analysis.
% 1. Reorient anatomical images to FSL template.
% 2. Remove neck and lower part of the head.
%
% Usage:
%  [prepData, status] = anatDataPrep(anatData)
% 
% Input
%   anatData    structure. It must have at least one field called 't1w', in
%               which the path to the T1w image is stored.
%               It can have a second file named 't2w' which stores the path
%               to a T2w image which will be prepared as well.
% 
% 
% Output:
%   prepData    structure with same organization as input but with the path
%               to the prepared imaged.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% First check the input structure fields

% there should be a field named t1w
if ~isfield(anatData, 't1w')
    error('There should be at least one field named ''t1w'' indicating the path to a T1w image.')
end

% The t2w field is optional
t2w = 0;
if isfield(anatData, 't2w')
    t2w = 1;
end

%% Run the data preparation for T1w image

% define the output as a structure
prepData = struct();

% define the output name
[t1w_path, t1w_name] = niftiFileParts(anatData.t1w);
prepData.t1w = fullfile(t1w_path, sprintf('%s_prep', t1w_name));

% Define the command for data preparation
t1w_prep_cmd = ['acpc_align --in=' anatData.t1w, ...
                          ' --out=' prepData.t1w];
                      
% Run the command
status = runSystemCmd(t1w_prep_cmd, 1);

%% If available, repeat the command for the T2w image

if t2w
    % define the output name
    [t2w_path, t2w_name] = niftiFileParts(anatData.t2w);
    prepData.t2w = fullfile(t2w_path, sprintf('%s_prep', t2w_name));
    
    % Define the command for data preparation
    t2w_prep_cmd = ['acpc_align --in=' anatData.t2w, ...
                              ' --out=' prepData.t2w, ...
                              ' --t2w'];
    
    % Run the command
    t2w_status = runSystemCmd(t2w_prep_cmd, 1);
    status = status + t2w_status;
end
