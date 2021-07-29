function bval = load_bVal(b_file)
% 
% Load b values from a b value file. Performs an approximation to
% avoid fluctuations due to reading gradients
% 
% b_file    is the b_values file. It is expected in s/mm^2
% 
% bval      is  a Nx1 vector
% 
% 
% Author:
%   Michele Guerreri (m.guerreri@ucl.ac.uk)

% load the b-value file
bval = importdata(b_file);

% I want to round the b-values as sometimes, even though formally
% identical, they practically differ because of the reading gradinets

% Take the order of magnitude for each b-value
n = floor( log10(bval+eps));

% define an rounding function. It rounds to the closest number in steps of
% "a".
steps_round = @(x,a) round(x./a, 0).*a;

% for the b-values lower than 100 round in steps of 25
bval(n <= 0) = steps_round(bval(n <= 0), 25);
% for higher bvalues round in steps of 50
bval(n > 0) = steps_round(bval(n > 0), 50);




