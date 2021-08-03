function [] = getTopupAcqpFile(b0, acqp_file)
% 
% 
% 
% 
% 
% 
% 
% 
% 

%% first check if the file already exist
if exist(acqp_file, 'file')
    warning('file %s already exist. The existing  copy will be used in the analysis', ...
        acqp_file);
    return
end

%% Get b0 acquisitions fields
acqs = fieldnames(b0);
n_acqs = length(acqs);

% open the file
fid = fopen(acqp_file, 'w+');

for ii = 1 : n_acqs
    
    % make things easier to read
    In = b0.(acqs{ii});
    
    % loop over the b0s
    for jj = 1 :  In.n_b0
        % print the parameters
        fprintf(fid, '%d %d %d %f\n', In.acqp(:) );
    end
end

fclose(fid);