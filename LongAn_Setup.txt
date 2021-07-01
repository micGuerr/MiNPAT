%
% Initialization for Longitudinal Analysis MRI
%
% NB: DO NOT MODIFY THIS FILE!
%     Make a copy of it, adapt to your paths and rename it to "LongAn_Setup.m"
%

global FSLDIR
global DTITK
global FREESURFER_HOME SUBJECTS_DIR
global DICOM2NIIX DICOM2BIDS
global NODDI_path
global LongAn_code_path
global DICOMDIR RAWDIR PROCDIR CONFIGFILE


%% Path definition: adapt these to your needs
% ==========================================

% sofrware paths
FSLDIR = '';            % full path to FSL directory
DTITK = '';             % full path to DTI-TK directory
FREESURFER_HOME = '';   % full path to freeSurfer directory
DICOM2NIIX = '';        % full path to dcm2niix directory
DICOM2BIDS = '';        % full path to dcm2bids directory
NODDI_path = '';        % full path to NODDI toolbox directory
LongAn_code_path = '';  % full path to LongAn directory

% Data paths
DICOMDIR = '';          % full path to DICOM data directory
RAWDIR = '';            % full path to where NIfTI raw data will be stored
PROCDIR = '';           % full path to where processed data will be stored
CONFIGFILE = '';        % full path to dcm2bids configuration file

% don't modify this unless you know what you are doing
SUBJECTS_DIR = fullfile(PROCDIR, 'fs_processing');

%% Set environment variable
% ==========================================

setenv('PATH', [getenv('PATH') '']);
setenv('FREESURFER_HOME', FREESURFER_HOME);
system('source ${FREESURFER_HOME}/SetUpFreeSurfer.sh');


%% Create working directories if they don't exist
% ==========================================

if ~exist(RAWDIR, 'dir')
    mkdir(RAWDIR);
end
if ~exist(PROCDIR, 'dir')
    mkdir(PROCDIR);
    mkdir(SUBJECTS_DIR);
end
if ~exist(SUBJECTS_DIR, 'dir')
    mkdir(SUBJECTS_DIR);
end


% Set Matlab paths
% ==========================================
if ~isdeployed
    addpath( genpath(NODDI_path) );
    addpath( genpath( fullfile(LongAn_code_path, 'matlab')) );
end
