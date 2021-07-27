function config = setSesConfig()
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

config.sesID = []; % the session ID field
config.parall = []; % number of cores to be used in the analysis

%% STEP 0. dicom 2 nifti conversion

% inputs
config.dcm2nii = [];
config.dcm2nii.dcm_subID = [];
config.dcm2nii.dcm_sesID = [];
config.dcm2nii.configFile = [];

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
config.dwi.topup.outpath = [];
config.dwi.topup.field = [];
config.dwi.topup.b0unwrp = [];
config.dwi.topup.outc = [];

% step 2.2 bet
config.dwi.bet.f = 0.3;
config.dwi.bet.outpath = [];
config.dwi.bet.mask = [];
config.dwi.bet.outc = [];

% step 2.3 eddy
config.dwi.eddy.outp = [];
config.dwi.eddy.outc = [];

% 2.4 dti fit
config.dwi.dti.outp = [];
config.dwi.dti.outc = [];





