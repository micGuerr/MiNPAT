function status = sessionLevelAnalysis(subID, sesID, config)
% 
% Run single session processing
% 
% Usage:
%   l = sessionLevelAnalysis(subID, sesID, config)
% 
% Inputs:
%   subID       Subject level analysis ID
%   sesID       Session level analysis ID
%   config      Structure for analysis configuration and storig of 
%               input/output.
%
% Outputs:
%   status      binary variable describing the status of the analsyis.
% 
% Requirements:
%   ...
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Call the GLOBAL variables

global DICOMDIR RAWDIR SUBANDIR SUBJECTS_DIR


%% STEP 0.      DICOM TO NIfTI CONVERSION

dcm_subID = config.dcm2nii.dcm_subID;
dcm_sesID = config.dcm2nii.dcm_sesID;
dcm2nii_configFile = config.dcm2nii.configFile;

% Do the conversion
config.dcm2nii.outc = dcm2nii(DICOMDIR, dcm_subID, dcm_sesID, dcm2nii_configFile, ...
                                RAWDIR, subID, sesID);
        
% Get the list of converted raw data 
config.dcm2nii.expFileList = getExpectedFileList(dcm2nii_configFile, subID, sesID);

% run QC
config.dcm2nii.qc.outc = qcRawData(RAWDIR, subID, sesID, dcm2nii_configFile);

%% STEP 1.      ANATOMICAL ANALYSIS
%% Step 1.0     Folder structure and inputs definition

% Create the folders for this anatomical session level analysis.
[config.anat.path, ...
    config.anat.outc] = define_sesLevl_path(SUBANDIR, subID, sesID, 'anat');

% Define the inputs for anatomical analysis
config.anat.input = getSesLevelAnalysisInput(RAWDIR, config.dcm2nii.expFileList, ...
                        config.anat.path, subID, sesID, 'anat');

%% Step 1.1     Anatomical data preparation

% Reorient to match FSL template orientation and crop the FOV.
[config.anat.reor.outp, ...
    config.anat.reor.outc] = anatDataPrep(config.anat.input);

%% Step 1.2     Bias field correction

% Run the bias field correction
[config.anat.bfc.outp, ...
    config.anat.bfc.outc] = biasFieldCorrection(config.anat.reor.outp);

%% Step 1.3     FreeSurfer (FS) analysis

% Define the ID to use in the FS analysis
config.anat.fs.ID = sprintf('sub-%s_ses-%s', subID, sesID);
% Run the FreeSurfer analysis
config.anat.fs.outc = runFreeSufer(config.anat.bfc.outp, ...
                        SUBJECTS_DIR, config.anat.fs.ID, ...
                            config.parall);
    
%% Step 1.4     Anatomical brain mask definition

% Define a fine brain mask for anatomical data
[config.anat.bm.outp, ...
    config.anat.bm.outc] = define_anatBrainMask(config.anat.fs.ID, config.anat.bfc.outp);

%% STEP 2.      DIFFUSION ANALYSIS
%% Step 2.0     Folder structure and inputs definition

% Create the folders for this diffusion session level analysis.
[config.dwi.path, config.dwi.outc] = define_sesLevl_path(SUBANDIR, subID, sesID, 'dwi');

% Define the inputs for diffusion analysis
config.dwi.input = getSesLevelAnalysisInput(config.dcm2nii.expFileList, ...
                        config.dwi.path, subID, sesID, 'dwi');

%% Step 2.1     Run topup
config.dwi.topup.bsname = fullfile(config.dwi.path, 'topup', 'topup');

[config.dwi.topup.field, ...
    config.dwi.topup.b0unwrp, ...
        config.dwi.topup.acqp, ...
            config.dwi.topup.outc] = runTopup(config.dwi.input, ...
                                            config.dwi.topup.cnfg, ...
                                                config.dwi.topup.bsname);
%% Step 2.2     Rough diffusion brain mask definition

config.dwi.bet.outpath = fullfile(config.dwi.path, 'bet');

[~, config.dwi.bet.mask, ...
    config.dwi.bet.outc] = runBET(config.dwi.topup.outpath, config.dwi.bet.outpath, ...
                                config.dwi.bet.f);

%% Step 2.3     Run EDDY

config.dwi.eddy.bsname = fullfile(config.dwi.path, 'eddy', 'eddy');

[config.dwi.eddy.outp, ...
    config.dwi.eddy.outc] = runEddy(config.dwi.input, ...  
                                config.dwi.topup.outpath, ...
                                    config.dwi.bet.mask, ...
                                        config.dwi.topup.acqp, ...
                                            config.dwi.eddy.bsname, ...
                                                config.parall);
%% Step 2.4     Run DTI fit

config.dwi.dti.outpath = fullfile(config.dwi.path, 'dti', 'dti');

[config.dwi.dti.outp, ...
    config.dwi.dti.outc] = runDTIfit(config.dwi.eddy.outp, ...
                                config.dwi.input, ...
                                    config.dwi.bet.mask, ...
                                        config.dwi.dti.outpath);

%% Step 2.5     FA ring removal

[config.dwi.farrm.outp, ...
    config.dwi.farrm.outc] = runMaskRef(config.dwi.dti.outp, ...
                                    config.dwi.bet.mask);

%% Step 2.6     Update masking and DTI-TK conversion



%% Step 2.7     NODDI fit

%% Step 2.8     Diffusion to anatomical mapping

