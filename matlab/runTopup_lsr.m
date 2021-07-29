function [status] = runTopup_lsr(all_b0s_path, acqp_file, b0, cnf, baseName, rfield, unwarp_b0)
% 
% Runs FSL's topup utility using "Least-Squares Restoration" method to
% combine and correct for EPI disortion the b0 iamges
%
% Usage:
%  [status] = runTopup_lsr(all_b0s_path, acqp_file, b0, baseName, rfield, unwarp_b0)
% 
% Input
%   all_b0s_path    structure...
%   acqp_file       is the path and base name in which to save topup output
%   b0
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
fprintf(' "Least-Squares Restoration" method will be used to combine b0 images.\n');

%% Run topup
fprintf('\n STEP1: get susceptibility off-resonance field...\n');
fprintf('This can take some time.\n');

% Define the command
topup_cmd = ['topup --imain='  all_b0s_path, ...
                   ' --datain=' acqp_file, ...
                   ' --config=' cnf, ...
                   ' --out=' baseName, ...
                   ' --fout=' rfield, ...
                   ' --verbose'];

% Run the command
[topup_stat,topup_res] = runSystemCmd(topup_cmd, 1);

%% Correct the b0 images

% If the topup process ended \wo errors
if ~topup_stat

    fprintf('\n STEP2: Apply correction to b0 volumes only...\n');
    
    % First I need to list the 4d b0 volumes for each acquisition and the
    % index to which they correspnd to in the acqp.txt file
    acqs = fieldnames(b0);
    n_acqs = length(acqs);
    b0_list = [];
    idx_list = [];
    for ii = 1:n_acqs
        In = b0.(acqs{ii});
        b0_list = [b0_list ',' In.b0s];
        tmp_idx = In.n_b0*(ii-1) + 1;
        idx_list = [idx_list ',' tmp_idx];
    end

    
    apply_cmd = ['applytopup --imain='  b0_list, ...
                           ' --inindex=' idx_list, ...
                           ' --datatin=' acqp_file , ...
                           ' --topup=' acqp_file , ...
                           ' --out=' unwarp_b0];
    
    [status,apply_res] = runSystemCmd(apply_cmd, 1);
else
    status = topup_stat;
end






