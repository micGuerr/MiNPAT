function [status,result] = runSystemCmd(cmd, print)
% 
% Run the Matlab "system" command with different options depending on the
% usr operationg system
% 
% Inputs:
%   cmd         is the command to run from terminal
%   print       binary. 1 prints to command window the command
% 
% 
% ...
% 
% 


% Use different commands depending on the User operating system
if ismac
    % printf the command
    if print;  fprintf('%s\n',cmd); end
    [status,result] = system(cmd, '-echo'); % Code to run on Mac platform
elseif isunix
    % printf the command
    if print;  fprintf('%s\n',cmd); end
    [status,result] = system(cmd, '-echo'); % Code to run on Linux platform
elseif ispc
    % printf the command
    cmd = strrep(cmd, '\','/');
    cmd = erase(cmd, '//wsl$/Ubuntu');
    if print;  fprintf('%s\n',cmd); end
    status = 0;
    result = 0;
    %[status,result] = system(['wsl ' cmd], '-echo'); % Code to run on Windows platform
else
    disp('Platform not supported')
end

