function update_pathSetup(filePath, fields, paths)
% 
% Upadet the fields of the pathSetup.m file
% 
% Usage:
%   update_pathSetup(filePath, fields, paths)
% 
% Inputs:
%   filePath       path to pathSetup.m file
%   fields         cell array with the fields to update
%   paths          cell array with corresponding paths to update
% 
% Outputs:
%   Update the file
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

%% Check the stage and paths have same length

if length(fields)  ~= length(paths)
    error('Length of fields and paths MUST be the same')
end

%% load the file and read it
fid = fopen(filePath, 'r');
C = textscan(fid,'%s','delimiter','\n');
C = C{1};
fclose(fid);

%% Check number of fields and do update
n_fields = length(fields);

for ff = 1 : n_fields
    % looks for fields
    idx1 = find(contains(C,[fields{ff} ' = ']));
    if ~isempty(idx1) && ~isempty(paths{ff})
        if ischar(paths{ff})
            C{idx1} = sprintf('%s = ''%s'';', fields{ff}, paths{ff});
        elseif isnumeric(paths{ff})
            C{idx1} = sprintf('%s = %d;', fields{ff}, paths{ff});
        elseif iscell(paths{ff})
            n_cells = length(paths{ff});
            tmp_str = '{';
            for jj = 1:n_cells
                tmp_str = strcat(tmp_str , '''', paths{ff}{jj}, '''', ',');
            end
            tmp_str = strcat(tmp_str(1:end-1), '}');
            C{idx1} = sprintf('%s = %s;', fields{ff}, tmp_str);
        end
    end
    % looks for function names
    idx2 = find(contains(C,['function ' fields{ff}]));
    if ~isempty(idx2) && ~isempty(paths{ff})
        C{idx2} = ['function ' paths{ff}];
    end    
end

%% Overwrite the file

fid = fopen(filePath, 'w+');
for ii = 1 : length(C)
    fprintf(fid, '%s\n', C{ii});
end
fclose(fid);

