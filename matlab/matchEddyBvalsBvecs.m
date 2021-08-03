function matchEddyBvalsBvecs(do_lsr, sing_acq_bval_path, all_bval_path, eddy_baseName, eddy_bval, eddy_bvec)
% 
% Returns bvalue and bvector files consistent with the type of
% reconstruction used in eddy.
% Namely, with lsr if the input has N volumes the output has N/2.
% If no lsr (jac) is used inut and outpu are of dimension N.
% 
% Usage:
%   matchEddyBvalsBvecs(do_lsr, sing_acq_bval_path, all_bval_path, eddy_baseName, eddy_bval, eddy_bvec)
% 
% Inputs:
%   do_lsr              binary. reconstruction method.
%   sing_acq_bval_path  bval file from single acquisition. needed if do_lsr=1.
%   all_bval_path       bval file from all acquisitions. needed if
%                       do_lsr=0.
%   eddy_baseName       eddy output basename.
%   eddy_bval           correct bval name
%   eddy_bvec           correct bvec name
%
% Output:
%   Create eddy_bval and eddy_bvec files
%
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% First check the output doesn't exist
if exist(eddy_bval, 'file') || exist(eddy_bvec, 'file')
    warning('File %s or %s already exist.', eddy_bval, eddy_bvec);
    return
end

%% Define some inputs

all_bvec_path = sprintf('%s.eddy_rotated_bvecs', eddy_baseName);
sing_acq_bval = load_bVal(sing_acq_bval_path);
n_sing_bval = size(sing_acq_bval,2);


if do_lsr
    % copy single session bval as final bval file
    copyfile(sing_acq_bval_path, eddy_bval);
    % need to compute the average of the rotated bvalues 
    tmp_bvec = importdata(all_bvec_path);
    % total number of volumes
    n_bvec = size(tmp_bvec,2);
    % number of different acquisitions (sessions)
    n_acq = n_bvec/n_sing_bval;
    % 3d array in which third dimension is the different acquisitions
    sing_acq_bvec = reshape(tmp_bvec(:,:), [3, n_sing_bval, n_acq]);
    sing_acq_bvec = mean(sing_acq_bvec, 3);
    sing_acq_bvec = sing_acq_bvec./vecnorm(sing_acq_bvec);
    % write the result as a file
    mk_bvecFile(sing_acq_bvec, eddy_bvec);
else
    % just copy all bvalues and all bvecs
    copyfile(all_bval_path, eddy_bval);
    copyfile(all_bvec_path, eddy_bvec);
end
