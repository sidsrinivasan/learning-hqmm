function [bestK, bestRho, hist] = learnHQMM(state_dim, output_dim, Y_train, varargin)
%% Main function that implements learning algorithm for HQMMs
% varargin: Y_val, K_learned, rho_learned, burn_in, batch_size, iter, num_batches


    %% THIS IS HARD CODED, CHANGE IF NECESSARY!!!
    % This is a hacky way to pass in burn_in, batch_size, iter, and
    % num_batches without having to pass in VAL, K_guess, and rho_guess.
    % If SPOOF is a LARGE NUMBER, you can pass in anything in that position
    % and it will be ignored.
    VAL_SPOOF = 4; %10000; %4
    K_SPOOF = 5;%10000; %5
    R_SPOOF = 6;%10000; %6
    
    BURN_IN = 1000;
    BATCH_SIZE = 1;
    ITER = 6;
    NUM_BATCHES = 15;
    
    %% Assign varargins
    if nargin >= K_SPOOF
        K_learned = varargin{2};
        bestK = varargin{2};
    else
        [randomK, ~] = generateHQMM(state_dim, output_dim);
        K_learned = randomK;
        bestK = randomK;
    end
    
    if nargin >= R_SPOOF
        rho_learned = varargin{3};
        bestRho = varargin{3};
    else
        [~, randomRho] = generateHQMM(state_dim, output_dim);
        rho_learned = randomRho;
        bestRho = randomRho;
    end
    
    if nargin >= 7
        burn_in = varargin{4};
    else
        burn_in = BURN_IN;
    end
    
    if nargin >= 8
        batch_size = varargin{5};
    else
        batch_size = BATCH_SIZE;
    end
    
    if nargin >= 9
        iter = varargin{6};
    else
        iter = ITER;
    end
    
    if nargin >= 10
        num_batches = varargin{7};
    else
        num_batches = NUM_BATCHES;
    end
    
    %% Initialize learned operators
    
    bestVal = -Inf;
    num_observables = size(K_learned, 1);
    operators_per_observable = size(K_learned,2);

    % params
    gammalbnd = [-pi; -pi; -pi; -pi];
    gammaubnd = [pi; pi; pi; pi];
    randomInits = 0;
    % Track training likelihood and val likelihood
    hist = zeros(4, num_batches+1);
    options = optimset('Display', 'off');
    
    hist(1, 1) = llstats(Y_train, K_learned, rho_learned, burn_in);
    hist(3, 1) = 1 + hist(1,1)/(log(num_observables) * (size(Y_train,2)-burn_in));
    fprintf('Initial training likelihood: %f, DA: %f\n', hist(1,1), hist(3,1));
    if nargin >= VAL_SPOOF % i.e., when VAL data is provided
        hist(2, 1) = llstats(varargin{1}, K_learned, rho_learned, burn_in);
        hist(4, 1) = 1 + hist(2,1)/(log(num_observables) * (size(varargin{1},2)-burn_in));
        fprintf('Initial validation likelihood: %f, DA: %f\n\n', hist(2,1), hist(4,1));
    end
    
    
    for d = 1:num_batches
        fprintf('Processing batch %i of %i\n', d, num_batches);
        samples = randsample(size(Y_train,1),batch_size,false);
        
        for it = 1:iter
            fprintf('Iteration %i of %i\n', it, iter);

            %% Update Kraus Operators
            fprintf('\tUpdating Kraus Operators...\n');
            % randomly select rows to change
            ops = randsample(1:num_observables*state_dim*operators_per_observable,2,false);
            op1 = ceil(min(ops)/(state_dim*operators_per_observable));
            mat1 = ceil((min(ops)-(op1-1)*state_dim*operators_per_observable)/state_dim);
            row1 = min(ops) - (((op1-1)*state_dim*operators_per_observable) + (mat1-1)*state_dim);
            op2 = ceil(max(ops)/(state_dim*operators_per_observable));
            mat2 = ceil((max(ops)-(op2-1)*state_dim*operators_per_observable)/state_dim);
            row2 = max(ops) - (((op2-1)*state_dim*operators_per_observable) + (mat2-1)*state_dim);
            fprintf('\tSwapping Observable %i, Matrix %i, Row %i with Observable %i, Matrix %i, Row %i\n', op1, mat1, row1, op2, mat2, row2);

            % Try multiple initial conditions
            gamma = [0; 0; 0; 0]; % [phi; psi; delta; theta]
            bestLL = findParams(gamma);
            bestgamma = gamma;
            fprintf('\tInitial Log Likelihood: %f\n\n', -bestLL);

            gamma = fmincon(@findParams,gamma,[],[],[],[],gammalbnd, gammaubnd, [], options);
            if findParams(gamma) < bestLL
                    bestLL = findParams(gamma);
                    bestgamma = gamma;
                    fprintf('\tBetter Log Likelihood found near zero init %i: %f\n', 1, -bestLL);
            end

            for r = 1:randomInits
                gamma = (2*pi).*rand(4,1) - pi;
                gamma = fmincon(@findParams,gamma,[],[],[],[],gammalbnd, gammaubnd, [], options);
                if findParams(gamma) < bestLL
                    bestLL = findParams(gamma);
                    bestgamma = gamma;
                    fprintf('\tBetter Log Likelihood found on random init %i: %f\n', r, -bestLL);
                end
            end
            K_learned = update(bestgamma);
            fprintf('\tNew Log Likelihood: %f\n\n', -bestLL);
          
        end
        
        % Add results to history to track learning progress
        hist(1, 1+(d)) = llstats(Y_train, K_learned, rho_learned, burn_in);
        hist(3, 1+(d)) = 1 + hist(1,1+d)/(log(output_dim) * (size(Y_train,2)-burn_in));
        fprintf('Training likelihood: %f, DA: %f\n', hist(1, 1+(d)), hist(3, 1+(d)));
        if nargin >= VAL_SPOOF
            hist(2, 1+(d)) = llstats(varargin{1}, K_learned, rho_learned, burn_in);
            hist(4, 1+(d)) = 1 + hist(2,1+d)/(log(output_dim) * (size(varargin{1},2)-burn_in));
            fprintf('Validation likelihood: %f, DA: %f\n\n', hist(2, 1+(d)), hist(4, 1+(d)));
            if hist(2, 1+(d)) > bestVal
                bestVal = hist(2, 1+(d));
                bestK = K_learned;
                bestRho = rho_learned;
            end
        else
            bestK = K_learned;
            bestRho = rho_learned;
        end
    
    end
    
           
    function L = findParams(gamma)
        newK = update(gamma);
        [L,~] = llstats(Y_train(samples,:), newK, rho_learned, burn_in);
        L=-L;
    end

    function newK = update(gamma)
        newK = K_learned;
        newK{op1, mat1}(row1, :) = (exp(1i*gamma(1)/2)*exp(1i*gamma(2))*cos(gamma(4)))*K_learned{op1, mat1}(row1, :) + ...
                (exp(1i*gamma(1)/2)*exp(1i*gamma(3))*sin(gamma(4)))*K_learned{op2, mat2}(row2, :);

        newK{op2, mat2}(row2, :) = (-exp(1i*gamma(1)/2)*exp(-1i*gamma(3))*sin(gamma(4)))*K_learned{op1, mat1}(row1, :) + ...
                (exp(1i*gamma(1)/2)*exp(-1i*gamma(2))*cos(gamma(4)))*K_learned{op2, mat2}(row2, :);
    end    
   
end

