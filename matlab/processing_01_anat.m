%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% processing_01_anat.m
%
% Script for anatomical data processing.
% Includes dicom to NIfTI conversion.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)
% 
% Date:
%   June 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup

% inputs for the analysis
rawdata = ''; % Path to raw NIfTI data. **FILL IT**
wrkdir = ''; % Path to working directory. Is the folder where the processed data are stored. **FILL IT**
subid = {'01'}; % Subject IDs. Tells which subjects are analyzed. **FILL IT**
sesid = {'01', '02', '03', '04', '05'}; % Ssession IDs. Tells which timepoints are analyzed. **FILL IT**

% other useful stuff
nSes = length(sesid);

%% Steps of the analysis
% Explain ...

% 0 - Dicom to nifti Conversion
do_dcmConversion = 1;
% 1 - Tidy up data: reorient, crop, align.
do_acpc = 0;
% 2 - Bias field intenisty correction
do_biasFieldCorr = 0;
% 3 - Brain extraction
do_brainExtr = 0;
% 4 - Run FreeSurfer
do_freeSurfer = 0;
% ...

%% Check if output folder exists
if ~exist(wrkdir, 'dir')
    mkdir(wrkdir)
end

%% Step 0. Dicom to nifti conversion

% This step is specific for the type of acquisition you have.
% It takes in input the path to the folders of the subjects where dicom
% data are stored.
% For this step ALL timepoint IDs MUST be specified and ORDERED from first
% to last, e.g.: 
%  -> sesid = {'01', '02', '03', '04', '05'}
% The output is stored in folder specified by "rawdata".

if do_dcmConversion
    % inputs
    dicomData = ''; % path to dicom data folder. **FILL IT**
    dicomSubFolder = {'S01'}; % subject subfolder name in dicomData folder. **FILL IT**
    configFile = 'BIDS_config.json'; % path to dcm2bids configuration file. **FILL IT**
    
    
    %% Check if output folder exists
    if ~exist(rawdata, 'dir')
        mkdir(rawdata)
    end
    
    
    % Concatenate dicom folder and subject folder name
    inDicom = fullfile(dicomData, dicomSubFolder{1});
    % Call function to run conversion
    dcmConvert(inDicom, subid{1}, sesid, configFile, rawdata);
    
    %% Perform QC
    % we do it separately for each timepoint
    
    for ss = 1:nSes
        if ss < 5
            l = qcRawData(rawdata, subid{1}, sesid{ss}, configFile, {'ReceiveCoilName', 'HeadNeck_20'});
        else
            l = qcRawData(rawdata, subid{1}, sesid{ss}, configFile);
        end
    end
end

if ~l
    error('Csreful, something is not right!! Check the ouput')
end

%% Step 1




%% Step 2



%% Step 3









