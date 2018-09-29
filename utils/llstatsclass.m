function [m,s] = llstatsclass(Y,A,C,x,varargin)
%% Returns the mean and std dev of loglikelihood for a dataset Y 
% of dim (num sequences X seq length), transition matrix A, emission matrix C,
% initial state x, varargin: burn_in: for the HMM

% Calls loglikelihoodclass to do the heavy lifting for each sequence

    lls = zeros(size(Y,1),1);
    
    for i = 1:size(Y,1)
        if nargin == 4
            lls(i) = loglikelihoodclass(Y(i,:)',A,C,x);
        else
            lls(i) = loglikelihoodclass(Y(i,:)',A,C,x,varargin{1});
        end
    end
    
    m = mean(lls);
    s = std(lls);
end
