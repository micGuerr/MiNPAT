function log_subXXX() % MODIFY THE FUNCTION NAME !! E.G., log_sub001()

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MODIFY HERE! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subid = ''; % e.g.: '001' 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Write here the name (not the path) of the DICOM folder containg the data of this subject.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MODIFY HERE! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dcm_subid = ''; % e.g.: 'S01'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ################      SESSION LEVEL ANALYSIS       #####################

%  [copy and adapt the following code as many times as the number of  ...
%                              ...  time points available for this subject]

%% Session # XX (adapt this to make it consistent with session ID, e.g.: 01)
config = setSesConfig(); % don't change this

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MODIFY HERE! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sesid = ''; % This is the ID you want to assigne to this session e.g.: '01'
config.dcm2nii.dcm_sesID = ''; % This is the dcm folder ID of the session e.g.: 's56454'
config.dcm2nii.configFile = ''; % This is the config fle for this specific session 
                                %  e.g.: '/Users/<myUsername>/BIDSconfig.json')
config.parall = []; % Set the number of cores you want to use for parallel computing (it should be an integer!).
                    % leave empty otherwise.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Let's setup a few things...(don't change this)
config.sesID = sesid;
config.dcm2nii.dcm_subID = dcm_subid;

% ...and let's start the analysis !!!
l = sessionLevelAnalysis(subid, config.sesID, config);

%% ################      SUBHECT LEVEL ANALYSIS       #####################

%  [This part of the code should not be copied multiple times !!]

l = subjectLevelAnalysis();
