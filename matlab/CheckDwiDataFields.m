function CheckDwiDataFields(dwiData)
% 
% 
% 
% 
% 
% 

% Get dwiData acquisitions
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
