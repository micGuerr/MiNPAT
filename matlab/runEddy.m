function [eddy_outp, status] = runEddy(dwiData, topup, bet, parall)
% 
% Runs FSL's Eddy
%
% Usage:
%  [eddy_outp, status] = runEddy(dwiData, topup, bet, parall)
% 
% Input
%   dwiData     structure.
%   topup       Output of topup step.
%   bet         Output of bet step.
%   parall      number of cores to be used for paralle computing. Leave
%               empty if no parallelization is requred.
% 
% Output:
%   eddy_outp   structure in which are stored the paths to topup outputs.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

