function    [] = mk_bvecFile(bvec, bvecFile_path)
% 
% Create a bvalue text file from the bval 
% 
% 
% 

bvec_id = fopen(bvecFile_path, 'w+');

fprintf(bvec_id,'%d\t', bvec(1,:));
fprintf(bvec_id,'\n');
fprintf(bvec_id,'%d\t', bvec(1,:));
fprintf(bvec_id,'\n');
fprintf(bvec_id,'%d\t', bvec(1,:));

fclose(bvec_id);


