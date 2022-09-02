function [stego, pChangeP1, pChangeM1] = f_sim_embedding_pgm_randChange(cover, costmat_M, costmat_P, payload, number, randChange)

%% Get embedding costs
% inicialization
cover = double(cover);
wetCost = 10^10;
% compute embedding costs \rho

rhoM1 = costmat_M;
rhoP1 = costmat_P;

rhoP1(rhoP1 > wetCost) = wetCost; % threshold on the costs
rhoP1(isnan(rhoP1)) = wetCost; % if all xi{} are zero threshold the cost 
rhoP1(cover == 255) = wetCost;
rhoP1(cover == 0) = wetCost;

rhoM1(rhoM1 > wetCost) = wetCost; % threshold on the costs
rhoM1(isnan(rhoM1)) = wetCost; % if all xi{} are zero threshold the cost 
rhoM1(cover == 255) = wetCost;
rhoM1(cover == 0) = wetCost;

[stego, pChangeP1, pChangeM1] = f_EmbeddingSimulator_seed_randChange(cover, rhoP1, rhoM1, floor(payload*number), randChange); 

          
