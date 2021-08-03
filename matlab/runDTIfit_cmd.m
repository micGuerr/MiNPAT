function [dti, status, result] = runDTIfit_cmd(dwi, bval, bvec, mask, outpath)
% 
% Simply run the FSL's difit command
% 
% 
% 
% 
% 
% 
% 

%% First define outputs and check whether they elready exist

% Definethe output structure
dti = struct();
dti.MD = sprintf('%s_MD.nii.gz', outpath);
dti.FA = sprintf('%s_FA.nii.gz', outpath);
dti.L1 = sprintf('%s_L1.nii.gz', outpath);
dti.L2 = sprintf('%s_L2.nii.gz', outpath);
dti.L3 = sprintf('%s_L3.nii.gz', outpath);
dti.V1 = sprintf('%s_V1.nii.gz', outpath);
dti.V2 = sprintf('%s_V2.nii.gz', outpath);
dti.V3 = sprintf('%s_V3.nii.gz', outpath);
dti.sse = sprintf('%s_sse.nii.gz', outpath);

if exist(dti.MD, 'file')
    warning('File %s already exist, DTIFIT didn''t run.', dti.MD);
    return
end

%% Define and run the command

% define the command
dti_cmd = ['dtifit -k ' dwi, ...
                 ' -o ' outpath, ...
                 ' -m ' mask, ...
                 ' -r ' bvec, ...
                 ' -b ' bval, ...
                 ' --verbose ', ...
                 ' --sse ', ...
                 ' --wls '];

             
% run it
[status, result] = runSystemCmd(dti_cmd, 1);
