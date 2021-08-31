function [prepData, status] = anatDataPrep(anatData, logFile)
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

%% Assigne a step title
stepTitle = 'Anatomical data preparation';

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
fprintf('Reorienting T1w image to AC-PC convention...');
tic

% define the output as a structure
prepData = struct();

% define the output name
[t1w_path, t1w_name] = niftiFileParts(anatData.t1w);
prepData.t1w = fullfile(t1w_path, sprintf('%s_prep.nii.gz', t1w_name));

% Check if the file already exists, if so return with a warning
if ~exist(prepData.t1w, 'file')
    % Define the command for data preparation
    t1w_prep_cmd = ['acpc_align --in=' anatData.t1w, ...
        ' --out=' prepData.t1w];
    
    % Run the command
    [status, result] = runSystemCmd(t1w_prep_cmd, 0, 0);
else
    warning('file %s already exist. If you want to carry on with the analysis, consider change name of already existing file or remove it', ...
        prepData.t1w);
    status = 0;
    result = '';
end
fprintf(['    done in ',num2str(toc,'%.2f'),' seconds\n'])

%% If available, repeat the command for the T2w image

if t2w
    fprintf('Reorienting T2w image to AC-PC convention...');
    tic
    
    % define the output name
    [t2w_path, t2w_name] = niftiFileParts(anatData.t2w);
    prepData.t2w = fullfile(t2w_path, sprintf('%s_prep.nii.gz', t2w_name));
    
    if ~exist(prepData.t2w, 'file')
    % Define the command for data preparation
        t2w_prep_cmd = ['acpc_align --in=' anatData.t2w, ...
                                  ' --out=' prepData.t2w, ...
                                  ' --t2w'];
    
    % Run the command
        [t2w_stat, t2w_res] = runSystemCmd(t2w_prep_cmd, 0, 0);
    else
        warning('file %s already exist. If you want to carry on with the analysis, consider change name of already existing file or remove it.', ...
            prepData.t2w);
        t2w_stat = 0;
        t2w_res = '';
    end
    
    % Update status and result of the step
    status = ~(~status * ~t2w_stat);
    result = sprintf('%s\n%s',result, t2w_res);
    fprintf(['    done in ',num2str(toc,'%.2f'),' seconds\n'])
end

%% log the result and check the status

% Log the result into a log file
logResult(stepTitle, result, logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrog in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end