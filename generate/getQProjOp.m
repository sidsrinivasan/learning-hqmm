function P = getQProjOp(s, dim, output_dim)

P = zeros(dim * output_dim);
for j=s:output_dim:dim*output_dim
    P(j,j) = 1;
end