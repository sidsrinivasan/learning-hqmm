function [d, std_d] = getDA(LL, output_dim, seq_length, varargin)
%% Function to compute the description accuracy, given
%   - log likelihood of the data
%   - dimension of output space
%   - length of sequence
%   - varargin: std in LL
 d = 1 + LL/(log(output_dim) * seq_length);
 
 up = 1 + (LL + varargin{1})/(log(output_dim) * seq_length);
 down = 1 + (LL - varargin{1})/(log(output_dim) * seq_length);
 
 std_d = abs((up - down)/2);
end