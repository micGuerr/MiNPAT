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

% Define a temporary filename. Check whether it already exist.
tmpfile = fullfile(outpath, sprintf('tmpSlicer_%s.png', date));
if isfile(tmpfile)
    warning('A file named %s, already exist. Rename it or delate it in order to proceed.', tmpfile);
    return
end

% Define the three views
views = {'x', 'y', 'z'};
viewNames = {'Sagittal', 'Coronal', 'Axial'};

%% REAL JOB

% Loop over the three views
for ii = 1:3
    % Take the single slice shot
    if v; fprintf('Taking %s slice shot...\n', viewNames{ii}); end
    takeVolShot(filename, views{ii}, frac(ii), intensity, scale, outname)
    if ii > 1
        % Concatenate the output
        conc_cmd = sprintf('convert %s %s +append %s', tmpfile, outname, outname);
        if v; fprintf('%s\n', conc_cmd); end
        %system(conc_cmd, '-echo');
    end
    % copy the output file 
    cp_cmd = sprintf('cp %s %s', outname, tmpfile);
    if v; fprintf('%s\n', cp_cmd); end
    %system(cp_cmd, '-echo');
end

% Remove the temporary file
rm_cmd = sprintf('rm %s', tmpfile);
if v; fprintf('%s\n', rm_cmd); end
%system(rm_cmd, '-echo');






