function [topup_outp, status] = runTopup(dwiData)
% 
% Runs FSL's topup utility
%
% Usage:
%  [topup_outp, status] = runTopup(dwiData)
% 
% Input
%   dwiData     structure. It must have two fields named 'ap' (or 'pa') in
%               which the path to the 4D dwi stack is stored.
%               It can have a second field named 'pa' or ('ap') which 
%               stores the path to a diffuaion data acquired with inverted 
%               phase encoding
% 
% Output:
%   topup_outp  structure in which are stored the paths to topup outputs.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)











