function pathConfig()
% 
% Configure software and Matalb toolboxes PATHS
% 

global FSLDIR
global DTITK
global FREESURFER_HOME SUBJECTS_DIR
global DICOM2NIIX DICOM2BIDS
global IMGMAGICK
global NODDI
global LONGANPATH

%% BASH PATHS CONFIGURATION

% LONGAN configuration
setenv('PATH', [getenv('PATH') ':' LONGANPATH]);

% FSL configuration
setenv('FSLDIR', FSLDIR);

% DTITK configuration
setenv('DTITK_ROOT', DTITK);
setenv('PATH', [getenv('PATH') ':' fullfile(getenv('DTITK_ROOT'),'bin')]);
setenv('PATH', [getenv('PATH') ':' fullfile(getenv('DTITK_ROOT'),'utilities')]);
setenv('PATH', [getenv('PATH') ':' fullfile(getenv('DTITK_ROOT'),'scripts')]);

% FreeSurfer configuration
setenv('FREESURFER_HOME', FREESURFER_HOME);
system('source ${FREESURFER_HOME}/SetUpFreeSurfer.sh');
setenv('SUBJECTS_DIR', SUBJECTS_DIR);

% dicom2niix configuration
setenv('PATH', [getenv('PATH') ':' DICOM2NIIX]);
% dicom2bids configuration
setenv('PATH', [getenv('PATH') ':' DICOM2BIDS]);

% ImageMagick configuration
setenv('MAGICK_HOME', IMGMAGICK);
setenv('PATH', [getenv('PATH') ':' fullfile(getenv('MAGICK_HOME'),'bin')]);
setenv('DYLD_LIBRARY_PATH', [getenv('DYLD_LIBRARY_PATH') ':' fullfile(getenv('MAGICK_HOME'),'lib')]);

%% MATLAB PATHS CONFIGURATION

addpath( genpath( NODDI ) );




