function pathSetup()
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
global IMGMAGICK
global NODDI
global LONGANPATH
global DICOMDIR RAWDIR POPANDIR SUBANDIR


%% Path definition: adapt these to your needs
% ==========================================

% sofrware paths
FSLDIR = '';            % MODIFY !! full path to FSL directory
DTITK = '';             % MODIFY !! full path to DTI-TK directory
FREESURFER_HOME = '';   % MODIFY !! full path to freeSurfer directory
DICOM2NIIX = '';        % MODIFY !! full path to dcm2niix directory
DICOM2BIDS = '';        % MODIFY !! full path to dcm2bids directory
IMGMAGICK = '';         % MODIFY !! full path to IamgeMagick directory
NODDI = '';             % MODIFY !! full path to NODDI toolbox directory
LONGANPATH = '';        % MODIFY !! full path to LongAn directory

% Data paths
DICOMDIR = '';          % MODIFY !! full path to DICOM data directory
RAWDIR = '';            % MODIFY !! full path to where NIfTI raw data will be stored
POPANDIR = '';          % MODIFY !! full path for popluation level analysis output
SUBANDIR = '';          % MODIFY !! full path for subject and session level analysis output

% don't modify this unless you know what you are doing
SUBJECTS_DIR = fullfile(SUBANDIR, 'fs_processing');

%% Set environment variable
% ==========================================

pathConfig();

