function [status, result] = ln_files(inFile, targetLinkName)
% 
% Create a soft link
% Usage: 
%   [status, result] = ln_files(inFile, targetLinkName)
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

cmd = sprintf('ln -s %s %s', inFile, targetLinkName);

[status, result] = runSystemCmd(cmd, 0, 0);
