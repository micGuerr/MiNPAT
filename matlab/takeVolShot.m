function takeVolShot(filename, view, fraction, intensity, scale, sliceN, outname)
% 
% Get a shot of a slice of the spcified volume. The output is saved as a 
% ".png" file.
% 
% Usage:
%   takeVolShot(filename, view, fraction, intensity, scale, sliceN, outname)
% 
% Inputs:
%   filename    Input volume filename (string).
%   view        Specify the view. It can be "x", "y" or "z" respectively
%               for sagittal, coronal or axial slice (string).
%   fraction    It is a fraction of image dimension. Value [0,1].
%   intensity   Specify intensity min and max for display range as 
%               [min max]. If empty, the range is automatically specified.
%   scale       Chenge the scale of the image. It should be an integer.
%               If, empty the scale is automatically set.
%   sliceN      Add slice number to the shot
%   outname     Output name (string).
% 
% Output:
%   An image file named "outname".png
% 
% Requirements:
%   It requires FSL installed properly on termial.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

global FSLDIR

%% CHECKS AND INITIALIZATIONS

% Check that the file exists
if ~isfile(filename)
    error('File %s not found.', filename);
end

% Check whether intensity range has been input
if ~isempty(intensity)
    I = sprintf(' -i %d %d', intensity(1), intensity(2));
else
    I = [];
end

% Check whether scaling factor range has been input
if ~isempty(scale)
    S = sprintf(' -s %d', scale);
else
    S = [];
end

% Check is slice number should be inserted
if sliceN
    L = ' -L';
else
    L = [];
end

% Check that output file name extension is right. It needs to be specified.
[outpath, outroot, outext] = fileparts(outname);
if  isempty(outext)
    outname = fullfile(outpath, sprintf('%s.png', outroot));
elseif ~strcmp(outext, '.png')
    warning('File extension "%s" not accepted. File extension automatically set to "png".', outext)
end

%% REAL JOB

% Define FSL's slicer command
slicer_cmd = [fullfile(FSLDIR, 'bin', 'slicer ') filename, ...
                L, ...
                I, ...
                S, ...
                sprintf(' -%s %.2f ', view, fraction) ...
                outname];
% Run the command
runSystemCmd(slicer_cmd, 0, 0);

















