function C = logdotexp(logA, logB)
%% Function to perform log A * log B to prevent underflow issues
    maxA = max(max(logA));
    maxB = max(max(logB));
    if abs(maxA) == Inf
        sortA = sort(logA(:));
        if sum(abs(sortA)~=Inf) == 0
            C = zeros(size(logA,1),size(logB,2)) - Inf;
            return
        else
            maxA = sortA(sum(abs(sortA)~=Inf));
        end
    end
    if abs(maxB) == Inf
        sortB = sort(logB(:));
        if sum(abs(sortB)~=Inf) == 0
            C = zeros(size(logA,1),size(logB,2)) - Inf;
            return
        else
            maxB = sortB(sum(abs(sortB)~=Inf));
        end
    end
    
    expA = exp(logA - maxA);
    expB = exp(logB - maxB);

    C = log(expA * expB) + maxA + maxB;
end