function [Y] = generateObs(K, rho0, num_obs, length_of_obs)

Y = zeros(num_obs, length_of_obs);
output_dim = size(K, 1);

distribution = zeros(output_dim,1);

for j = 1:num_obs
    rho = rho0;
    for i = 1:length_of_obs
        % Create distribution over next observable value
        for o = 1:output_dim
            temp = zeros(size(rho,1), size(rho,2),size(K,2));
            for q = 1:size(K,2)
                temp(:,:,q) = K{o, q} * rho * K{o, q}';
            end
            distribution(o) = trace(sum(temp,3));
        end

        % sample and draw
        Y(j, i) = randsample(output_dim, 1, true, distribution);

        % update state
        temp = zeros(size(rho,1), size(rho,2), size(K,2));
        for q = 1:size(K,2)
            temp(:,:,q) = K{Y(j, i), q} * rho * K{Y(j, i), q}';
        end
        rho = sum(temp, 3);
        rho = rho/trace(rho);

    end
end

end