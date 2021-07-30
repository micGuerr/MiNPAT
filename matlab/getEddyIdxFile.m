function [] = getEddyIdxFile(all_dwis_path, all_bval_path, idxFile_out_path)
% 
% 
% 
% Usage:
%   [] = getEddyIdxFile(all_dwis_path, all_bval_path, idxFile_out_path)
% 
% 
% 
% 
% 

% load the dwis and check how many volumes are there
all_dwis = load_untouch_nii(all_dwis_path);
n_dwis = all_dwis.hdr.dime.dim(5);
% load the all-bvalues file
all_bvals = load_bVal(all_bval_path);


if ~exist(idxFile_out_path, 'file')
    % Check if there is a mismatch between all_dwis number and all b-values
    if n_dwis ~= length(all_bvals)
        error('mismatch between number of volumes in %s and b-values in %s', ...
           all_dwis_path,  all_bval_path);
    end
    % open the file
    fid = fopen(idxFile_out_path, 'w+');
    tmp_idx = 0;
    % loop over the dwi volumes
    for ii = 1: n_dwis
        if all_bvals(ii) == 0
            tmp_idx = tmp_idx+1;
        end
        fprintf(idxFile_out_path, '%d\n', tmp_idx);
    end
    fclose(fid);
else
    warning('File %s already exist, idx_path not overwritten.', idxFile_out_path);
end

