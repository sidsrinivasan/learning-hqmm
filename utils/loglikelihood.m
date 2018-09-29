function L = loglikelihood(y,K,rho,varargin)
%% Function to compute the log-likelihood sequence for a 
% The function that usually determines how quickly (in terms of training
% time) the algorithm learns. 

% varargin: burn_in
% y should be a column vector
% if given a burn_in...
if nargin == 4
    burn_in = varargin{1};
        
    % speedup available when only 1 Kraus operator per observable
    if size(K,2) == 1
        % burn in
        for i = 1:burn_in
            rho = K{y(i)} * rho * K{y(i)}';
            rho = rho/trace(rho);
        end

        % now calculate LL
        krausProduct = log(K{y(burn_in+1)});

        for i = burn_in+2:size(y,1)
            krausProduct = logdotexp(log(K{y(i)}), krausProduct);
        end
        L = real(logsumexp(diag(logdotexp(logdotexp(krausProduct, log(rho)), krausProduct'))));
    else
        % burn in
        for i = 1:burn_in
            temp = zeros(size(rho));
            for j = 1:size(K,2)
                temp = temp + (K{y(i), j} * rho * K{y(i), j}');
            end
            rho = temp/trace(temp);
        end
        
        % precompute conj(K) \otimes K for each s
        K_lookup = zeros(size(rho,1)^2, size(rho,1)^2, size(K,1));
        for i = 1:size(K,1)
            temp = zeros(size(rho,1)^2, size(rho,2)^2, size(K,2));
                for j = 1:size(K,2)
                    temp(:,:,j) = log(kron(conj(K{i, j}), K{i, j}));
                    if sum(sum(isnan(temp(:,:,j)))) > 0
                        temp(:,:,j) = zeros(size(rho)) - Inf;
                    end
                end
            K_lookup(:,:,i) = logsumexp(temp, 3);
        end
            
        % now calculate LL
        rho = log(rho);
        krausProduct = log(eye(size(rho,1)^2));
        for i = burn_in+1:size(y,1)
            krausProduct = logdotexp(K_lookup(:,:,y(i)), krausProduct);
        end
        L = real(logsumexp(diag(reshape(logdotexp(krausProduct, reshape(rho, size(rho,1)^2, 1)), size(rho, 1), size(rho,2)))));
    end

else
    % use available speedup if only 1 Kraus operator per observable
    if size(K,2) == 1
        krausProduct = log(K{y(1)});

        for i = 2:size(y,1)
            krausProduct = logdotexp(log(K{y(i)}), krausProduct);
        end
        L = real(logsumexp(diag(logdotexp(logdotexp(krausProduct, log(rho)), krausProduct'))));

    else
        % precompute conj(K)*K for each s
        K_lookup = zeros(size(rho,1)^2, size(rho,1)^2, size(K,1));
        for i = 1:size(K,1)
            temp = zeros(size(rho,1)^2, size(rho,2)^2, size(K,2));
                for j = 1:size(K,2)
                    temp(:,:,j) = log(kron(conj(K{i, j}), K{i, j}));
                    if sum(sum(isnan(temp(:,:,j)))) > 0
                        temp(:,:,j) = zeros(size(rho)) - Inf;
                    end
                end
            K_lookup(:,:,i) = logsumexp(temp, 3);
        end
            
        % now calculate LL
        rho = log(rho);
        krausProduct = log(eye(size(rho,1)^2));
        for i = 1:size(y,1)
            krausProduct = logdotexp(K_lookup(:,:,y(i)), krausProduct);
        end
        L = real(logsumexp(diag(reshape(logdotexp(krausProduct, reshape(rho, size(rho,1)^2, 1)), size(rho, 1), size(rho,2)))));
    end
end