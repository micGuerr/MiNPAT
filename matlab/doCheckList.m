function [cList,check] = doCheckList(expList, wrkDir, subID, sesID)
% 
% Determines whether the files expectd from a configuration file are all
% present in a specific folder.
% 
% Usage:
%   [cList,c] = doCheckList(expList, wrkDir, subID, sesID)
% 
% Inputs:
%   fList           List of file to be checked. Must be in a Nx1 cell
%                   array.
%   wrkDir          FULL PATH to dcm2bids output directory  (string).
%   subID           subject ID used for dcm2bids conversion (string).
%   sesID           session ID used for dcm2bids conversion (string).
%                   If no session is expected, use [].
% 
% Outputs:
%   cList           Nx2 cell array. The first column stores the paths to 
%                   the files that should have been generated based on the
%                   configuration file.
%                   The second column stores a binary variable to specify
%                   whether the file was there or not.
%   check:          Binary flag. 0 if at least one of the expected files
%                   is not where expected. 1 otherwise.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Set up things

% Define the objective direcotry
if isempty(sesID)
    objDir = sprintf('sub-%s',subID);
else
    objDir = fullfile(sprintf('sub-%s',subID),sprintf('ses-%s',sesID));
end

% Define the full path to the directory to check
fullPath = fullfile(wrkDir, objDir);

% Check the nifti files in there
fList = dir(sprintf('%s/*/*.nii.gz',fullPath));
nF = length(fList); % number of files in the folder (and sub-folders)
nE = length(expList); % number of expected files

% The number of files should be the same in the two lists
if nF ~= nE
    error('Number of files doesn''t match the number of expected files.\n %d files have been found, while %d where expected.', ...
        nF, nE);
end

% The output
cList = cell(nE,2);
cList(:,1) = expList;
check = 1;

%% Do the job

% Now let's check the files are the same
for ii = 1:nE
    % We need to make sure the two paths are the same
    f1 = fullfile(wrkDir,expList{ii});
    % initialize the binary flag
    cList{ii,2} = 0;
    for jj = 1:nF
        % file name and path must be concatenated
        f2 = fullfile(fList(jj).folder, fList(jj).name);
        if strcmp(f1,f2)
            cList{ii,2} = 1;
            break
        end
    end
    check = check*cList{ii,2};
end