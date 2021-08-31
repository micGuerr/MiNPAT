function status = sessionLevelAnalysis(config)
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
global FSLDIR

%% Define some important variables

subID = config.subID;
sesID = config.sesID;
logFile = config.logFile;

dcm_subID = config.dcm2nii.dcm_subID;
dcm_sesID = config.dcm2nii.dcm_sesID;
dcm2nii_configFile = config.dcm2nii.configFile;
dxc2nii_exclCriter = config.dcm2nii.configFile_excl;
n_cores = config.parall;

fprintf(['\n~~~ SESSION LEVEL ANALYSIS: session ',sesID,' of subject ' subID,' ~~~\n']);
tic
%% STEP 0.      DICOM TO NIfTI CONVERSION

% Do the conversion
[config.dcm2nii.outc, ...
    config.dcm2nii.expFileList] = dcm2nii(DICOMDIR, dcm_subID, dcm_sesID, dcm2nii_configFile, ...
                                RAWDIR, subID, sesID, logFile);
% run QC
config.dcm2nii.qc.outc = qcRawData(RAWDIR, subID, sesID, dcm2nii_configFile, dxc2nii_exclCriter);

pauseProcess('DICOM TO NIfTI CONVERSION');

%% STEP 1.      ANATOMICAL ANALYSIS
%% Step 1.0     Folder structure and inputs definition

% Create the folders for this anatomical session level analysis and
% Define the inputs for anatomical analysis.
[config.anat.path, ...
    config.anat.input, ...
       config.anat.outc] = getSesLevelAnalysisInput(RAWDIR, config.dcm2nii.expFileList, ...
                                                        SUBANDIR, subID, sesID, 'anat', ...
                                                            logFile);

pauseProcess('Anatomical folder structure and inputs definition');

%% Step 1.1     Anatomical data preparation

% Reorient to match FSL template orientation and crop the FOV.
[config.anat.reor.outp, ...
    config.anat.reor.outc] = anatDataPrep(config.anat.input, logFile);

pauseProcess('Anatomical data preparation');

%% Step 1.2     Bias field correction

% Run the bias field correction
[config.anat.bfc.outp, ...
    config.anat.bfc.outc] = biasFieldCorrection(config.anat.reor.outp, logFile);

pauseProcess('Bias field correction');

%% Step 1.3     FreeSurfer (FS) analysis

% Define the ID to use in the FS analysis
config.anat.fs.ID = sprintf('sub-%s_ses-%s', subID, sesID);
% Run the FreeSurfer analysis
config.anat.fs.outc = runFreeSufer(config.anat.bfc.outp, ...
                        SUBJECTS_DIR, config.anat.fs.ID, ...
                            n_cores, logFile);

pauseProcess('FreeSurfer (FS) analysis');

%% Step 1.4     Anatomical brain mask definition

% Define a fine brain mask for anatomical data
[config.anat.bm.outp, ...
    config.anat.bm.outc] = define_anatBrainMask(config.anat.fs.ID, config.anat.bfc.outp, logFile);

pauseProcess('Anatomical brain mask definition');

%% STEP 2.      DIFFUSION ANALYSIS
%% Step 2.0     Folder structure and inputs definition

% Create the folders for this anatomical session level analysis and
% Define the inputs for anatomical analysis.
[config.dwi.path, ...
    config.dwi.input, ...
       config.dwi.outc] = getSesLevelAnalysisInput(RAWDIR, config.dcm2nii.expFileList, ...
                                                        SUBANDIR, subID, sesID, 'dwi', ...
                                                            logFile);

pauseProcess('Diffusion folder structure and inputs definition');

%% Step 2.1     Run topup
config.dwi.topup.bsname = fullfile(config.dwi.path, 'topup', 'topup');
config.dwi.topup.cnfg = fullfile(FSLDIR,'src','topup','flirtsch','b02b0.cnf');


[config.dwi.topup.field, ...
    config.dwi.topup.b0unwrp, ...
        config.dwi.topup.acqp, ...
            config.dwi.topup.outc] = runTopup(config.dwi.input, ...
                                            config.dwi.topup.cnfg, ...
                                                config.dwi.topup.bsname, logFile);

pauseProcess('TOPUP');

%% Step 2.2     Rough diffusion brain mask definition

config.dwi.bet.outpath = fullfile(config.dwi.path, 'bet');

[~, config.dwi.bet.mask, ...
    config.dwi.bet.outc] = runBET(config.dwi.topup.bsname, config.dwi.bet.outpath, ...
                                config.dwi.bet.f, logFile);

pauseProcess('Rough Brain Extaction');

%% Step 2.3     Run EDDY

config.dwi.eddy.bsname = fullfile(config.dwi.path, 'eddy', 'eddycorr');

[config.dwi.eddy.dwi, ...
    config.dwi.eddy.bval, ...
        config.dwi.eddy.bvec, ...
            config.dwi.eddy.outc] = runEddy(config.dwi.input, ...  
                                        config.dwi.topup.bsname, ...
                                            config.dwi.bet.mask, ...
                                                config.dwi.topup.acqp, ...
                                                    config.dwi.eddy.bsname, logFile);

pauseProcess('EDDY');

%% Step 2.4     Run DTI fit

config.dwi.dti.outpath = fullfile(config.dwi.path, 'dti', 'dti');

[config.dwi.dti.outp, ...
    config.dwi.dti.outc] = runDTIfit(config.dwi.eddy.dwi, ...
                                        config.dwi.eddy.bval, ...
                                            config.dwi.eddy.bvec, ...
                                                config.dwi.bet.mask, ...
                                                    config.dwi.dti.outpath, logFile);

pauseProcess('DTI fit');
%% Step 2.5     FA ring removal


[config.dwi.farrm.mask, ...
    config.dwi.farrm.dt, ...
        config.dwi.farrm.outc] = runMaskRef(config.dwi.dti.outp, ...
                                                config.dwi.bet.mask, logFile);

pauseProcess('Brain Mask Refinement');

%% Step 2.6     Update masking and DTI-TK conversion



%% Step 2.7     NODDI fit

%% Step 2.8     Diffusion to anatomical mapping

fprintf(['\n\nSESSION ',sesID,' OF SUBJECT ' subID,'    DONE IN ',num2str(toc,'%.2f'),' seconds\n'])