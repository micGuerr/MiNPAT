function getVolSpecOrthoView(filename)
% 
% Merge three shots from orthogonal slice views into a single file. It uses
% options specific to the input volume type. The type is read from the last
% letters of the file name, after "_" symbol, as expected from BIDS format.
% 
% The images is saved using the same input filename but with a ".png"
% extension.
%
% If the fulitype is not known, default values are used.
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
[fpath, fname] = fileparts(filename);
% usually inputs should be gzipped, then ...
if contains(fname, '.nii')
    [~, fname] = fileparts(fname);
end

% Try to get the file type as the string after last underscore
unds = strfind(fname, '_');
ftype = fname( unds(end)+1 : end );

% Define output name
outname = fullfile(fpath, sprintf('%s.png', fname));

%% Set different options for different file types
switch ftype
    case 'T1w'
        frac = [.5 .3 .7];
        intensity = [0 600];
        scale = 2;
    case 'T2w'
        frac = [.5 .3 .7];
        intensity = [0 300];
        scale = 2;
    case 'dwi'
        frac = [.5 .4 .4];
        intensity = [0 15000];
        % exception for noise maps
        if contains(fname, 'noise'); intensity = []; end
        scale = 3;
    case {'magnitude1', 'magnitude2'}
        frac = [.5 .4 .4];
        intensity = [0 1500];
        scale = 3.5;
    case 'phasediff'
        frac = [.5 .4 .4];
        intensity = [- 4000 4000];
        scale = 3.5;
    case 'epi'
        frac = [.5 .4 .4];
        intensity = [0 15000];
        scale = 3.5;
    case 'bold'
        frac = [.5 .4 .4];
        intensity = [];
        scale = 3.5;
    otherwise
        frac = [];
        intensity = [];
        scale = [];
end
    
%% Do the job

getOrthoView(filename, frac, intensity, scale, outname)

