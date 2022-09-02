function [y, lambda] = EmbeddingSimulator(x, rhoM1, rho0, rhoP1, payload, nz_number, randChange)

x = double(x);
n = numel(x);
m = payload * nz_number;

lambda = calc_lambda_ter(rhoM1, rho0, rhoP1, m, n);
[pChangeM1, pChange0, pChangeP1] = GetPchange(lambda, rhoM1, rho0, rhoP1);

y = x;
y(randChange < pChangeP1) = y(randChange < pChangeP1) + 1;
y(randChange >= pChangeP1 & randChange < pChangeP1+pChangeM1) = y(randChange >= pChangeP1 & randChange < pChangeP1+pChangeM1) - 1;

end

