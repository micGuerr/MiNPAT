function log_sub-XXX()

%% SUBJECT ANALYSIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% template for single subject pre-processing and IDP generation.
%
% NB: DO NOT DIRECTLY MODIFY THIS FILE!
%     For each subject you analyse, make a copy and rename it.
%     For example: "log_sub-XXX.txt" ==> "log_sub-001.m".
%
%     Then adapt it for your subject analysis.
%     The part of the code you should change are clearly labeled (MODIFY!)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Setup of the paths...don't modify this
pathSetup();

%%  Write here the ID you would like to assigne to this subject.
%   This should be consistent with the ID used when renaming this file.

subid = ''; % (MODIFY! e.g.: '001')

%% Write here the name (not the path) of the DICOM folder containg the data of this subject.

dcm_subid = ''; % (MODIFY! e.g.: 'S01')

%% ################      SESSION LEVEL ANALYSIS       #####################

%  [copy and adapt the following code as many times as the number of  ...
%                              ...  time points available for this subject]

%% Session # XX (adapt this to make it consistent with session ID, e.g.: 01)

% firts thing, let's define the SESSION ID
sesid = ''; % (MODIFY! e.g.: '01')

% next, let's do some configurations. No need to change this!
config = setSesConfig();
config.sesID = sesid;
config.dcm2nii.dcm_subID = dcm_subid;

% Now write here the name (not the path) of the DICOM folder containg this specific session data.
config.dcm2nii.dcm_sesID = ''; % (MODIFY! e.g.: 's56454')
% Add the PATH to the .json BIDS configuration file for this specifc session
config.dcm2nii.configFile = ''; % (MODIFY! e.g.: '/Users/<myUsername>/BIDSconfig.json')

% At this point let's start the analysis !!!
l = sessionLevelAnalysis(subid, config.sesID, config);




%% ################      SUBHECT LEVEL ANALYSIS       #####################

%  [This part of the code should not be copied multiple times !!]

l = subjectLevelAnalysis();
