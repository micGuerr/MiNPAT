function [status, result] = runFAring_rm(fa_map, outname)
% 
% Run Fa ring removal.
% 
% Usage:
%   [status, result] = runFAring_rm(fa_map, outname)
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Check if the file already exist first

if exist( outname, 'file')
    warning(' file %s already exists.', outname);
    status = 0;
    result = '';
    return
end



%% Define and run the command

cmd = sprintf('faRing_rm %s %s', fa_map, outname);

[farrm_stat, farrm_res] = runSystemCmd(cmd, 1);

%% delete extra files produced

[out_path, out_name] = niftiFileParts(outname);

farrm_mask = fullfile(out_path, sprintf('%s_mask.nii.gz', out_name));
delete(farrm_mask);

%%  turn FA output in a mask refine also the edges

refMask_cmd = sprintf('fslmaths %s -bin -ero -ero -dilM -dilM %s', outname, outname);
[refMask_stat, refMask_res] = runSystemCmd(refMask_cmd, 1);

% Update status and result of the step
status = ~(~farrm_stat * ~refMask_stat);
result = sprintf('%s\n%s',farrm_res, refMask_res);

