function [status, result] = runEddyCmd(dwis, bval, bvec, mask, ...
                            acqp, idx, topup, do_lsr, eddy_out)
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
                   
%% First check Topup output is not there

% expected output is
exp_output = [eddy_out '.nii.gz'];

if exist(exp_output, 'file')
    warning('It seems Eddy command has already been run. Delate the existing ouput if you would like to repeat the analysis');
    status = 0;
    result = 0;
    return
end


%% Define the command
eddy_cmd = ['eddy_openmp  --imain=' dwis, ...
                        ' --mask=' mask, ...
                        ' --acqp=' acqp, ... 
                        ' --index=' idx, ...
                        ' --bvecs=' bvec,...
                        ' --bvals=' bval, ...
                        ' --topup=' topup, ...
                        ' --out=' eddy_out, ...
                        ' --repol --verbose'];

% Change resampling method if required
if do_lsr
    fprintf('Using "Least-Squares Restoration" for resampling ... \n');
    eddy_cmd = [eddy_cmd ' --resamp=lsr --fep'];
end

% Check if the eutput is already there
% run the command
[status, result] = runSystemCmd(eddy_cmd, 1);


            
