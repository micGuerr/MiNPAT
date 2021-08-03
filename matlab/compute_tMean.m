function [tMean, status, result] = compute_tMean(niftiFile)
% 
% 
% 
% 
% 
% 
% 

%% First define the output

% By default the output has the suffix "_temean"
[niftiFile_path, niftiFile_name] = niftiFileParts(niftiFile);
tMean = fullfile(niftiFile_path, sprintf('%s_tmean.nii.gz', niftiFile_name));

%% Check if the file exist
if exist(tMean, 'file')
    warning('file %s already exist. Deleate the existing file if you want to re-run this analysis', ...
        tMean);
    status = 0;
    result = 0;
    return
end

%%

% Define the command
mean_cmd = sprintf('fslmaths %s -Tmean %s', niftiFile, tMean);
% run the command
[status, result] = runSystemCmd(mean_cmd, 1);

