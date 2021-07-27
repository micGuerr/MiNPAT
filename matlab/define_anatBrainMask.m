function [bm, status] = define_anatBrainMask(fsPath, anatData)
% 
% Creates a fine brain mask for anatomical data from FreeSurfer output.
% 
% Usage:
%   [bm, status] = define_anatBrainMask(fsPath, anatData)
% 
% Inputs:
%   fsPath      Path to the freesurfe analysis folder for this specific
%               subject and session.
%   anatData    structure. It must have at least one field called 't1w', in
%               which the path to the T1w image is stored.
%               It can have a second file named 't2w' which stores the path
%               to a T2w image and for which the brain mask wil be create too.
% 
% Outputs:
%   bm          a structure storing the paths to the created masks as well
%               as the masked inputs.
%   status      numeric value describing the status of the executed system
%               command.
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)



