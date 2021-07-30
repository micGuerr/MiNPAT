function [cmd_status, cmd_res] = mergeDwiData(dwiData, all_dwis_path, all_bval_path, all_bvec_path)
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
% 

% temporary variable for dwi volumes tracking
tmp_dwi = [];

if ~exist(all_dwis_path, 'file')
    In = dwiData.(acqs{ii}); % make things easier to read
    % open b-val and b-vecs files
    % define tmp variables
    bval = [];
    bvec = [];
    % Loop over the acquisitions
    for ii = 1 : n_acqs
        tmp_dwi = [tmp_dwi ' ' In.vol ];
        tmp_bval = load_bVal(In.bval);
        bval = cat(2, bval, tmp_bval);
        tmp_bvec = importdata(In.bvec);
        bvec = cat(2, bvec, tmp_bvec);
    end
    % Run the merging command
    mrg_cmd = sptintf('fslmerge -t %s %s', all_dwis_path, tmp_dwi);
    [cmd_status, cmd_res] = runSystemCmd(mrg_cmd, 1);
    % Get the bval/bvec files
    mk_bvalFile(bval, all_bval_path);
    mk_bvecFile(bvec, all_bvec_path);
else
    warning('File %s already exist, DWIs stacks NOT merged.', all_dwis_path);
end


