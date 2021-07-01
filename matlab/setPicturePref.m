function [frac, intensity, scale] = setPicturePref(fileType)
% 
% Sets different viewing options for 2D pictures of 3D image volumes.
%   
% Usage:
%   [frac, intensity, scale] = setPicturePref(fileType)
% 
% Input:
%   fileType    string defining the file type. Accteable file types are
%   T1w, T2w, dwi,  magnitude1, magnitude2, phasediff, epi, bold. If the
%   filetype is not known, empty values are returned.
% 
% Outputs:
%   frac        which fraction of the image dimension to visualize. One for
%               each dimension [sagittal coronal axial].
%   intensity   Intensity range [min max].
%   scale       magnifying scale.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

switch fileType
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