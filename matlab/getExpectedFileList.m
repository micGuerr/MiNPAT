function fList = getExpectedFileList(configFile, subID, sesID, varargin)
% 
% Determines a list of file names you would expect from dcm2bids conversion
% based on the configuration file used.
% 
% Usage:
% flist = getExpectedFileList(configFile, subID, sesID, exclCriterion1, 
%                   exclCriterion2, ...)
% 
% Inputs:
%   configFile      path to the json configuration file (string).
%   subID           subject ID used for dcm2bids conversion (string).
%   sesID           session ID used for dcm2bids conversion (string).
%                   If no session is expected, use [].
%   exclCriterion   optional. Exclude files, based on a specific criterion. 
%                   The criterion must be specified as a 1x2 cell array. 
%                   First element must be a key, second element must be the
%                   value based on which to exclude. If multiple criteria
%                   are needed, then input one cell array for each
%                   criterion.
% 
% Output:
%   fList           Nx1 cell array of paths to the files that should have
%                   been generated based on the configuration file.
% 
% Note:
%   Configuration files should follow:
%   https://unfmontreal.github.io/Dcm2Bids/docs/3-configuration/
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)


%%


% Check whether excluding criteria are present
nCriteria = nargin - 3;
if nCriteria > 0
    doExcl=1; % perform exclusion
    exC = cell(nCriteria,2); % key-value excluding criteria
    % loop and store the key-value excluding criteria
    for ii = 1:nCriteria
        exC(ii,:) = varargin{ii,:};
    end
else
    doExcl=0; % don't perform any exclusion
end

%%

% Read the config (json) file
fid = fopen(configFile, 'r');
% Get the text
txt = fscanf(fid, '%s');
% Decode the json structure
fExp = jsondecode(txt);
nf = length(fExp.descriptions);


%%

% Check if there are file to exclude
if doExcl
    % loop over the exluding criteria
    for jj = 1:nCriteria
        % need to update file number in case of removal
        nf = length(fExp.descriptions);
        % loop over expected files
        for ii = 1:nf
            % check if the key values is present among the criteria
            % it goes from last to one, for correct cell removal
            if isfield(fExp.descriptions{nf-ii+1}.criteria, exC{jj,1})
                % if so, remove the file if the exclusion criteria is matched
                if strcmp(fExp.descriptions{nf-ii+1}.criteria.(exC{jj,1}), exC{jj,2})
                    % Remove the cell
                    fExp.descriptions(nf-ii+1) = [];
                end
            end
        end
    end
end

% Update number of expected files
nf = length(fExp.descriptions);
% declear the output
fList = cell(nf,1);

%%

% Fill fList
for ii = 1:nf
    fpath = sprintf('sub-%s', subID);
    % check for session ID
    if ~isempty(sesID)
        fpath = fullfile(fpath, sprintf('ses-%s', sesID));
    end
    % add the data type
    fpath = fullfile(fpath, fExp.descriptions{ii}.dataType);
    % define the file name, check different options 
    if isfield(fExp.descriptions{ii}, 'customLabels') && ~isempty(sesID)
        fname = sprintf('sub-%s_ses-%s_%s_%s.nii.gz', ...
            subID, sesID, ...
            fExp.descriptions{ii}.customLabels, ...
            fExp.descriptions{ii}.modalityLabel);
        
    elseif isfield(fExp.descriptions{ii}, 'customLabels') && isempty(sesID)
        fname = sprintf('sub-%s_%s_%s.nii.gz', ...
            subID, ...
            fExp.descriptions{ii}.customLabels, ...
            fExp.descriptions{ii}.modalityLabel);
        
    elseif ~isfield(fExp.descriptions{ii}, 'customLabels') && ~isempty(sesID)
        fname = sprintf('sub-%s_ses-%s_%s.nii.gz', ...
            subID, sesID, ...
            fExp.descriptions{ii}.modalityLabel);
        
    elseif ~isfield(fExp.descriptions{ii}, 'customLabels') && isempty(sesID)
        fname = sprintf('sub-%s_%s.nii.gz', ...
            subID, ...
            fExp.descriptions{ii}.modalityLabel);
    end
    
    % the output
    fList{ii} = fullfile(fpath, fname);
end









