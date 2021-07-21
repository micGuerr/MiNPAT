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

%% first thing, define the session ID field

config.sesID = [];

%% dicom 2 nifti conversion related fields

% inputs
config.dcm2nii = [];
config.dcm2nii.dcm_subID = [];
config.dcm2nii.dcm_sesID = [];
config.dcm2nii.configFile = [];

% outputs
config.dcm2nii.expFileList = [];
config.dcm2nii.outpFlag = 1;

%% anatomical analysis related fields


%% diffusion analysis related fields





