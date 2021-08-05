function [fList,check] = doTmpCheckList(wrkDir, subID, sesID, fOmit)
% 
% Determines whether the files expectd from a configuration file are all
% present in a specific folder.
% 
% Usage:
%   doTmpCheckList(wrkDir, subID, sesID, fOmit)
% 
% Inputs:
%   wrkDir          FULL PATH to dcm2bids output directory  (string).
%   subID          subject ID used for dcm2bids conversion (string).
%   sesID           session ID used for dcm2bids conversion (string).
%                   If no session is expected, use [].
%   fOmit           string specyifing a set of data we are not interested
%                   in. The presence of file with such a string won't
%                   affect the check flag. All the files find in the tmp
%                   folder will be output independenlty of fOmit.
% 
% Outputs:
%   fList           Nx1 cell array. Stores all the files found in the
%                   temporary folder. It is not affected by fOmti.
%   check           Binary flag. 0 if there is at least one file in the tmp
%                   folder. Dose not consider files with substrings defined
%                   by fOmit.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Set up things

if nargin > 4
    error('Too many input arguments.');
end

% Define the objective direcotry
if isempty(sesID)
    objDir = sprintf('sub-%s',subID);
else
    objDir = sprintf('sub-%s_ses-%s',subID, sesID);
end


% Define the full path to the directory to check
fullPath = fullfile(wrkDir, 'tmp_dcm2bids', objDir);

% Check the nifti files in there
tmpList = dir(sprintf('%s/*.nii.gz',fullPath));
nF = length(tmpList); % number of files in the folder (and sub-folders)


%% Real job

% The output
if isempty(tmpList)
    fList = [];
    check = 1;
elseif ~isempty(tmpList) && isempty(fOmit)
    fList = cell(nF,2);
    check = 1;
    for ii = 1:nF
        % file name and path must be concatenated
        fList{ii,1} = fullfile(fullPath,tmpList(ii).name);
        fList{ii,2} = 1;
    end
else
    fList = cell(nF,2);
    check = 1;
    % Now let's record the file names
    for ii = 1:nF
        tmp_check = 0;
        % file name and path must be concatenated
        fList{ii,1} = fullfile(fullPath,tmpList(ii).name);
        for jj = 1:length(fOmit)
            % do the checks
            if isempty(strfind(tmpList(ii).name, fOmit{jj}))
                fList{ii,2} = 0;
            else
                fList{ii,2} = 1;
                tmp_check = 1;
                break
            end
        end
        check = tmp_check*check;
    end
end
