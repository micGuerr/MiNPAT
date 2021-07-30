function is_eq = isSameProtcol(dwiData)
% 
% 
% 
% 
% 
% 

% Check the different acquisitions
acqs = fieldnames(dwiData);
n_acqs = length(acqs);

% initialize is_eq
is_eq = 1;

% loop over acquisitions
for ii = 1 : n_acqs-1
    % Check he acquisition pair-wise
    In1 = dwiData.(acqs{ii});
    In2 =dwiData.(acqs{ii+1});
    % load the bvals
    bval1 = load_bVal(In1.bval);
    bval2 = load_bVal(In2.bval);
    % load bvecs
    bvec1 = importdata(In1.bvec);
    bvec2 = importdata(In2.bvec);
    % Check if there are differences
    is_eq_bval = isequal(bval1, bval2);
    is_eq_bvec = isequal(bvec1, bvec2);
    % update is_eq
    is_eq = is_eq * is_eq_bval * is_eq_bvec;
end
