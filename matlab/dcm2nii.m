function [status, fileList] = dcm2nii(dcmdir_path, dcm_subID, dcm_sesID, configFile, outpdir_path, subID, sesID, logFile)
% 
% Performs DICOM to NIFTI conversion
% 
% Usage:
%   status = dcm2nii(dcmdir_path, dcm_subID, dcm_sesID, configFile, outpdir_path, subID, sesID)
% 
% Inputs:
%   dcmdir_path     path to the subject folder containing the timepoint
%                   folders. Each timepoint folder cointains the corresponding
%                   dicom files (string).
%   dcm_subID       name of the folder where the DICOM subject data is
%                   stored.
%   dcm_sesID       name of the folder where the DICOM sesison data is
%                   stored.
%   configFile      path to the json configuration file(string).
%   outpdir_path    path to the output folder where to store the NIfTI
%                   converted data (string).
%   subID           subject ID used in the output naming structure (string).
%   sesID           session ID used in the output naming structure (string).
% 
% Outputs:
%   NIfTI converted data in outpFolder.
% 
% Requirements:
%   dcm2niix (https://github.com/rordenlab/dcm2niix).
%   Dcm2Bids (https://github.com/UNFmontreal/Dcm2Bids).
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% It allows to convert multiple folders as a single time point.
% it needs to check whether sesID_dcm is cell or char:

%% Assinge a step title
stepTitle = 'DICOM to NIfTI conversion';

%% Run Dicom 2 nii coversio

if ischar(dcm_sesID) % if char, assumes single folder for this timepoint

    % Concatenate dicom folder and subject folder ID
    inDicom = fullfile(dcmdir_path, dcm_subID, dcm_sesID);
    % Run Conversion
    [status, result] = dcmConvert(inDicom, subID, sesID, configFile, outpdir_path);
    
elseif iscell(dcm_sesID) % if cell, assumes multiple folders for this timepoint
    
    nDcmDir = length(dcm_sesID);
    status = 0;
    result = '';
    for ii = 1:nDcmDir
        % Concatenate dicom folder and subject folder ID
        inDicom = fullfile(dcmdir_path, dcm_subID, dcm_sesID{ii});
        % Run Conversion
        [tmp_status, tmp_result] = dcmConvert(inDicom, subID, sesID, configFile, outpdir_path);
        % Update status and result of the step
        status = ~(~status * ~tmp_status);
        result = sprintf('%s\n%s',result, tmp_result);
    end
    
else
    error('%s should be a string or a cell of strings!');
end

%% Get the list of converted raw data 
fileList = getExpectedFileList(configFile, subID, sesID);


%% log the result and check the status


% Log the result into a log file
logResult(stepTitle, result, logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrog in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end