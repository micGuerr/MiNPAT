function [status] = runTopup_jac(all_b0s_path, acqp_file, cnf, baseName, rfield, unwarp_b0)
% 
% Runs FSL's topup utility using "jacobian modulation" method to
% combine and correct for EPI disortion the b0 iamges
%
% Usage:
%  [status] = runTopup_jac(all_b0s_path, acqp_file, cnf, baseName, rfield, unwarp_b0)
% 
% Input
%   all_b0s_path    structure...
%   acqp_file       is the path and base name in which to save topup output
%   cnf             ...
%   baseName
%   rfield
%   unwarp_b0
% 
% Output:
%   status      numeric value describing the status of the executed system
%               command.
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%%

fprintf(' ************************* Running TOPUP ****************************\n');
fprintf(' "jacobian modulation" method will be used to combine b0 images.\n');

%% Run topup
fprintf('\nGet susceptibility off-resonance field and correct b0 volumes in one step...\n');
fprintf('This can take some time.\n');

% Define the command
topup_cmd = ['topup --imain='  all_b0s_path, ...
                   ' --datain=' acqp_file, ...
                   ' --config=' cnf, ...
                   ' --out=' baseName, ...
                   ' --fout=' rfield, ...
                   ' --iout=' unwarp_b0, ...
                   ' --verbose'];

% Run the command
[status,topup_res] = runSystemCmd(topup_cmd, 1);




