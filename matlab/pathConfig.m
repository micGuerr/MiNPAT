function pathConfig()
% 
% Configure software and Matalb toolboxes PATHS
% 

global FSLDIR
global DTITK
global FREESURFER_HOME SUBJECTS_DIR
global DICOM2NIIX DICOM2BIDS
global NODDI
global MINPAT

%% BASH PATHS CONFIGURATION

% LONGAN configuration
setenv('MINPAT_ROOT', MINPAT);
setenv('PATH', [ fullfile(getenv('MINPAT_ROOT'),'bin') ':' getenv('PATH')]);
runSystemCmd(sprintf('chmod +x %s', fullfile(getenv('MINPAT_ROOT'),'bin' ,'*')), 0);

% FSL configuration
setenv('FSLDIR', FSLDIR);

% DTITK configuration
setenv('DTITK_ROOT', DTITK);
setenv('PATH', [ fullfile(getenv('DTITK_ROOT'),'bin') ':'  getenv('PATH') ]);
setenv('PATH', [ fullfile(getenv('DTITK_ROOT'),'utilities') ':'  getenv('PATH') ]);
setenv('PATH', [ fullfile(getenv('DTITK_ROOT'),'scripts') ':'  getenv('PATH') ]);

% FreeSurfer configuration
setenv('FREESURFER_HOME', FREESURFER_HOME);
system('source ${FREESURFER_HOME}/SetUpFreeSurfer.sh');
setenv('SUBJECTS_DIR', SUBJECTS_DIR);

% dicom2niix configuration
setenv('PATH', [ DICOM2NIIX ':'  getenv('PATH') ]);
% dicom2bids configuration
setenv('PATH', [ DICOM2BIDS ':'  getenv('PATH') ]);


%% MATLAB PATHS CONFIGURATION

addpath( genpath( NODDI ) );




