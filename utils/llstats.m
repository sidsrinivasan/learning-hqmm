function [m,s] = llstats(Y,K,rho,varargin)
%% Returns the mean and std dev of loglikelihood for a dataset Y 
% of dim (num sequences X seq length), Kraus operators K, init density
% matrix rho, varargin: burn_in: for the HQMM

% Calls loglikelihood to do the heavy lifting for each sequence

    lls = zeros(size(Y,1),1);
    for i = 1:size(Y,1)
        if nargin == 4
            lls(i) = loglikelihood(Y(i,:)',K,rho,varargin{1});
        else
            lls(i) = loglikelihood(Y(i,:)',K,rho);
        end
    end
    
    m = mean(lls);
    s = std(lls);
end
