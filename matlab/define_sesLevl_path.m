function [anatPath, status] = define_sesLevl_path(subLevl_dir, subID, sesID, stream)
% 
% Defines the folder structure of a spcific subject and sesison for 
% session level analysis.
% 
% Usage:
%   [anatPath, status] = define_sesLevl_path(subLevl_dir, subID, sesID, stream)
% 
% Inputs:
%   subLevl_dir 
%   subID 
%   sesID
%   stream
% 
% Output:
%   status
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% Define different commands based on whether sesID is empty or not
if isempty(sesID)
    mkdir_cmd = [ 'mk_subLevl_dirs', ...
        ' --wrkdir=' subLevl_dir, ...
        ' --subid=' subID, ...
        ' --' stream];
else
    mkdir_cmd = [ 'mk_subLevl_dirs', ...
        ' --wrkdir=' subLevl_dir, ...
        ' --subid=' subID, ...
        ' --sesid=' sesID, ...
        ' --' stream];
end
% Run the command
[status, anatPath] = runSystemCmd(mkdir_cmd, 1 );