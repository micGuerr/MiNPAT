function startNewProcessing(processingFolder_path, dicomData_path)
% 
% Defines the folder and file scaffolding necessary to start the analsysis
% of a new dataset via the Neuroplasticity Microstructural Analysis
% Toolbox.
% 
% Usage:
%   startNewProcessing(processingFolder_path, dicomData_pat)
% 
% Inputs:
%   processingFolder_path   Path to the folder which will contain all the
%                           data produced by the analysis. If the folder
%                           doen't exist, it will be created.
%   dicomData_path          Path to the folder containing the DICOM data.
%                           dicomData_path should contain one subfolder for
%                           each subject.
% 
% Outputs:
%   The following folders and files will be created:
% 
%   <processingFolder_path>
%   ????????? rawData/
%   ????????? popLevelAnalysis/
%   ????????? subLevelAnalysis/
%   ????????? logs/
%   ??????? ????????? log_sub-XXX.txt
%   ????????? config/
%     ???? ????????? pathSetup.m
% 
%   rawData/                Is the folder in which the unprocessed (raw) 
%                           data will be stored after conversion fron DICOM
%                           to NIfTI format.
%   popLevelAnalysis/       Is the folder in which the output from 
%                           population level analysis will be stored.
%   subLevelAnalysis/       Is the folder in which the output from subject
%                           and session levle analysis will be stored.
%   logs/                   Stores matlab scripts in which each step of the
%                           session and subject level analysis is described
%                           and documented.
%   logs/log_subXXX.txt    Is a template file for sessiona and subject
%                           level analysis descrition and documentation.
%   config                  Folder to store configuration files.
%   config/pathSetup.m      A file for external software configuration.
%
% More info:
%   https://github.com/micGuerr/LongitudinalMRI/blob/main/
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Check the Neuroplasticity Microstructural Analysis Toolbox is corrctly added to the matlab path

tbx_path = which('dcmConvert.m');
if isempty(tbx_path)
    error('You should add the toolbox folder to the Matlab Path!');
else
    tbx_path = erase(tbx_path, 'dcmConvert.m');
    tbx_path = erase(tbx_path, 'matlab');
end

%% Create the processing folder if it does not exist.

if ~exist(processingFolder_path, 'dir')
    mkdir(processingFolder_path);
end

%% Create all the subfolders

rawdat = fullfile(processingFolder_path, 'rawData');
popan = fullfile(processingFolder_path, 'popLevelAnalysis');
suban = fullfile(processingFolder_path, 'subLevelAnalysis');
log = fullfile(processingFolder_path, 'logs');
config = fullfile(processingFolder_path, 'config');

if ~exist(rawdat, 'dir'), mkdir(rawdat); end
if ~exist(popan, 'dir'), mkdir(popan); end
if ~exist(suban, 'dir'), mkdir(suban); end
if ~exist(log, 'dir'), mkdir(log); end
if ~exist(config, 'dir'), mkdir(config); end

%% Copy config file and log template into corresponding folders

pathSetup_source = fullfile(tbx_path, 'pathSetup.txt');
pathSetup_dest = fullfile(config, 'pathSetup.m');
if ~exist(pathSetup_dest, 'file')
    copyfile(pathSetup_source, pathSetup_dest);
end

%% Automatically update the pathSetup.m file
fprintf('\nSearching for external softwares...\n')
% Update Neuroplasticity Microstructure analysis toolbox folder path
plasticity_path = erase(erase(which('dcmConvert'), ...
                'dcmConvert.m'), '/matlab');
update_pathSetup(pathSetup_dest, {'MINPAT'}, ... 
                    {plasticity_path} );

% Update the analysis folder paths
update_pathSetup(pathSetup_dest, {'PROCESSDIR', 'DICOMDIR', 'RAWDIR', 'POPANDIR', 'SUBANDIR'}, ... 
                    {processingFolder_path, dicomData_path, rawdat, popan, suban} );
                
% Update the external software paths if correctly configured on this system
if ~isempty(getenv('FSLDIR'))
    fprintf(['  - fsl has been found in: ', getenv('FSLDIR'),'\n'])
    update_pathSetup(pathSetup_dest, {'FSLDIR'}, {getenv('FSLDIR')});
else
    warning('fsl not found.\n%s','Make sure it is installed and added in Matlab path or add it manually in LongAn_Setup.m')
end
if ~isempty(getenv('FREESURFER_HOME'))
    fprintf(['  - freesurfer has been found in: ', getenv('FREESURFER_HOME'),'\n'])
    update_pathSetup(pathSetup_dest, {'FREESURFER_HOME'}, {getenv('FREESURFER_HOME')});
else
    warning('freesurfer not found.\n%s','Make sure it is installed and added in system path environment variable or add it manually in LongAn_Setup.m')
end
if ~isempty(getenv('DTITK_ROOT'))
    fprintf(['  - DTI-TK has been found in: ', getenv('DTITK_ROOT'),'\n'])
    update_pathSetup(pathSetup_dest, {'DTITK'}, {getenv('DTITK_ROOT')});
else
    warning('DTI-TK not found.\n%s','Make sure it is installed and added in system path environment variable or add it manually in LongAn_Setup.m')
end

% Update Matlab toolboxes paths
noddi_path = erase(erase(erase(which('SynthMeasWatsonSHStickTortIsoV_B0'), ...
                '/SynthMeasWatsonSHStickTortIsoV_B0.m'), '/watson'), 'models');
if ~isempty(noddi_path)
    fprintf(['  - NODDI has been found in: ', noddi_path,'\n'])
    update_pathSetup(pathSetup_dest, {'NODDI'}, {noddi_path} );
else
    warning('NODDI not found.\n%s','Make sure it is installed and added in system path environment variable or add it manually in LongAn_Setup.m')
end                
% Update other software paths (dcm2niix, dcm2bids)
[niixStatus, dcm2niix_path] = runSystemCmd('which dcm2niix', 0, 0);
if niixStatus==0
    fprintf(['  - dcm2nii has been found in: ', dcm2niix_path])
    update_pathSetup(pathSetup_dest, {'DICOM2NIIX'},{dcm2niix_path(1:end-1)});
else
    warning('dcm2nii not found.\n%s','Make sure it is installed and added in system path environment variable or add it manually in LongAn_Setup.m')
end
[bidsStatus, dcm2bids_path] = runSystemCmd('which dcm2bids', 0, 0);
if bidsStatus==0
    fprintf(['  - dcm2bids has been found in: ', dcm2bids_path])
    update_pathSetup(pathSetup_dest, {'DICOM2NIIX'},{dcm2bids_path(1:end-1)});
else
    warning('dcm2bids not found.\n%s','Make sure it is installed and added in system path environment variable or add it manually in LongAn_Setup.m')
end

% if ~isempty(dcm2niix_path) && ~niixStatus; dcm2niix_path = erase( dcm2niix_path,'dcm2niix'); end
% if ~isempty(dcm2bids_path) && ~bidsStatus; dcm2bids_path = erase( dcm2bids_path,'dcm2bids'); end
% 
% update_pathSetup(pathSetup_dest, {'DICOM2NIIX', 'DICOM2BIDS'}, ...
%                     {dcm2niix_path(1:end-1), dcm2bids_path(1:end-1)} );
fprintf('\n')

%% Create the file that will contain the database of subjects

if ~exist(fullfile(processingFolder_path,'subjectsDB.csv'), 'file')
    fid = fopen(fullfile(processingFolder_path,'subjectsDB.csv'), 'w');
    fprintf(fid, '%s\n', 'subjectFolder, subjectID');
    fclose(fid);
else
    warning('An existing database of subjects is detected.');
end

%% Add permanently the processing folder to the matlab path

strtUpFile = fullfile(userpath,'startup.m');
fid = fopen(strtUpFile, 'a+');
fprintf(fid, ' addpath( genpath( ''%s'' ) );\n', processingFolder_path );
fclose(fid);

run(strtUpFile);

