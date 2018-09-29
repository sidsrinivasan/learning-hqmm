function lcs = logsumexp(X, varargin)
%% Modified version of the function, some hacky fixes for numerical issues
% LOGSUMEXP(X, dim) computes log(sum(exp(X), dim)) robustly. Care lightspeed users!
%
%     lse = logsumexp(X[, dim]);
%
% This routine works with general ND-arrays and matches Matlab's default
% behavior for sum: if dim is omitted it sums over the first non-singleton
% dimension.
%
% Note: Tom Minka's lightspeed has a logsumexp function, which:
%     1) sets dim=1 if dim is missing
%     2) returns Inf for sums containing Infs and NaNs;
%
% This routine is fairly fast and accurate for many uses, including when all the
% values of X are large in magnitude. There is a corner case where the relative
% error is avoidably bad (although the absolute error is small), when the
% largest argument is very close to zero and the next largest is moderately
% negative. For example:
%     logsumexp([0 -40])
% Cases like this rarely come up in my work. My LOGPLUSEXP and LOGCUMSUM
% functions do cover this case.
%
% SEE ALSO: LOGCUMSUMEXP LOGPLUSEXP

% Iain Murray, September 2010

% History: IM wrote a bad logsumexp in ~2002, then used Tom Minka's version for
% years until eventually wanting something slightly different.

if (numel(varargin) > 1)
    error('Too many arguments')
end

if isempty(X)
    % Easiest way to get this trivial but annoying case right!
    lcs = log(sum(exp(X),varargin{:}));
    return;
end

if isempty(varargin)
    mx = max(X);
    if abs(mx) == Inf
        % Get the second largest element and set -Inf to that + 1.2345
        sortX = sort(X);
        if sum(abs(sortX)~=Inf) > 0
            X(abs(X)==Inf) = sortX(sum(abs(sortX)~=Inf)) - 1.2345;
        end
        mx = max(X);
        X(abs(X)==sortX(sum(abs(sortX)~=Inf)) - 1.2345) = -Inf;
    end
else
    % WARNING: this assumes that the OTHER numbers in X are small enough
    % that their sign can be reversed and exponentiated without issue.
    mx = max(X, [], varargin{:});
    if abs(mx) == Inf
        X(abs(X)==Inf) = 0.0000001111;
        mx = max(X, [], varargin{:});
        X(abs(X)==0.0000001111) = -Inf;
    end
end
Xshift = bsxfun(@minus, X, mx);
lcs = bsxfun(@plus, log(sum(exp(Xshift),varargin{:})), mx);

idx = isinf(mx);
lcs(idx) = mx(idx);
lcs(any(isnan(X),varargin{:})) = NaN;