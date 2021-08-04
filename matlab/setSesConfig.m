function config = setSesConfig(subid, sesid, dcm_subid, dcm_sesid, dcm2nii_configFile, dxc2nii_exclCriter, n_cores, logFile)
% 
% Creates a default structure with fields in which to store relevant 
% information for session level analysis of neuroplasticity micostrucutral
% changes.
% 
% Usage:
%   config = setSesConfig()
% 
% no input
%
% Output:
%   config      the structure
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% Define the config structure
config = struct();

%% First thing, let's define important fields

config.subID = subid;
config.sesID = sesid; % the session ID field
config.logFile = logFile;
config.parall = n_cores; % number of cores to be used in the analysis

%% STEP 0. dicom 2 nifti conversion

% inputs
config.dcm2nii = [];
config.dcm2nii.dcm_subID = dcm_subid;
config.dcm2nii.dcm_sesID = dcm_sesid;
config.dcm2nii.configFile = dcm2nii_configFile;
config.dcm2nii.configFile_excl = dxc2nii_exclCriter;

% outputs
config.dcm2nii.expFileList = [];
config.dcm2nii.outc = 0;
config.dcm2nii.qc.outc = 0;

%% STEP 1. anatomical analysis related fields

% step 1.0 folder and input defintion
config.anat.path = [];
config.anat.input = [];
config.anat.outc = 0;

% step 1.1 data preparation
config.anat.reor.outp = [];
config.anat.reor.outc = [];

% step 1.2 bias field correction
config.anat.bfc.outp = [];
config.anat.bfc.outc = [];

% step 1.3 FreeSurfer
config.anat.fs.ID = [];
config.anat.fs.outc = [];

% step 1.4 Anatomical brain mask
config.anat.bm.outp = [];
config.anat.bm.outc = [];

%% STEP 2. diffusion analysis related fields

% step 2.0 folder and input defintion
config.dwi.path = [];
config.dwi.input = [];

% step 2.1 topup
config.dwi.topup.cnfg = [];
config.dwi.topup.bsname = [];
config.dwi.topup.field = [];
config.dwi.topup.b0unwrp = [];
config.dwi.topup.acqp = [];
config.dwi.topup.outc = [];

% step 2.2 bet
config.dwi.bet.f = 0.3;
config.dwi.bet.outpath = [];
config.dwi.bet.mask = [];
config.dwi.bet.outc = [];

% step 2.3 eddy
config.dwi.eddy.bsname = [];
config.dwi.eddy.dwi = [];
config.dwi.eddy.bval = [];
config.dwi.eddy.dvec = [];
config.dwi.eddy.outc = [];

% 2.4 dti fit
config.dwi.dti.outp = [];
config.dwi.dti.outc = [];

% 2.5 refinemask
config.dwi.farrm.mask = [];
config.dwi.farrm.dt = [];



