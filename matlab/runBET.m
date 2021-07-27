function [bet_outp, status] = runBET(topup, f)
% 
% Runs FSL's BET
%
% Usage:
%  [bet_outp, status] = runBET(unwarp_b0, f)
% 
% Input
%   unwarp_b0   ...
%   f           fractional intensity threshold (0->1); default=0.5; smaller
%               values give larger brain outline estimates.
% 
% Output:
%   bet_outp    structure in which are stored the paths to topup outputs.
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)
