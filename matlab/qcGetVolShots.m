function qcGetVolShots(wrkDir, fList)
% 
% Help performing quality check producing orthogonal views from a lis of
% volumes
% 
% Usage:
%   qcGetVolShots(wrkDir, fList)
% 
% Inputs:
%   wrkDir      Path to dcm2bids output directory, better if full path.
%   fList       List of file to be checked. Must be in a Nx1 cell
%               array.
% 
% Outputs:
%   png files saved in each file folder with same name as the input
% 
% Requirements:
%   It requires FSL installed properly on termial.
%   It requires "ImageMagick" installed on the terminal.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% number of file in the list
nF = length(fList);

for ii = 1:nF
    % input the full path
    filename = fullfile(wrkDir, fList{ii});
    % Do the job ...
    getOrthoView_VolAdHoc(filename);
end


