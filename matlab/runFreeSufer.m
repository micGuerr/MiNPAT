function [status] = runFreeSufer(anatData, fsDir ,fsID, nCores, logFile)
% 
% Runs freeSurfer analysis
%
% Usage:
%  [status] = runFreeSufer(anatData, fsDir, fsID, nCores)
% 
% Input
%   anatData    structure. It must have at least one field called 't1w', in
%               which the path to the T1w image is stored.
%               It can have a second file named 't2w' which stores the path
%               to a T2w image and which will be used to improve the
%               analsysis.
%   fsDir       is the SUBJECT_DIR folder where to run the analysis
%   fsID        ID to use in the analysis.
%   nCores      int. number of cores to be used for paralle computing. Leave
%               empty if no parallelization is requred.
% 
% Output:
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

% Check also if the FreeSurfer directory exists, if not creat it
if ~exist(fsDir, 'dir')
    mkdir(fsDir)
end
%% Run FreeSurfer command

% First check if the output is already there
fsOutput = fullfile(fsDir, fsID, 'mri', 'aparc+aseg.mgz');

if ~exist(fsOutput, 'file')
    % define basic command
    fs_cmd = ['recon-all -subject ' fsID, ...
                       ' -sd ' fsDir, ...
                       ' -i ' anatData.t1w, ...
                       ' -all'];
    % add T2w processing if t2w image is available
    if t2w
        fs_cmd = [fs_cmd ' -T2 ' anatData.t2w, ...
                         ' -T2pial'];
    end
    % add parallel computing if number of cores is not empty
    if ~isempty(nCores)
        fs_cmd = [fs_cmd ' -parallel ', ...
                         ' -openmp ' int2str(nCores)];
    end
    % and run the command
    fprintf('Running freesurfer recon (several hours to go)...');
    tic
    status = runSystemCmd(fs_cmd, 0, 0);
    hours=floor(toc/3600);
    minutes=floor(toc/60-hours*60);
    seconds=toc-hours*3600-minutes*60;
    fprintf(['    done in ',num2str(hours,'%.0f'),' hours, ',num2str(minutes,'%.0f'),' minutes and ',num2str(seconds,'%.0f'),' seconds\n'])
else
    warning('FreeSurfer output for ID %s already exist. If you want to carry on with the analysis, consider changing name of the subject folder already  or remove it', ...
        fsID);
    status = 0;
end

%% log the result and check the status

% Istead of writing the result on logfile, copy the logFile from FS
% analysis

% the new file is
[logFile_path, logFile_name] =fileparts(logFile);
fs_logFile = fullfile(logFile_path, sprintf('%s_fs.txt', logFile_name));
% the original log file is
orig_fsLogFile = fullfile(fsDir ,fsID, 'scripts', 'recon-all.log');
% copy the log file
copyfile(orig_fsLogFile, fs_logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrong in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end
