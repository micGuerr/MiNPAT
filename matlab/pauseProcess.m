function pauseProcess(stepTile)
% 
% pause the processing and print some useful info
%
% Usage:
%   pauseProcess(stepTile)

fprintf('\n\n');
fprintf('Please, check %s step output before advancing to the next step.\n', stepTile);
fprintf('Check https://github.com/micGuerr/MiNPAT to know what you should expect from this step.\n');
fprintf('Press any button when you are ready to advance...\n');
pause;
