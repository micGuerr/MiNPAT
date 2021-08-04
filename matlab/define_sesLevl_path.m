function [stramPath, status, result] = define_sesLevl_path(subLevlAn_dir, subID, sesID, stream)
% 
% Defines the folder structure of a spcific subject and sesison for 
% session level analysis.
% 
% Usage:
%   [stramPath, status] = define_sesLevl_path(subLevl_dir, subID, sesID, stream)
% 
% Inputs:
%   subLevl_dir 
%   subID 
%   sesID
%   stream
% 
% Output:
%   stramPath
%   status
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% Define different commands based on whether sesID is empty or not
if isempty(sesID)
    mkdir_cmd = [ 'mk_subLevl_dirs', ...
        ' --wrkdir=' subLevlAn_dir, ...
        ' --subid=' subID, ...
        ' --' stream];
else
    mkdir_cmd = [ 'mk_subLevl_dirs', ...
        ' --wrkdir=' subLevlAn_dir, ...
        ' --subid=' subID, ...
        ' --sesid=' sesID, ...
        ' --' stream];
end
% Run the command
[status, result] = runSystemCmd(mkdir_cmd, 1 );
% Remove the "new-line" from the output path
stramPath = result(1:end-1);