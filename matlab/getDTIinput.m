function [dti_in_dwi, dti_in_bval, dti_in_bvec] = getDTIinput(dwiPath, bvalPath, bvecPath, dtiInPath)
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)
 

%% First define outputs and check whether they elready exist
dti_in_dwi = sprintf('%s.nii.gz', dtiInPath);
dti_in_bval = sprintf('%s.bval', dtiInPath);
dti_in_bvec = sprintf('%s.bvec', dtiInPath);

if exist(dti_in_dwi, 'file')
    warning('File %s already exist, DWI stack NOT merged.', dti_in_dwi);
    return
end

%% Also, create the inpuit folder if needed
[dtiInDir] = fileparts(dtiInPath);

if ~exist(dtiInDir, 'dir')
    mkdir(dtiInDir);
end

%% Check if there are b-values higer than 1500 s/mm^2

bval = load_bVal(bvalPath);
high_b = bval(bval > 1500);

if ~isempty(high_b)
    % if so, take only b-values lower than 1500 as dti input
    splitDWI_byB(dwiPath, bvalPath, bvecPath, ...
                    dti_in_dwi, dti_in_bval, dti_in_bvec, ...
                    -1500);
else
    % else, create a soft link
    [status1] = ln_files(dwiPath, dti_in_dwi);
    [status2] = ln_files(bvalPath, dti_in_bval);
    [status3] = ln_files(bvecPath, dti_in_bvec);
end



