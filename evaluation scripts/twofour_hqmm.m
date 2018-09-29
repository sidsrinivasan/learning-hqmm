%% EVALUATION SCRIPT - DATA GEN BY 2,4 HQMM

NUM_TR_DATA = 20;
NUM_TE_DATA = 10;
SEQ_LENGTH = 3000;
BURN_IN = 1000;

HIDDEN = 2;
OBS = 4;

%% HQMM Synthetic Data -- 2 states, 4 outputs
K_true_24quant = cell(4,1);
K_true_24quant{1} = [1/sqrt(2), 0; 0,0];
K_true_24quant{2} = [0, 0; 0,1/sqrt(2)];
K_true_24quant{3} = [1/(2*sqrt(2)), 1/(2*sqrt(2)); 1/(2*sqrt(2)),1/(2*sqrt(2))];
K_true_24quant{4} = [1/(2*sqrt(2)), -1/(2*sqrt(2)); -1/(2*sqrt(2)),1/(2*sqrt(2))];
rho_true_24quant = [1,0;0,0];

load('twofour_hqmm.mat');
% train_data_24quant = generateObs(K_true_24quant, rho_true_24quant, NUM_TR_DATA, SEQ_LENGTH);
% test_data_24quant = generateObs(K_true_24quant, rho_true_24quant, NUM_TE_DATA, SEQ_LENGTH);
% [m,s] = llstats(train_data_24quant, K_true_24quant, rho_true_24quant, BURN_IN);
% [m2,s2] = llstats(test_data_24quant, K_true_24quant, rho_true_24quant, BURN_IN);
% [da_24quant_true_tr, dastd_24quant_true_tr] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_24quant_true_te, dastd_24quant_true_te] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('True (Gen Model) Train DA: %f +/- %f, Val DA: %f +/- %f\n\n', da_24quant_true_tr, ...
%          dastd_24quant_true_tr, da_24quant_true_te, dastd_24quant_true_te);
% Train DA: 0.250451 +/- 0.003690
% Test DA: 0.251643 +/- 0.006252

%% Train 2,4 HMMs 10 times, take the best
% bestLL = -Inf;
% [~,bestTR_24quant, bestEM_24quant] = generateHMMParams(2,4);
% [m,s] = llstatsclass(train_data_24quant, bestTR_24quant, bestEM_24quant, [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_24quant, bestTR_24quant, bestEM_24quant, [1;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_24quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_24quant, ESTTR', ESTEM', [1;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_24quant = ESTTR;
%         bestEM_24quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_24quant, bestTR_24quant', bestEM_24quant', [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_24quant, bestTR_24quant', bestEM_24quant', [1;0], BURN_IN);
% [da_24quant_hmm_tr, dastd_24quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_24quant_hmm_te, dastd_24quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_24quant_hmm_tr, ...
%              dastd_24quant_hmm_tr, da_24quant_hmm_te, dastd_24quant_hmm_te);
% % Train DA: 0.095277 +/- 0.008204 (tried > 15 times!)
% % Test DA: 0.094819 +/- 0.010472
% 

%% Train 3,4 HMMs 10 times, take the best
% HIDDEN = 3;
% OBS = 4;
% bestLL = -Inf;
% [~,bestTR_34quant, bestEM_34quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_24quant, bestTR_34quant, bestEM_34quant, [1;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_24quant, bestTR_34quant, bestEM_34quant, [1;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_24quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_24quant, ESTTR', ESTEM', [1;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_34quant = ESTTR;
%         bestEM_34quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_24quant, bestTR_34quant', bestEM_34quant', [1;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_24quant, bestTR_34quant', bestEM_34quant', [1;0;0], BURN_IN);
% [da_34quant_hmm_tr, dastd_34quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_34quant_hmm_te, dastd_34quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_34quant_hmm_tr, ...
%              dastd_34quant_hmm_tr, da_34quant_hmm_te, dastd_34quant_hmm_te);
% 

%% Train 4,4 HMMs 10 times, take the best
% HIDDEN = 4;
% OBS = 4;
% bestLL = -Inf;
% [~,bestTR_44quant, bestEM_44quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_24quant, bestTR_44quant, bestEM_44quant, [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_24quant, bestTR_44quant, bestEM_44quant, [1;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_24quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_24quant, ESTTR', ESTEM', [1;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_44quant = ESTTR;
%         bestEM_44quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_24quant, bestTR_44quant', bestEM_44quant', [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_24quant, bestTR_44quant', bestEM_44quant', [1;0;0;0], BURN_IN);
% [da_44quant_hmm_tr, dastd_44quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_44quant_hmm_te, dastd_44quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_44quant_hmm_tr, ...
%              dastd_44quant_hmm_tr, da_44quant_hmm_te, dastd_44quant_hmm_te);
% 
 
%% Train HQMM from scratch
HIDDEN = 2;
OBS = 4;
Kguess = generateHQMM(HIDDEN,OBS,1);
rho_guess= zeros(HIDDEN,HIDDEN);
rho_guess(1,1)=1;
[K_24quant, r_24quant, hist_24quant] = learnHQMM(HIDDEN, OBS, train_data_24quant, test_data_24quant, Kguess, rho_guess, 1000, 1, 6, 15);
[K_24quant2, r_24quant2, hist_24quant2] = learnHQMM(HIDDEN, OBS, train_data_24quant, test_data_24quant, K_24quant, r_24quant, 1000, 4, 3, 5);
[m,s] = llstats(train_data_24quant, K_24quant2, r_24quant2, BURN_IN);
[m2,s2] = llstats(test_data_24quant, K_24quant2, r_24quant2, BURN_IN);
[da_24quant_hqmm_tr, dastd_24quant_hqmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
[da_24quant_hqmm_te, dastd_24quant_hqmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
fprintf('\nBest Learned HQMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
fprintf('Best Learned HQMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_24quant_hqmm_tr, ...
             dastd_24quant_hqmm_tr, da_24quant_hqmm_te, dastd_24quant_hqmm_te);
% % Train DA: 0.250067 +/- 0.005698
% % Test DA: 0.250254 +/- 0.004752


% Kguess = genArbKraus(HIDDEN, OBS);
% rho_guess = [1,0; 0,0];
% [K_242quant, r_242quant, hist_242quant] = learnHQMM(HIDDEN, OBS, train_data_24quant, test_data_24quant, Kguess, rho_guess,1000,2,5,15);
% [K_242quant2, r_242quant2, hist_242quant] = learnHQMM(HIDDEN, OBS, train_data_24quant, test_data_24quant, K_242quant2, r_242quant2,1000,5,5,14);
% [m,s] = llstats(train_data_24quant, K_242quant2, r_242quant2, BURN_IN);
% [m2,s2] = llstats(test_data_24quant, K_242quant2, r_242quant2, BURN_IN);
% [da_242quant_hqmm_tr, dastd_242quant_hqmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_242quant_hqmm_te, dastd_242quant_hqmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HQMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HQMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_242quant_hqmm_tr, ...
%              dastd_242quant_hqmm_tr, da_242quant_hqmm_te, dastd_242quant_hqmm_te);
% % Train DA: 0.2499 +/- 0.0035
% % Test DA: 0.2508 +/- 0.0060
