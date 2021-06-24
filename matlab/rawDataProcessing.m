function rawDataProcessing(dicomData, dicomSub, )
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
nSub = length(subid);
nSes = length(sesid);

%% Steps of the analysis
% Explain ...

% 0 - Dicom to nifti Conversion
do_dcmConversion = 1;
% 1 - Tidy up data: reorient, crop, align.
do_tidyUp = 0;
% 2 - Bias field intenisty correction
do_biasFieldCorr = 0;
% 3 - Brain extraction
do_brainExtr = 0;
% 4 - Run FreeSurfer
do_freeSurfer = 0;
% ...

%% Step 0. Dicom to nifti conversion

% This step is specific for the type of acquisition you have.
% It takes in input the path to the folders of the subjects where dicom
% data are stored.
% In this step "dicomSub" MUST be consistent with "subid", Make sure the 
% IDs reflect the same subject.
% For this step ALL timepoint IDs MUST be specified and ORDERED from first
% to last, e.g.: 
%  -> sesid = {'01', '02', '03', '04', '05'}
% The output is stored in folder specified by "rawdata".

if do_dcmConversion
    % inputs
    dicomData = ''; % path to dicom data folder. **FILL IT**
    dicomSub = {'S01', '...'}; % subject subfolder names in dicomData folder. **FILL IT**
    configFile = ''; % path to dcm2bids configuration file. **FILL IT**
    
    % check dicomSub and subid have at least same length
    if nSub~=length(dicomSub)
        error('Error. subid and dicomSub MUST be consistent. They should at lest have same number of entries');
    end
    
    % Loop over the subjects
    for sb = 1:nSub
        % Concatenate dicom folder and subject folder name
        inDicom = fullfile(dicomData, dicomSub{sb});
        % Call function to run conversion
        dcmConvert(inDicom, subid{sb}, sesid, configFile, rawdata);
    end
end

%% Step 1











