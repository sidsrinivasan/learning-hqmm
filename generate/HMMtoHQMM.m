function [rho, K] = HMMtoHQMM(x, A, C)

dim = size(C, 2);
output_dim = size(C,1);

rho = diag(x);

%% Time Evolution: Unitary to Kraus
% Time Evolution of Joint State
U = getQEvolveOp(A); 

% Tensor Product with prepared state
W1 = zeros(dim^2, dim);
for i=1:dim:dim^2
    W1(i, ((i-1)/dim)+1) = 1;
end

% Trace over particle 1
V1 = zeros(dim, dim^2, dim);
for i = 1:dim
    V1(:, ((i-1)*dim)+1:((i-1)*dim)+dim, i) = eye(dim);
end


% Combine V,U,W1 into Kraus operator
E = zeros(dim, dim, dim);
for i=1:dim
    E(:,:,i) = V1(:,:,i) * U * W1;
end

% Test \sum E'E = I
sumE = zeros(dim,dim);
for i=1:dim
    sumE = sumE + E(:,:,i)'*E(:,:,i);
end

%% Measurement and Projection: Unitary to Kraus
% Emission Operator Analog
M = getQMeasOp(C);

% Projection Operator for each observable
P = zeros(dim*output_dim, dim*output_dim, output_dim);
for i=1:output_dim
    P(:, :, i) = getQProjOp(i, dim, output_dim);
end

% Tensor Product with observable output
W2 = [];
for i=1:dim
    temp = zeros(output_dim, dim);
    temp(1,i) = 1;
    W2 = vertcat(W2, temp);
end

% Trace over particle 2
V2 = zeros(dim, dim*output_dim, output_dim);
for j=1:output_dim
    layer = [];
    for i=1:dim
        temp=zeros(dim,output_dim);
        temp(i,j)=1;
        layer = horzcat(layer, temp);
    end
    V2(:,:,j) = layer;
end

% Combine V2, P, M, W2 into Kraus Operator
F = zeros(dim, dim, output_dim, output_dim);
for i = 1:output_dim
    for j = 1:output_dim
    F(:,:,i,j) = V2(:,:,i) * P(:,:,j) * M * W2;
    end
end

%% Create final Kraus operators K
K = cell(output_dim, dim);
for i=1:dim
    for j=1:output_dim
        K{j,i} = F(:,:,j,j) * E(:,:,i);
    end
end

% Test \sum K'*K = I; K CAN BE SQUEEZED SINCE ONLY NON ZERO WHEN j=k
total = zeros(dim);
for i=1:dim
    for j=1:output_dim
        total = total + K{j,i}'*K{j,i};
    end
end
% total
end