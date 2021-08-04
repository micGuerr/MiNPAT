function [status, result] = dcmConvert(dcmFolder, subID, sesID, configFile, outpFolder)
% 
% Converts dicom files into NIfTI format. The data are authomatically
% organized into a pre-defined structure which follows the BIDS standard
% (https://bids.neuroimaging.io/).
%
% Usage:
% status = dcmConvert(dcmFolder, subID, sesID, configFile, outpFolder)
%
% Inputs
%   dcmFolder:  path to the subject folder containing the timepoint
%               folders. Each timepoint folder cointains the corresponding
%               dicom files (string).
%   subID:      subject ID used in the output naming structure (string).
%   sesID:      session ID used in the output naming structure (string).
%   configFile: path to the json configuration file(string).
%   outpFolder: path to the output folder where to store the NIfTI
%               converted data (string).
% 
% Output
%   NIfTI converted data in outpFolder.
%
% Requirements:
%   dcm2niix (https://github.com/rordenlab/dcm2niix).
%   Dcm2Bids (https://github.com/UNFmontreal/Dcm2Bids).
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)
%
% note: add error for overwriting ...

 % Add error if you try to overwrite

global DICOM2BIDS

% write the command
dcm2bids_cmd = [fullfile(DICOM2BIDS,'dcm2bids') ...
                ' -d ' dcmFolder ...
                ' -p ' subID ...
                ' -s ' sesID ...
                ' -c ' configFile ...
                ' -o ' outpFolder ];

% print the string to command line
fprintf('===============================================\n');
fprintf('Converting...\n');
fprintf('Subject ID: %s\n', subID);
fprintf('Session ID: %s\n', sesID);
fprintf('Final command is:\n\n');

% execte the command from the operating system
[status, result] = runSystemCmd(dcm2bids_cmd, 1);