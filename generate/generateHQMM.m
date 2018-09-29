function [K, rho0] = generateHQMM(state_dim, output_dim, num_ops)

% Currently unable to generate HQMMs where output_dim > state_dim, since 
% QETLAB's KrausOperators() function doesn't allow it!

% Generate random set of Kraus Operators
S = RandomSuperoperator(state_dim, 1, 1, 0, num_ops*output_dim); % middle element is UNITAL, used to be 0, changed it to 1 on Sep 1...
K = reshape(KrausOperators(S), output_dim, num_ops);

rho0 = RandomDensityMatrix(state_dim);

end