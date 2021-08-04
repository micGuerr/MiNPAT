function [I, status, result] = getDwiAnalysisInput(rawDataDir, fileList, wrkDirPath, subID, sesID)
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
%   wrkDirPath  Path to diffusion branch of the session level analysis
%               folder of this subject and sesison.
%   subID       Subject ID
%   sesID       Session ID
%
% Outputs:
%   I           a structure with as many fields as the inputs relevant for
%               the diffusion analysis stream.
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% First thing, check if there is any diffusion file into the file list

% Define the path to the rawData diffusion folder
if isempty(sesID)
    dwiPath = fullfile( sprintf('sub-%s', subID), ...
        'dwi');
else
    dwiPath = fullfile( sprintf('sub-%s', subID), ...
        sprintf('ses-%s', sesID), ...
        'dwi');
end

% Indices of the cells containing anatomical data
idx = find(contains(fileList, dwiPath));

% If idx is empty it means no diffusion data are available, hence skip
% analysis
if isempty(idx)
    I = [];
    fprintf('No diffusion data found');
    return
end

%% Now store the files as diffusion analysis input and create a soft-link 
%  to the session level analysis folder

% initialize status and result of the process
status = 0;
result = '';

% supported diffusion MR image types currently include:
strct_typ = {'dwi'};

% loop over diffusion files in the file list
for ii = 1:length(idx)    
    %% Need to extract the file type from the file name. Also look for sideCar files
    % take the filename
    vol = fileList{idx(ii)};
    % divide file in parts ...
    [vol_path, vol_name, vol_ext] = niftiFileParts(vol);
    % ... define the volume full path
    vol_fullPath = fullfile(rawDataDir, vol);
    
    % bvalues, bvecs and sideCar (json) files must be included with same dwi image base name
    vol_bval = fullfile(rawDataDir, vol_path, [vol_name '.bval']);
    vol_bvec = fullfile(rawDataDir, vol_path, [vol_name '.bvec']);
    vol_sc = fullfile(rawDataDir, vol_path, [vol_name '.json']);
    % check if they exist
    if ~exist(vol_bval, 'file') || ~exist(vol_bvec, 'file') || ~exist(vol_sc, 'file')
        error('b-value, b-vector or sideCar files are missing for file %s', ...
            vol_fullPath);
    end
    % split volume name based on "_", output is a cell array
    vol_namePart = split(vol_name, '_');
    
    %% Compare file type with supported file types. If OK creat link and store the path
    for jj = 1:length(strct_typ)
        % check if the file matches any of the structural types
        if strcmpi(vol_namePart{end}, strct_typ{jj})
            
            % Define the directory for session level anatomical analysis
            dwiDir = fullfile(wrkDirPath, strct_typ{jj});
            % create the directory if necessary
            if ~exist(dwiDir, 'dir'); mkdir(dwiDir); end
            
            % Define the input for the ses level anatomical analysis
            dwiVol = fullfile(dwiDir, [vol_name, vol_ext]);
            dwiBval = fullfile(dwiDir, [vol_name, '.bval']);
            dwiBvec = fullfile(dwiDir, [vol_name, '.bvec']);
            dwiSc = fullfile(dwiDir, [vol_name, '.json']);

            % Instead of copying the file, to save space, create a link
            % But first check if the file already exist
            if ~exist(dwiVol, 'file') && ~exist(dwiBval, 'file') ...
                    && ~exist(dwiBvec, 'file') && ~exist(dwiSc, 'file')
                % link the diffusion data
                [st1, res1] = ln_files(vol_fullPath, dwiVol);
                % link the bvalues
                [st2, res2] = ln_files(vol_bval, dwiBval);
                % link the bvecs
                [st3, res3] = ln_files(vol_bvec, dwiBvec);
                % link the sidecar file
                [st4, res4] = ln_files(vol_sc, dwiSc);
                % final status
                tmp_stat = ~(~st1 * ~st2 * ~st3 * ~st4);
                tmp_res = sprintf('%s\n%s\n%s\n%s\n', res1, res2, res3, res4);
            else
                warning('The diffusion data, b-values, bvecs or sideCar file referred to input %s, already exist', ...
                    dwiVol);
                tmp_stat = 0;
                tmp_res = '';
            end
            
            % Define this specific acquisition field ID
            acqID = sprintf('acq%01d', ii);
            % Assigne the value to the output structue
            I.(acqID).vol = dwiVol;
            I.(acqID).bval = dwiBval;
            I.(acqID).bvec = dwiBvec;
            I.(acqID).sc = dwiSc;
            
            % update status and result
            status = ~(~status * ~tmp_stat);
            result = sprintf('%s\n%s',result, tmp_res);

        end
    end 
end