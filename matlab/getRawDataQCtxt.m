function getRawDataQCtxt(filename, c1, fList, c2, tmpList, wrkDir, subID, sesID, configFile)
% 
% Create a file for raw data QC.
% 
% Usage:
%   getRawDataQCtxt(filename, c1, fList, c2, tmpList, wrkDir, subID, sesID, configFile)
% 
% Inputs:
%   c1      Outcome flag from "doCheckList" function.
%   fList   File list output from "doCheckList" function.
%   c2      Outcome flag from "doTmpCheckList" function.
%   tmpList   File list output from "doTmpCheckList" function.
%   wrkDir          Path to dcm2bids output directory  (string).
%   subID           subject ID used for dcm2bids conversion (string).
%   sesID           session ID used for dcm2bids conversion (string).
%                   If no session present, use [].
%   configFile      path to the json configuration file (string). 
%
% Output:
%   Create a file based on "filename"
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Setup things

% Open the qc txt file
fid = fopen(filename, 'w+');

% number of expected files
nF = length(fList);
% number of files in the temporasry folder
nTmp = length(tmpList);

% Subject (and sesison) IDs
if isempty(sesID)
    IDs = sprintf('SUBJECT %s', subID);
else
    IDs = sprintf('SUBJECT %s, SESSION %s', subID, sesID);
end

% Overall outcome
if       c1  &&  c2
    outcome = sprintf('%s\n', ...
                'OK! All files are where they should be...');
elseif   c1  && ~c2
    outcome = sprintf('%s\n\t%s', ...
                'WARNING!!! something''s not right...', ...
                'Unexpected files in the tmp_dcm2bids folder.');
elseif  ~c1  &&  c2
    outcome = sprintf('%s\n\t%s', ...
                'WARNING!!! something''s not right...', ...
                'Missing file in the objective folder.');
elseif  ~c1  && ~c2    
    outcome = sprintf('%s\n\t%s\n\t%s', ...
                'WARNING!!! something''s not right...', ...
                'Missing file in the objective folder.', ...
                'Unexpected files in the tmp_dcm2bids folder.');
end

% The tmp_dcm2bids diectory
if isempty(sesID)
    tmpDir = sprintf('sub-%s',subID);
else
    tmpDir = sprintf('sub-%s_ses-%s',subID, sesID);
end
% Define the full path to the directory to check
tmpDir = fullfile(wrkDir, 'tmp_dcm2bids', tmpDir);

%% Write the file

fprintf(fid,'Raw data QC: %s\n', IDs);
fprintf(fid,'\n');
fprintf(fid,'Working directory: %s\n', wrkDir);
fprintf(fid,'\n');
fprintf(fid,'Outcome: %s\n', outcome);
fprintf(fid,'\n');

fprintf(fid,'----------------------------------------------------\n');

fprintf(fid,'\n');
fprintf(fid,'Expected file list based on configuration file\n%s:\n', configFile);
fprintf(fid,'\n');
fprintf(fid,'STAUS \t\t FILE NAME\n');
for ii = 1:nF
    fprintf(fid,'  %d  -  %s\n', fList{ii,2}, fList{ii,1});
end
fprintf(fid,'\n');
fprintf(fid,'*0 indicates expected file is missing. 1 otherwise.\n');
fprintf(fid,'\n');

fprintf(fid,'----------------------------------------------------\n');

fprintf(fid,'\n');
fprintf(fid,'Content of the %s folder:\n', tmpDir);
fprintf(fid,'\n');
fprintf(fid,'STAUS \t\t FILE NAME\n');
for ii = 1:nTmp
    fprintf(fid,'  %d  -   %s\n', tmpList{ii,2}, tmpList{ii,1});
end
fprintf(fid,'\n');
fprintf(fid,'*0 indicates file should not be there. 1 otherwise.\n');
fprintf(fid,'\n');

%% Close the file
fclose(fid);













