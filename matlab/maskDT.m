function [farrm_dt, status, result] = maskDT(dti, farrm_mask)
% 
% 
% 
% 
% 
% 
% 

% define output
farrm_dt = struct();

% get DT names
dt_names = fieldnames(dti);

%
status = 0;
result = '';

for ii = 1:length(dt_names)
    % parse input names and create a new corresponding output name
    tmp_in_dt = dti.(dt_names{ii});
    [tmp_path, tmp_name] = niftiFileParts(tmp_in_dt);
    tmp_out_farrm =  fullfile(tmp_path, sprintf('%s_msk.nii.gz',tmp_name));
    
    % check if the file already exist
    % Let's make sure mask exist
    if exist( tmp_out_farrm, 'file')
        warning(' file %s already exists.', tmp_out_farrm);
        continue
    end
    
    % define the command to mask the input
    mask_cmd = sprintf('fslmaths %s -mas %s %s', tmp_in_dt, farrm_mask, tmp_out_farrm);
    [tmp_stat, tmp_res] = runSystemCmd(mask_cmd, 1);
    
    % Assign the new file to the output structure
    farrm_dt.(dt_names{ii}) = tmp_out_farrm;
    
    % Update status and result of the step
    status = ~(~status * ~tmp_stat);
    result = sprintf('%s\n%s',result, tmp_res);
end
