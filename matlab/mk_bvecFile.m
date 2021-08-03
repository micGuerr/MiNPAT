function    [] = mk_bvecFile(bvec, bvecFile_path)
% 
% Create a bvalue text file from the bval 
% 
% 
% 

bvec_id = fopen(bvecFile_path, 'w+');

fprintf(bvec_id,'%f\t', bvec(1,:));
fprintf(bvec_id,'\n');
fprintf(bvec_id,'%f\t', bvec(2,:));
fprintf(bvec_id,'\n');
fprintf(bvec_id,'%f\t', bvec(3,:));

fclose(bvec_id);


