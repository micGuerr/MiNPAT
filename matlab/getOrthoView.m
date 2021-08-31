function getOrthoView(filename, frac, intensity, scale, outname, varargin)
% 
% Merge three shots from orthogonal slice views into a single file. The
% levels at which each shot is taken can be specified.
% 
% Usage:
%   getOrthoView(filename, frac, intensity, scale, outname, verbose)
% 
% Inputs:
%   filename    Input volume filename (string).
%   frac        Fraction of image dimensions [0,1]. Specified as:
%               [sagittal coronal axial]. If empty, the default fractions
%               are [.5 .5 .5].
%   intensity   Specify intensity min and max for display range as 
%               [min max]. If empty, the range is automatically specified.
%   scale       Chenge the scale of the image. It should be an integer.
%               If, empty the scale is automatically set.
%   outname     Output name (string).   
%   verbose     1 if you want to print to screen commands, 0 otherwise.
%   
% Output:
%   An image file named "outname".png
% 
% Requirements:
%   It requires FSL installed properly on termial.
%   It requires "ImageMagick" installed on the terminal.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)
%
% Notes: consider using python to append images.


%% CHECKS AND INITIALIZATIONS

if nargin > 5
    v = varargin{1};
else
    v = 0;
end

% Check whether the fractions have been input
if isempty(frac)
    frac = [ 0.5 0.5 0.5];
end

% Check that output file name extension is right. It needs to be specified.
[outpath, outroot, outext] = fileparts(outname);
if  isempty(outext)
    outname = fullfile(outpath, sprintf('%s.png', outroot));
elseif ~strcmp(outext, '.png')
    warning('File extension "%s" not accepted. File extension automatically set to "png".', outext)
end

% Define the three views
views = {'x', 'y', 'z'};
viewNames = {'Sagittal', 'Coronal', 'Axial'};
concat_input = [];

%% REAL JOB

% Loop over the three views
for ii = 1:3
    % Take the single slice shot
    if v; fprintf('Taking %s slice shot...\n', viewNames{ii}); end
    tmpName = fullfile(outpath, sprintf('tmpSlicer_%s_%s.png', viewNames{ii}, date));
    takeVolShot(filename, views{ii}, frac(ii), intensity, scale, 1, tmpName);
    concat_input = [concat_input ' ' tmpName];
end

conc_cmd = sprintf('h_concat %s %s', outname, concat_input);
runSystemCmd(conc_cmd, v, v);

% Remove the temporary file
rm_cmd = sprintf('rm %s', fullfile(outpath, sprintf('tmpSlicer_*_%s.png', date)));
runSystemCmd(rm_cmd, v, v);






