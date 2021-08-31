function startNewSesAnalysis(subID, sesID, dcm_subID, dcm_sesID, dcm2nii_configFile, dxc2nii_exclCriter, n_cores)
% 
% Initialize a new session level analysis. Enter empty values if there are
% fileds you don't want to include
% 
% Usage:
%   startNewSesAnalysis(subID, sesID, dcm_subID, dcm_sesID, dcm2nii_configFile, dxc2nii_exclCriter, n_cores)
% 
% Inputs:
% subID                 Subject ID you want to assign to a subject.
% sesID                 Session Id you want to assign to a subject
% dcm_subID             Name of the folder where DICOM data of this subject
%                       is stored (NOT the path!).
% dcm_sesID             Name of the folder where DICOM data of this session
%                       is stored (NOT the path!).
% dcm2nii_configFile    Path to configuration file for dcm2bids converison.
%                       Must be in .json format
% dxc2nii_exclCriter    Exclusion critera for files you don't want to
%                       include.
% n_cores               Number of cores you would like to use in parallel
%                       computing. leave empty in case no parallelization 
%                       is needed. 
% 
% 
% Outputs:
%   The following folders and files will be created:
% 
%   <processingFolder_path>
%   ????????? logs/
%     ???? ????????? sub-<subID>
%    ?? ??     ????????? ses-<sesID>
%     ????     ???   ????????? sub-<subID>_ses-<sesID>_log.txt
%     ????     ????????? log_subXXX.m
%
% 
%   sub-<subID>/                Is the folder in which the unprocessed (raw) 
%                           data will be stored after conversion fron DICOM
%                           to NIfTI format.
%   log_subXXX.m
%   ses-<sesID>/        Is the folder in which the output from 
%                           population level analysis will be stored.
%   sub-<subID>_ses-<sesID>_log.txt      
%
%
% More info:
%   https://github.com/micGuerr/LongitudinalMRI/blob/main/
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

global PROCESSDIR DICOMDIR RAWDIR SUBANDIR SUBJECTS_DIR
global MINPAT

fprintf(['Initializing session ', sesID, ' of subject ', subID, '...    '])

% Setup of the paths
pathSetup();

log_dir = fullfile(PROCESSDIR, 'logs');

%% Create the subject folder for storing logs

sub_dir = fullfile(log_dir, sprintf('sub-%s',subID));
if ~exist(sub_dir, 'dir')
    mkdir(sub_dir);
end

%% Create the session folder

ses_dir = fullfile( sub_dir, sprintf('ses-%s',sesID));
if ~exist(ses_dir, 'dir')
    mkdir(ses_dir);
end

%% Copy the log_subXXX template

% the input file
logSub_source = fullfile(MINPAT, 'log_subXXX.txt');
% define the output name
log_file_name = strrep('log_subXXX', 'XXX', subID);
logSub_dest = fullfile(sub_dir, sprintf('%s.m', log_file_name));
% create hte file if it doesn't exist
if ~exist(logSub_dest, 'file')
    copyfile(logSub_source, logSub_dest);


%% Make some changes to the file

% change the name of the function
update_pathSetup(logSub_dest, {'log_subXXX()'}, ... 
                    {sprintf('%s()', log_file_name)} );

% change the fields
update_pathSetup(logSub_dest, {'targ_subid', 'dcm_subid'}, ... 
                    {subID, dcm_subID} );

end
%% Make temporary copy of the session level analysis file

logSes_source = fullfile(MINPAT, 'log_sesLevelAn.txt');

% define the output name
logSes_dest = fullfile(log_dir, 'tmp_logSesFile.m');
% create hte file if it doesn't exist
copyfile(logSes_source, logSes_dest);


%% Make some changes to the file

% change the name of the function
update_pathSetup(logSes_dest, {'%% SESSION'}, ... 
                    { sesID} );

% change the fields
update_pathSetup(logSes_dest, {'targ_sesid', 'dcm_sesid', 'dcm2nii_configFile', 'dcm2nii_exclCriter', 'n_cores'}, ... 
                    {sesID, dcm_sesID, dcm2nii_configFile, dxc2nii_exclCriter, n_cores} );


%% Create log text file to store progresses of the session level analysis

log_sesLevelAn_file = fullfile(ses_dir, sprintf('sub-%s_ses-%s_log.txt',subID, sesID));

fclose(fopen(log_sesLevelAn_file, 'w'));

%% update field in the log_subXXX.m file

% change the fields
update_pathSetup(logSes_dest, {'logFile'}, ... 
                    {log_sesLevelAn_file} );


                
%% Concatenate the session level analysis part to the log_subXXX file

% conatenate files
cat_cmd = sprintf('cat %s >> %s', logSes_dest, logSub_dest);
runSystemCmd(cat_cmd, 0);

fprintf('done\n')

% remove the file
delete(logSes_dest);

                
%% Update the paths

strtUpFile = fullfile(userpath,'startup.m');
run(strtUpFile);



