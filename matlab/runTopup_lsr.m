function [status, result] = runTopup_lsr(all_b0s_path, acqp_file, b0, cnf, baseName, rfield, unwarp_b0)
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

%% First check Topup output is not there

% expected output is
out_topup = [baseName '_fieldcoef.nii.gz'];

if exist(out_topup, 'file')
    warning('It seems topup has been already run. Deleate the existing files if you want to re-run this analysis');
    status = 0;
    result = '';
    return
end

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

if topup_stat
    status = topup_stat;
    result = topup_res;
    return
end
    
%% Correct the b0 images

% If the topup process ended \wo errors

fprintf('\n STEP2: Apply correction to b0 volumes only...\n');

% First I need to list the 4d b0 volumes for each acquisition and the
% index to which they correspnd to in the acqp.txt file
acqs = fieldnames(b0);
n_acqs = length(acqs);
b0_list = b0.(acqs{1}).vol;
idx_list = 1;
for ii = 2:n_acqs
    In = b0.(acqs{ii});
    b0_list = [b0_list ',' In.vol];
    tmp_idx = In.n_b0*(ii-1) + 1;
    idx_list = [ int2str(idx_list) ',' int2str(tmp_idx)];
end


apply_cmd = ['applytopup -i '  b0_list, ...
    ' -x ' idx_list, ...
    ' -a ' acqp_file , ...
    ' -t ' baseName , ...
    ' -o ' unwarp_b0];

[apply_stat,apply_res] = runSystemCmd(apply_cmd, 1);

%% Update status and result of the step

status = ~(~topup_stat * ~apply_stat);
result = sprintf('%s\n%s',topup_res, apply_res);







