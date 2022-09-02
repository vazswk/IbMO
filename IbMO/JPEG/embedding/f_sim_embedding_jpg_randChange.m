function [stego, pChangeP1, pChangeM1] = f_sim_embedding_jpg_randChange(cover, costmat_M, costmat_P, payload, nz_number, randChange)

%% Get embedding costs
% inicialization
cover = double(cover);
wetCost = 10^10;
% compute embedding costs \rho

rhoM1 = costmat_M;
rhoP1 = costmat_P;

rhoP1(rhoP1 > wetCost) = wetCost; % threshold on the costs
rhoP1(isnan(rhoP1)) = wetCost; % if all xi{} are zero threshold the cost 
rhoP1(cover > 1023) = wetCost;

rhoM1(rhoM1 > wetCost) = wetCost; % threshold on the costs
rhoM1(isnan(rhoM1)) = wetCost; % if all xi{} are zero threshold the cost 
rhoM1(cover < -1023) = wetCost;

[stego, pChangeP1, pChangeM1] = f_EmbeddingSimulator_seed_randChange(cover, rhoP1, rhoM1, floor(payload*nz_number), randChange); 

          
