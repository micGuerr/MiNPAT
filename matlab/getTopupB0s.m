function b0 = getTopupB0s(dwiData, topupDir)
% 
% 
% 
% 
% 
% 
% 
% 

% Define the output
b0 = struct();

% Get dwiData acquisitions
acqs = fieldnames(dwiData);
n_acqs = length(acqs);

% Loop over the acquisitions
for ii = 1 : n_acqs
    
    % make things easier to read
    In = dwiData.(acqs{ii});
    
    % the extracted b0s are saved as 4d vol named:
    tmp_b0_path = fullfile(topupDir, sprintf('b0_%s.nii.gz', acqs{ii}));
    
    % extract the b0s
    Out = struct();
    [Out.b0idx, ... 
        Out.n_b0, Out.acqp] = extractB0s(In.vol, In.bval, In.sc, tmp_b0_path);
    Out.vol = tmp_b0_path;
    
    % Save the info for this acquisition
    b0.(acqs{ii}) = Out;
end
