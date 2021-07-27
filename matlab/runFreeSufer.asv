function [status] = runFreeSufer(anatData, fsID, parall)
% 
% Runs freeSurfer analysis
%
% Usage:
%  [status] = runFreeSufer(anatData, fsID, parall)
% 
% Input
%   anatData    structure. It must have at least one field called 't1w', in
%               which the path to the T1w image is stored.
%               It can have a second file named 't2w' which stores the path
%               to a T2w image and which will be used to improve the
%               analsysis.
%   fsID        ID to use in the analysis.
%   parall      number of cores to be used for paralle computing. Leave
%               empty if no parallelization is requred.
% 
% Output:
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

