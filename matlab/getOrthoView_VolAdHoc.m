function getOrthoView_VolAdHoc(filename)
% 
% Merge three shots from orthogonal slice views into a single file. It uses
% options specific to the input volume type. The type is read from the last
% letters of the file name, after "_" symbol, as expected from BIDS format.
%
% Usage:
%   getOrthoView_VolAdHoc(filename)
%
% Inputs:
%   filename    Input volume filename (string).
%
% Output:
%   The picture is saved using the same input filename but with a ".png"
%   extension.
%
%
% If the filetype is not known, default values are used.
% 
% Accteable file types are:
%   T1w
%   T2w
%   dwi
%   magnitude1, magnitude2
%   phasediff
%   epi
%   bold
%
% Check "getOrthoView" for more info.
%
% Requirements:
%   It requires FSL installed properly on termial.
%   It requires "ImageMagick" installed on the terminal.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

global FSLDIR

%% Set up things

% Get parts of the input
[fpath, fname] = niftiFileParts(filename);

% Try to get the file type as the string after last underscore
fsplits = split(fname, '_');
ftype = fsplits{end};

% Define output name
outname = fullfile(fpath, sprintf('%s.png', fname));

% check if the file exists

if ~exist(outname, 'file')  
    %% Set different options for different file types
    [frac, intensity, scale] = setPicturePref(ftype, fname);
    
    %% Extract first volume if 4D
    info_cmd=[fullfile(FSLDIR, 'bin', 'fslinfo ') filename ' | grep dim4'];
    [~,info]=runSystemCmd(info_cmd,0,0);
    info=split(info);
    dim4=info{2};

    if dim4>1
        filename0=fullfile(fpath, sprintf('%s_0.nii.gz', fname));
        firstVol_cmd=['export FSLOUTPUTTYPE=NIFTI_GZ;' fullfile(FSLDIR, 'bin', 'fslroi ') filename, ' ', filename0, ' 0 1'];
        runSystemCmd(firstVol_cmd, 0, 0);
        filename=filename0;
    end

    %% Do the job
    getOrthoView(filename, frac, intensity, scale, outname);
else
    warning('File %s already exist!', outname);
end

