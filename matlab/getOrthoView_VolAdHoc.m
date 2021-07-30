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
    
    %% Do the job
    getOrthoView(filename, frac, intensity, scale, outname)
else
    warning('File %s already exist!', outname);
end

