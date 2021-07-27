function [I, status] = getDwiAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID)
%
% 1. Identifies the input files for diffusion analysis, given the file
%    list from the raw data folder.
% 2. Links such file to the relative session level analysis folders.
% 3. Ouputs the path to such linked files.
%
% Usage:
%   [I, status] = getDwiAnalysisInput(fileList, wrkDirPath, subID, sesID)
%
% Inputs:
%   rawDataDir  path to the RAWDATA directory.
%   fileList    cell array with list of files expected to be in the RAWDATA
%               folder of the specific sessison of this subject.
%               Expected as relative paths from the RAWDATA folder
%   wrkDirPath  Path to dwi branch of the session level analysis
%               folder of this subject and sesison.
%   subID       Subject ID
%   sesID       Session ID
%
% Outputs:
%   I           a structure with as many fields as the inputs relevant for
%               the dwi analysis stream.
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% First thing, check if there is any file into the "anat" folder
if isempty(sesID)
    anatPath = fullfile( sprintf('sub-%s', subID), ...
        'dwi');
else
    anatPath = fullfile( sprintf('sub-%s', subID), ...
        sprintf('ses-%s', sesID), ...
        'dwi');
end

% Indices of the cells containing anatomical data
idx = find(contains(fileList, anatPath));

% If idx is emptu it means no anatomical data are available, hence skip
% analysis
if isempty(idx)
    I = [];
    fprintf('No dwi data found');
    return
end

%% Now check the inputs

% supported dwi MR image types include at the moment:
dwi_typ = {'dwi'};

% loop over dwi files in the file list
for ii = 1:length(idx)
    % use json to track presence of sidecar files
    json = 0; % initialize to zero
    % take the filename
    vol = fileList{idx(ii)};
    % divide file in parts ...
    [vol_path, vol_name, vol_ext] = niftiFileParts(vol);
    % ... define the volume full path
    vol_fullPath = fullfile(rawDataDir, vol);
    % check if there is sidecar file
    vol_sc = fullfile(rawDataDir, vol_path, [vol_name '.json']);
    if exist(vol_sc, 'file'); json = 1; end
    % split volume name based on "_", output is a cell array
    vol_namePart = split(vol_name, '_');
    %% use last bit to define volume type, compare with supported dwi
    % image types
    for jj = 1:length(dwi_typ)
        % check if the file matches any of the structural types
        if strcmpi(vol_namePart{end}, dwi_typ{jj})
            % define the input directory for anatomical analysis
            outdir = fullfile(wrkDirPath, dwi_typ{jj});
            % create the directory if necessary
            if ~exist(outdir, 'dir'); mkdir(outdir); end
            % Define the input for the analysis
            I.(dwi_typ{jj}) = fullfile(outdir, [vol_name, vol_ext]);
            % Instead of copying the file, to save space, create a link 
            ln_cmd = sprintf('ln -s %s %s', vol_fullPath, I.(dwi_typ{jj}));
            l = runSystemCmd(ln_cmd, 0);
            % do somethingsimilar if the sidecar file exists
            if json
                I.([dwi_typ{jj} '_sc']) = fullfile(outdir, [vol_name, '.json']);
                ln_sc_cmd = sprintf('ln -s %s %s', vol_sc, I.([dwi_typ{jj} '_sc']));
                l_sc = runSystemCmd(ln_sc_cmd, 0);
            end
            % Check whether the linking process gave positive results
            % DOESN't work!
            if ~l && ~l_sc
                error('Something went wrong when creating the link of strcutral data %s', ...
                    vol_fullPath);
            end
        end
    end 
end