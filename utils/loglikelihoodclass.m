function L = loglikelihoodclass(y,Atemp,Ctemp,xtemp,varargin)
%% Function to compute the log likelihood of a sequence for given HMM parameters
% varargin: burn_in 
% (should give the same result as MATLAB's hmmdecode()

% y should be a column vector
    state_dim = size(Atemp,1);
    output_dim = size(Ctemp, 1);
    T = cell(output_dim, 1);
    for i = 1:output_dim
            T{i} = diag(Ctemp(i,:)) * Atemp;
    end

    if nargin == 5
        burn_in = varargin{1};
        for i = 1:burn_in
            xtemp = T{y(i)} * xtemp;
            xtemp = xtemp/sum(xtemp);
        end
        
        krausProduct = log(T{y(burn_in+1)});

        for i = burn_in+2:size(y,1)
            krausProduct = logdotexp(log(T{y(i)}), krausProduct);
        end
        L = logsumexp(logdotexp(krausProduct, log(xtemp)));
        
    else
        krausProduct = log(T{y(1)});

        for i = 2:size(y,1)
            krausProduct = logdotexp(log(T{y(i)}), krausProduct);
        end
        L = logsumexp(logdotexp(krausProduct, log(xtemp)));
    end

end