function sc = read_sc(sc_file)
% 
% Read a sidecar file with an expected "json" file format.
% 
% sc_file   is the path to the sidecar file.
% 
% bval      is  a structure with fields based on the json file fields
% 
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% Read the config (json) file
fid = fopen(sc_file, 'r');
% Get the text
txt = fscanf(fid, '%s');
% Decode the json structure
sc = jsondecode(txt);

