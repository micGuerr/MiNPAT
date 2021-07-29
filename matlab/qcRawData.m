function l = qcRawData(wrkDir, subID, sesID, configFile, excludConf)
% 
% Help performing quality check of raw data.
%
% Usage:
%   l = qcRawData(wrkDir, subID, sesID, configFile, exclCriterion1, 
%                   exclCriterion2, ...))
% 
% Raw data are NIfTI files, converted from DICOM, which have not been
% processed yet.
% 
% Two checks are automatically performed:
% 1 - Check consistency between dcm2bids output and expectation based on 
%     a configuration file.
% 2 - Check if there are temporary files which should have been part of the
%     raw data, but which have been discarded for some reason.
%
% If everything is as expected the output flag takes value 1. If not it
% takes 0.
% A text file is generated into the objective direcotry to tracks QC and,
% in case of issues, to understand what went wrong.
%
% For a further visual check of the NIfTI data quality, if the previous QC
% is passed, images of each volume are automatically produced.
% The images are saved in each volume folder, using the same name.
%
% NOTE that these images DO NOT replace a careful check through insepction 
% of the NIfTI volumes. They only help identifying clear issues.
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
%   png images They are saved as:
%               "wrkDir/sub-subID/[ses-sesID/]<acqType>/<file_name>.png
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% Performs QC of the files
[l, fList] = qcCheckFileList(wrkDir, subID, sesID, configFile, excludConf);

if l
    % Take volume shots
    qcGetVolShots(wrkDir, fList)
end
    












