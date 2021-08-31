function [bfcData, status] = biasFieldCorrection(biasedData, logFile)
% 
% Correct anatomical data for bias field inhomogeneities. If available it
% uses both a T1w and a T2w image.
%
% Usage:
%  [bfcData, status] = biasFieldCorrection(biasedData)
% 
% Input
%   biasedData  structure. It must have at least one field called 't1w', in
%               which the path to the T1w image is stored.
%               It can have a second file named 't2w' which stores the path
%               to a T2w image and which will be used for bias field
%               coorection.
% 
% Output:
%   bfcData    structure with same organization as input but with the path
%               to the bfc imaged.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Assigne a step title
stepTitle = 'Bias field correction';

%% First check the input structure fields

% there should be a field named t1w
if ~isfield(biasedData, 't1w')
    error('There should be at least one field named ''t1w'' indicating the path to a T1w image.')
end

% The t2w field is optional
t2w = 0;
if isfield(biasedData, 't2w')
    t2w = 1;
end

%% Define the bias corrected T1w image output

bfcData = struct();

[t1w_path, t1w_name] = niftiFileParts(biasedData.t1w);
bfcData.t1w = fullfile(t1w_path, sprintf('%s_bfc.nii.gz', t1w_name));

%% Define and run the command. This depends on whether there is or not the T2w image
fprintf('Correcting for bias field...');
tic

% Check 
if ~exist(bfcData.t1w, 'file')
    if t2w
        % Define the output for t2w
        [t2w_path, t2w_name] = niftiFileParts(biasedData.t2w);
        bfcData.t2w = fullfile(t2w_path, sprintf('%s_bfc.nii.gz', t2w_name));

        % define the command
        bfc_cmd = ['biasField_rm --in=' biasedData.t1w, ...
                               ' --t2w=' biasedData.t2w, ...
                               ' --out=' bfcData.t1w, ...
                               ' --outT2w=' bfcData.t2w, ...
                               ' --noReorient'];

        % run the bfc
        [status, result] = runSystemCmd(bfc_cmd, 0, 0); 
        fprintf(['    done in ',num2str(toc,'%.2f'),' seconds\n'])
    else
        % define the command
        bfc_cmd = ['biasField_rm --in=' biasedData.t1w, ...
                               ' --out=' bfcData.t1w, ...
                               ' --noReorient'];

        % run the bfc
        [status, result] = runSystemCmd(bfc_cmd, 0, 0); 
        fprintf(['    done in ',num2str(toc,'%.2f'),' seconds\n'])
    end
else
    % need to return the t2w output name anyway
    if t2w
        % Define the output for t2w
        [t2w_path, t2w_name] = niftiFileParts(biasedData.t2w);
        bfcData.t2w = fullfile(t2w_path, sprintf('%s_bfc.nii.gz', t2w_name));
    end
    warning('file %s already exist. If you want to carry on with the analysis, consider change name of already existing file or remove it.', ...
        bfcData.t1w);
    status = 0;
    result = '';
end

%% log the result and check the status

% Log the result into a log file
logResult(stepTitle, result, logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrog in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end