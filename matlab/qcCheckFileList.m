function [l, fList] = qcCheckFileList(wrkDir, subID, sesID, configFile, varargin)
% 
% Check consistency between dcm2bids output and expectation based on the
% configuration file. Also, check if there are files in the 
% "wrkDir/tmp_dcm2bids" folder which is automatically generated when
% running dcm2bids.
% The funcion outputs a text file into the subject (or session if present)
% folder which summaries the qc output. The file name is
% sub-subID_[ses-sesID_]qc.txt .
% 
% Usage:
%   l = qcCheckFileList(wrkDir, subID, sesID, configFile, exclCriterion1, 
%                   exclCriterion2, ...)
% 
% Inputs: 
%   wrkDir          FULL PATH to dcm2bids output directory  (string).
%   subID           subject ID used for dcm2bids conversion (string).
%   sesID           session ID used for dcm2bids conversion (string).
%                   If no session present, use [].
%   configFile      path to the json configuration file (string). 
%   exclCriterion   optional. Exclude files, based on a specific criterion. 
%                   The criterion must be specified as a 1x2 cell array. 
%                   First element must be a key, second element must be the
%                   value based on which to exclude. If multiple criteria
%                   are needed, then input one cell array for each
%                   criterion.
% 
% Output:
%   l           Binary flags. 0 if there are inconsistencies with the
%               expected file organization. 1 otherwise.
%   text file   A summary text file. The file is seved as
%               "wrkDir/sub-subID/[ses-sesID/]sub-subID_[ses-sesID_]qc.txt
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Set up things

% Define the objective direcotry and qc text file name
if isempty(sesID)
    objDir = sprintf('sub-%s',subID);
    qcTxt_name = sprintf('sub-%s_qc.txt',subID);
else
    objDir = fullfile(sprintf('sub-%s',subID),sprintf('ses-%s',sesID));
    qcTxt_name = sprintf('sub-%s_ses-%s_qc.txt',subID, sesID);
end

% Define the full path to the objective directory directory
fullPath = fullfile(wrkDir, objDir);
% Define the qc text file path
qcTxt = fullfile(fullPath, qcTxt_name);

%% REAL JOB

% Get the expected file list based on the configuration file
expList = getExpectedFileList(configFile, subID, sesID, varargin{:});

% Do check list
[fList, c1] = doCheckList(expList, wrkDir, subID, sesID);

% Check also the files into the tmp_dcm2bids folder
[tmpList, c2] = doTmpCheckList(wrkDir, subID, sesID,'localizer');

% Write the file
getRawDataQCtxt(qcTxt, c1, fList, c2, tmpList, wrkDir, subID, sesID, configFile);

% seth the output flag
l = c1*c2;










