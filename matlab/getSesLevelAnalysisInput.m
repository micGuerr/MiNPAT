function [I, status] = getSesLevelAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID, stream)
% 
% 1. Identifies the input files for session level analysis, given the file 
%    list from the raw data folder and the analysis stram you want to run.
% 2. Links such file to the relative session level analysis folders.
% 3. Ouputs the path to such linked files.
% 
% Usage:
%   [I, status] = getSesLevelAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID, stream)
% 
% Inputs:
%   rawDataDir  path to the RAWDATA directory
%   fileList    cell array with list of files expected to be in the RAWDATA
%               folder of the specific sessison of this subject.
%               Expected as relative paths from the RAWDATA folder
%   wrkDirPath  Path to stram branch of the session level analysis
%               folder of this subject and sesison.
%   subID       Subject ID
%   sesID       Session ID
%   stream      Session level analysis stram. It can be 'anat', 'dwi', 'func'
% 
% Outputs:
%   I           a structure with as many fields as the inputs relevant for
%               the specific selected stream.
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)


% Depending on the selected

switch stream
    case 'anat'
        [I, status] = getAnatAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID);
    case 'dwi'
        [I, status] = getDwiAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID);
    case 'func'
        [I, status] = getFuncAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID);
    otherwise
        error('Unknown ''%s'' stream !!', stream);
end
