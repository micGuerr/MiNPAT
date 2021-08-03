function [cmd_status, cmd_res] = mergeDwiData(dwiStruct, mrgd_dwis, mrgd_bval, mrgd_bvec)
% 
% 
% 
% Usage:
%   [cmd_status, cmd_res] = mergeDwiData(dwiData, all_dwis_path, all_bval_path, all_bvec_path)
% 
% 
% 
% 
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)


%% First check the output doesn't exist
if exist(mrgd_dwis, 'file')
    warning('File %s already exist, DWI stack NOT merged.', mrgd_dwis);
    cmd_status = 0;
    cmd_res = 0;
    return
end

%% If bval and bvec are empty, don't need to merge them
doBval = 1;
doBvec = 1;

if isempty(mrgd_bval); doBval = 0; end
if isempty(mrgd_bvec); doBvec = 0; end


%% Get dwiData acquisitions
acqs = fieldnames(dwiStruct);
n_acqs = length(acqs);

%% Do job

% temporary variable for dwi volumes tracking
tmp_dwi = [];

% define tmp variables
if doBval; bval = []; end
if doBvec; bvec = []; end

% Loop over the acquisitions
for ii = 1 : n_acqs
    
    % make things easier to read
    In = dwiStruct.(acqs{ii});
    
    % track volumes
    tmp_dwi = [tmp_dwi ' ' In.vol ];
    
    % track bvalues
    if doBval
        tmp_bval = load_bVal(In.bval);
        bval = cat(2, bval, tmp_bval);
    end
    % track bvecs
    if doBvec
        tmp_bvec = importdata(In.bvec);
        bvec = cat(2, bvec, tmp_bvec);
    end
end

% Run the merging command
mrg_cmd = sprintf('fslmerge -t %s %s', mrgd_dwis, tmp_dwi);
[cmd_status, cmd_res] = runSystemCmd(mrg_cmd, 1);

% Get the bval/bvec files
if doBval; mk_bvalFile(bval, mrgd_bval); end
if doBvec; mk_bvecFile(bvec, mrgd_bvec); end

