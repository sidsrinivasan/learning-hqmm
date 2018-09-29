function M = getQMeasOp(C)

dim = size(C, 2);
output_dim = size(C, 1);
% Alternate observation matrices (unitary)
M = zeros(dim * output_dim);
for i=1:dim
    col1 = sqrt(C(:,i));
    tempMat = repmat(col1, 1, output_dim);
    othercols = null(tempMat');
    currRotMatrix = [col1, othercols];
    
    endDim = i*output_dim;
    M(endDim-output_dim+1:endDim, endDim-output_dim+1:endDim) = currRotMatrix;
end