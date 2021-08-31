function [I, status, result] = getAnatAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID)
%
% 1. Identifies the input files for anatomical analysis, given the file
%    list from the raw data folder.
% 2. Links such file to the relative session level analysis folders.
% 3. Ouputs the path to such linked files.
%
% Usage:
%   [I, status] = getAnatAnalysisInput(fileList, wrkDirPath, subID, sesID)
%
% Inputs:
%   rawDataDir  path to the RAWDATA directory.
%   fileList    cell array with list of files expected to be in the RAWDATA
%               folder of the specific sessison of this subject.
%               Expected as relative paths from the RAWDATA folder
%   wrkDirPath  Path to anatomical branch of the session level analysis
%               folder of this subject and sesison.
%   subID       Subject ID
%   sesID       Session ID
%
% Outputs:
%   I           a structure with as many fields as the inputs relevant for
%               the anatomical analysis stream.
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

fprintf('Creating folder structure and defining inputs for anatomical data...') 
tic

%% First thing, check if there is any anatomical file into the file list

% Define the path to the rawData anatomical folder
if isempty(sesID)
    anatPath = fullfile( sprintf('sub-%s', subID), ...
        'anat');
else
    anatPath = fullfile( sprintf('sub-%s', subID), ...
        sprintf('ses-%s', sesID), ...
        'anat');
end

% Indices of the cells containing anatomical data
idx = find(contains(fileList, anatPath));

% If idx is empty it means no anatomical data are available, hence skip
% analysis
if isempty(idx)
    I = [];
    fprintf('No anatomical data found');
    return
end

%% Now store the files as anotomical analysis input and create a soft-link 
%  to the session level analysis folder

% initialize status and result of the process
status = 0;
result = '';

% supported non-parametric structural MR image types currently include:
strct_typ = {'t1w', 't2w'};

% loop over anatomical files in the file list
for ii = 1:length(idx)
    % use sc to track presence of SideCar files
    sc = 0; % initialize to zero
    
    %% Need to extract the file type from the file name. Also look for sideCar files
    % take the filename
    vol = fileList{idx(ii)};
    % divide file in parts ...
    [vol_path, vol_name, vol_ext] = niftiFileParts(vol);
    % ... define the volume full path
    vol_fullPath = fullfile(rawDataDir, vol);
    % check if there is sidecar file
    vol_sc = fullfile(rawDataDir, vol_path, [vol_name '.json']);
    if exist(vol_sc, 'file'); sc = 1; end
    % split volume name based on "_", output is a cell array
    vol_namePart = split(vol_name, '_');
    
    %% Compare file type with supported file types. If OK creat link and store the path
    for jj = 1:length(strct_typ)
        % check if the file matches any of the structural types
        if strcmpi(vol_namePart{end}, strct_typ{jj})
            
            % Define the directory for session level anatomical analysis
            anatDir = fullfile(wrkDirPath, strct_typ{jj});
            % create the directory if necessary
            if ~exist(anatDir, 'dir'); mkdir(anatDir); end
            
            % Define the input for the ses level anatomical analysis
            anatInput = fullfile(anatDir, [vol_name, vol_ext]);

            % Instead of copying the file, to save space, create a link
            % But first check if the file already exist
            if ~exist(anatInput, 'file')
                [tmp_stat, tmp_res] = ln_files(vol_fullPath, anatInput);
            else
                warning('File %s already exist',anatInput);
                tmp_stat = 0;
                tmp_res = '';
            end
            
            % Assigne the value to the output structue
            I.(strct_typ{jj}) = anatInput;
            
            %% Do something similar if the sidecar file exists
            if sc
                % Define the input sidecar file
                anatInput_sc = fullfile(anatDir, [vol_name, '.json']);
                % If it not already there creat the link
                if ~exist(anatInput_sc, 'file')
                    [status_sc, result_sc] = ln_files(vol_sc, anatInput_sc);
                else
                    warning('File %s already exist',anatInput_sc);
                    status_sc = 0;
                    result_sc = '';
                end
                
                % Assigne the value to the output structue
                I.([strct_typ{jj} '_sc']) = anatInput_sc;
                
                % update status and result
                tmp_stat = ~(~tmp_stat * ~status_sc);
                tmp_res = sprintf('%s\n%s',tmp_res, result_sc);
            end
            
            % update status and result
            status = ~(~status * ~tmp_stat);
            result = sprintf('%s\n%s',result, tmp_res);

        end
    end 
end

fprintf(['    done in ',num2str(toc,'%.2f'),' seconds\n'])