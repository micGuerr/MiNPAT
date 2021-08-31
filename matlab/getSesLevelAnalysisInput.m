function [stramPath, I, status] = getSesLevelAnalysisInput(rawDataDir, fileList, subLevlAn_dir, subID, sesID, stream, logFile)
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

%% Assign a step title

stepTitle = sprintf('Input and folder struct definition of %s stram', stream);


%% Define folder structure and get the output stram path

[stramPath, status, result] = define_sesLevl_path(subLevlAn_dir, subID, sesID, stream);


%% Depending on the selected stream, get the analysis input

switch stream
    case 'anat'
        [I, tmp_stat, tmp_res] = getAnatAnalysisInput(rawDataDir, fileList, stramPath, subID, sesID);
    case 'dwi'
        [I, tmp_stat, tmp_res] = getDwiAnalysisInput(rawDataDir, fileList, stramPath, subID, sesID);
    case 'func'
        [I, tmp_stat, tmp_res] = getFuncAnalysisInput(rawDataDir, fileList, stramPath, subID, sesID);
    otherwise
        error('Unknown ''%s'' stream !!', stream);
end


%% log the result and check the status

status = ~(~status * ~tmp_stat);
result = sprintf('%s\n%s',result, tmp_res);

% Log the result into a log file
logResult(stepTitle, result, logFile);

% Check process status, output an error if something didn't work
if status
    error('Something went wrog in step "%s".\n Please check %s file to know more.', stepTitle, logFile);
end

