function [eddy_outp, status] = runEddy(dwiData, topup, mask, acqp_file, baseName, parall)
% 
% Runs FSL's Eddy
%
% Usage:
%  [eddy_outp, status] = runEddy(dwiData, topup, mask, parall)
% 
% Input
%   dwiData     structure.
%   topup       Output of topup step.
%   mask        path to brain mask
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

%% First thing, let's parse the DWI acquisition information. 
%  Let's check everything needed is there.

acqs = fieldnames(dwiData);
n_acqs = length(acqs);

% The fields "vol", "bval", "bvec", "sc" are expected for each acquisition
for ii = 1 : n_acqs
    In = dwiData.(acqs{ii}); % make things easier to read
    if ~isfield(In, 'vol') || ...
            ~isfield(In, 'bval') || ...
            ~isfield(In, 'bvec') || ...
            ~isfield(In, 'sc')
        error('''vol'', ''bval'', ''bvec'' or ''sc'', missing in acquisition %s !!', ...
            acqs{ii} );
    end
end

% Let's make sure that topup run
if ~exist( [topup, '_fieldcoef.nii.gz'], 'file')
    error('Output from topup seems to be missing');
end

% Let's make sure that bet run
if ~exist( mask, 'file')
    error('Output from bet seems to be missing');
end

%% Next, check the output folder exists. If not create it

% extract topup folder from the baseName
[eddyDir, eddyBname] = fileparts(baseName);

if ~exist(eddyDir, 'dir')
    mkdir(eddyDir);
end


%% Let's now merge all the diffusion volumes together.
% We also need to merge the b-values and bvecs.

% the output being
all_dwis_path = sprintf(eddyDir, 'allDwis.nii.gz');
all_bval_path = sprintf(eddyDir, 'allBval.bval');
all_bvec_path = sprintf(eddyDir, 'allBvec.bvec');

[mrg_status, mrg_res] = mergeDwiData(dwiData, all_dwis_path, all_bval_path, all_bvec_path);


%% Now let's define the idx file. This should have an index correpsonding 
% to the line ...

% define the output indices file
idx_path = fullfile(eddyDir, 'inidices.txt');


getEddyIdxFile(all_dwis_path, all_bval_path, idx_path);




%% Run Eddy
