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
%   Michele Guerreri (m.guerreri@ucl.ac.uk)]

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
    idx = find(contains(C,[fields{ff} ' = ']));
    if ~isempty(idx) && ~isempty(paths{ff})
        C{idx} = [fields{ff} ' = ' paths{ff}];
    end
end

%% Overwrite the file

fid = fopen(filePath, 'w+');
for ii = 1 : length(C)
    fprintf(fid, '%s\n', C{ii});
end
fclose(fid);

