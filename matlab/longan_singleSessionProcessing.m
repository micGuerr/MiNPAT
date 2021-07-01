function l = longan_singleSessionProcessing(subID, sesID, subID_dcm, sesID_dcm)
% 
% Run single session processing
% 
% Usage:
%   l = longan_singleSessionProcessing(subID, sesID, subID_dcm, sesID_dcm)
% 
% Inputs:
%   subID       ...
%   sesID       ...
%   subID_dcm   ...
%   sesID_dcm   ...
% 
% Outputs:
%   l           outcome flag
% 
% Requirements:
%   ...
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Step 0. DICOM to NIfTI conversion

% It alloes to convert multiple folders as a single time point.
% it needs to check whether sesID_dcm is cell or char:
if ischar(sesID_dcm)
    % Concatenate dicom folder and subject folder ID
    inDicom = fullfile(DICOMDIR, subID_dcm, sesID_dcm);
    % Run Conversion
    dcmConvert(inDicom, subID, sesID, CONFIGFILE, RAWDIR);
elseif iscell(sesID_dcm)
    nDcmDir = length(sesID_dcm);
    for ii = 1:nDcmDir
        % Concatenate dicom folder and subject folder ID
        inDicom = fullfile(DICOMDIR, subID_dcm, sesID_dcm{ii});
        % Run Conversion
        dcmConvert(inDicom, subID, sesID, CONFIGFILE, RAWDIR);
    end
else
    error('%s should be a string or a cell of strings!');
end

% run QC
l = qcRawData(rawdata, subID, sesID, CONFIGFILE, {'ReceiveCoilName', 'HeadNeck_20'});
