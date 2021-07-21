function l = sessionLevelAnalysis(subID, sesID, config)
% 
% Run single session processing
% 
% Usage:
%   l = sessionLevelAnalysis(subID, sesID, config)
% 
% Inputs:
%   subID       ...
%   sesID       ...
%   config 
%
% Outputs:
%   l           outcome flag
% 
% Requirements:
%   ...
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Call the GLOBAL variables

global DICOMDIR RAWDIR SUBANDIR


%% Step 0. DICOM to NIfTI conversion

dcm_subID = config.dcm2nii.dcm_subID;
dcm_sesID = config.dcm2nii.dcm_sesID;
dcm2nii_configFile = config.dcm2nii.configFile;

% Do the conversion
dcm2nii(DICOMDIR, dcm_subID, dcm_sesID, dcm2nii_configFile, ...
            RAWDIR, subID, sesID);
% run QC
l = qcRawData(rawdata, subID, sesID, CONFIGFILE, {'ReceiveCoilName', 'HeadNeck_20'});
