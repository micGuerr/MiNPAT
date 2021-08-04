function logResult(title, result, logFile)
% 
% Saves standard output from a process into a log file/ Append the output
% if logFile already exist.
% 
% Usage:
%   logResult(title, result, logFile)
% 
% Inputs:
%   title       string. Title of the process
%   result      standard output from the process
%   logFile     path to log file
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

fid = fopen(logFile, 'a+');

fprintf(fid, '########################### %s ###########################\n', title);


fprintf(fid, '\n');
fprintf(fid, '%s\n', result);
fprintf(fid, '\n');

fclose(fid);

