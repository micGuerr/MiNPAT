function [filepath, filename, ext] = niftiFileParts(niftiFilename)
% 
% Get parts of a nifti file name
% 
% Usage:
%   [filepath, filename, ext] = niftiFileParts(niftiFilename)
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

if contains(niftiFilename, '.nii.gz')
    tmp_fname = niftiFilename(1:end-7);
    [filepath, filename] = fileparts(tmp_fname);
    ext = '.nii.gz';
elseif contains(niftiFilename, '.nii')
    tmp_fname = niftiFilename(1:end-4);
    [filepath, filename] = fileparts(tmp_fname);
    ext = '.nii';
else
    error('file %s has no ''.nii.gz'' nor ''.nii'' extension !!', ...
        niftiFilename)
end

