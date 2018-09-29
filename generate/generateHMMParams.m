function [x, A, C] = generateHMMParams(state_dim, output_dim)

x = rand(state_dim, 1);
x = x/sum(x);

A = rand(state_dim, state_dim);
C = rand(output_dim, state_dim);
colsumA = sum(A, 1);
colsumC = sum(C, 1);
A = bsxfun(@rdivide, A, colsumA);
C = bsxfun(@rdivide, C, colsumC);
