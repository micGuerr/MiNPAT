function dcmConvert(dcmFolder, subID, sesID, configFile, outpFolder)
% 
% Converts dicom files into NIfTI format. The data are authomatically
% organized into a pre-defined structure which follows the BIDS standard
% (https://bids.neuroimaging.io/).
%
% Usage:
% dcmConvert(dcmFolder, subID, sesID, configFile, outpFolder)
%
% Inputs
%   dcmFolder:  path to the subject folder containing the timepoint
%               folders. Each timepoint folder cointains the corresponding
%               dicom files (string).
%   subID:      subject ID used in the output naming structure (string).
%   sesID:      session IDs used in the output naming structure. They
%               should be one for each timepoint folder (cell array).
%   configFile: path to the json configuration file(string).
%   outpFolder: path to the output folder where to store the NIfTI
%               converted data (string).
% 
% Output
%   NIfTI converted data in the outpFolder.
%
% Assumptions:
% 1. The timepoint labels start with a lowercase "s".
% 2. The timepoint labels have a numeric component. Such component value
%    should be consistent with sesID entries (i.e., lowest number
%    correspond to first timepoint ID, highest number with the last
%    timepoint ID, and so on).
% 3. Last session is divided in two folders, which share the same label
%    numeric component, but one has an extra "a" suffix (e.g., s0001
%    and s0001a).
% 
% Requirements:
%   dcm2niix (https://github.com/rordenlab/dcm2niix).
%   Dcm2Bids (https://github.com/UNFmontreal/Dcm2Bids).
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)
%
% note: add error for overwriting ...

%% List the content of input folder. Store names which start with an "s"
tpsFplder = dir(fullfile(dcmFolder,'s*'));
tpsFplder = tpsFplder(cellfun(@(x) x, {tpsFplder.isdir})); % make sure are all folders


%% Check that the number of folders is equal to sesID dimension. 

n_ses = length(sesID);  % number of session IDs
n_sesFold = length(tpsFplder); % number of folder in dcmFolder

% first let's consider the extra folder for last timepoint
sesID{1,n_ses+1} = sesID{n_ses};
n_ses = length(sesID);  % update the number of session IDs

% if not the same, throw an error
if n_ses ~= n_sesFold
    error('Error. \nThe number of input session IDs should match the number of timepoint folders in:\n %s', ...
        dcmFolder);
end

%% Run Dcm2Bids

% loop over the sessions IDs
for ss = 1:n_ses
    inFolder = fullfile(tpsFplder(ss).folder, tpsFplder(ss).name);
    % write the command
    dcm2bids_cmd = ['dcm2bids' ...
                    ' -d ' inFolder ... 
                    ' -p ' subID ...
                    ' -s ' sesID{ss} ...
                    ' -c ' configFile ... 
                    ' -o ' outpFolder ...
                    ' --forceDcm2niix'];
    % print the string to command line
    fprintf('===============================================\n');
    fprintf('Converting...\n');
    fprintf('Subject ID: %s\n', subID);
    fprintf('Session ID: %s --> %s\n', tpsFplder(ss).name, sesID{ss});
    fprintf('Final command is:\n\n');
    fprintf('%s\n\n',dcm2bids_cmd);
    % execte the command from the operating system
    system(dcm2bids_cmd,'-echo');
end











