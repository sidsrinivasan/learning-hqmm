function U = getQEvolveOp(A)

dim = size(A, 1);

U = zeros(dim^2);
for i=1:dim
    col1 = sqrt(A(:,i));
    tempMat = repmat(col1, 1, dim);
    othercols = null(tempMat');
    currRotMatrix = [col1, othercols];
    
    endDim = i*dim;
    U(endDim-dim+1:endDim, endDim-dim+1:endDim) = currRotMatrix;
end