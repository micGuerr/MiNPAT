%% ################      SESSION LEVEL ANALYSIS       #####################

%  [copy and adapt the following code as many times as the number of  ...
%                              ...  time points available for this subject]

%% SESSION = XX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MODIFY HERE! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
targ_sesid = ''; % This is the ID you want to assigne to this session e.g.: '01'
dcm_sesid = ''; % This is the dcm folder ID of the session e.g.: 's56454'
dcm2nii_configFile = ''; % This is the config fle for this specific session 
                                %  e.g.: '/Users/<myUsername>/BIDSconfig.json')
dcm2nii_exclCriter = ''; % Allows to ...
n_cores = ''; % Set the number of cores you want to use for parallel computing (it should be an integer!).
                    % leave empty otherwise.
logFile = '';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Let's setup a few things...(don't change this)
ses_config = setSesConfig(targ_subid, targ_sesid, dcm_subid, dcm_sesid, dcm2nii_configFile, dcm2nii_exclCriter, n_cores, logFile);

% ...and let's start the analysis !!!
l = sessionLevelAnalysis(ses_config);
