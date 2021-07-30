function    [] = mk_bvalFile(bval, bvalFile_path)
% 
% Create a bvalue text file from the bval 
% 
% 
% 

bval_id = fopen(bvalFile_path, 'w+');

fprintf(bval_id,'%d\t', bval);

fclose(bval_id);


