%% EVALUATION SCRIPT - JAEGER NOOM PROB CLOCK

NUM_TR_DATA = 20;
NUM_TE_DATA = 10;
SEQ_LENGTH = 3000;
BURN_IN = 1000;

HIDDEN = 2;
OBS = 2;

%% HQMM Synthetic Data -- 2 states, 2 outputs
K_true_22quant = cell(2,1);
K_true_22quant{1} = [0.6*cos(0.6), -sin(0.6); 0.6*sin(0.6), cos(0.6)];
K_true_22quant{2} = [0.8,0;0,0];
rho_true_22quant = [1,0;0,0];

load('prob_clock.mat');
% train_data_22quant = generateObs(K_true_22quant, rho_true_22quant, NUM_TR_DATA, SEQ_LENGTH);
% test_data_22quant = generateObs(K_true_22quant, rho_true_22quant, NUM_TE_DATA, SEQ_LENGTH);
% [m,s] = llstats(train_data_22quant, K_true_22quant, rho_true_22quant, BURN_IN);
% [m2,s2] = llstats(test_data_22quant, K_true_22quant, rho_true_22quant, BURN_IN);
% [da_22quant_true_tr, dastd_22quant_true_tr] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_22quant_true_te, dastd_22quant_true_te] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('True (Gen Model) Train DA: %f +/- %f, Val DA: %f +/- %f\n\n', da_22quant_true_tr, ...
%          dastd_22quant_true_tr, da_22quant_true_te, dastd_22quant_true_te);
% Train DA: 0.164229 +/- 0.008922 (da_22quant_true_tr +/- dastd_22quant_true_tr)
% Test DA: 0.163173 +/- 0.011105 (da_22quant_true_te +/- dastd_22quant_true_te)

%% Train 2,2-HMMs 3 times, take the best
% bestLL = -Inf;
% [~,bestTR_22quant, bestEM_22quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_22quant, bestTR_22quant, bestEM_22quant, [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_22quant, bestTR_22quant, bestEM_22quant, [1;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_22quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000, 'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_22quant, ESTTR', ESTEM', [1;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_22quant = ESTTR;
%         bestEM_22quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_22quant, bestTR_22quant', bestEM_22quant', [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_22quant, bestTR_22quant', bestEM_22quant', [1;0], BURN_IN);
% [da_22quant_hmm_tr, dastd_22quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_22quant_hmm_te, dastd_22quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_22quant_hmm_tr, ...
%              dastd_22quant_hmm_tr, da_22quant_hmm_te, dastd_22quant_hmm_te);
% Train DA: 0.0851 +/- 0.0074
% Test DA: 0.0833 +/- 0.0131

%% Train 4,2-HMMs 3 times, take the best
% HIDDEN = 4;
% OBS = 2;
% bestLL = -Inf;
% [~,bestTR_42quant, bestEM_42quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_22quant, bestTR_42quant, bestEM_42quant, [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_22quant, bestTR_42quant, bestEM_42quant, [1;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_22quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_22quant, ESTTR', ESTEM', [1;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_42quant = ESTTR;
%         bestEM_42quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_22quant, bestTR_42quant', bestEM_42quant', [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_22quant, bestTR_42quant', bestEM_42quant', [1;0;0;0], BURN_IN);
% [da_42quant_hmm_tr, dastd_42quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_42quant_hmm_te, dastd_42quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_42quant_hmm_tr, ...
%              dastd_42quant_hmm_tr, da_42quant_hmm_te, dastd_42quant_hmm_te);
% % Train DA: 0.1459 +/- 0.0068
% % Test DA: 0.1446 +/- 0.0100


%% Train 8,2-HMMs 3 times, take the best
% HIDDEN = 7;
% OBS = 2;
% bestLL = -Inf;
% [~,bestTR_82quant, bestEM_82quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_22quant, bestTR_82quant, bestEM_82quant, [1;0;0;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_22quant, bestTR_82quant, bestEM_82quant, [1;0;0;0;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:1
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_22quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',1e-5);
%     [m,s] = llstatsclass(test_data_22quant, ESTTR', ESTEM', [1;0;0;0;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_82quant = ESTTR;
%         bestEM_82quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_22quant, bestTR_82quant', bestEM_82quant', [1;0;0;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_22quant, bestTR_82quant', bestEM_82quant', [1;0;0;0;0;0;0], BURN_IN);
% [da_82quant_hmm_tr, dastd_82quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_82quant_hmm_te, dastd_82quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_82quant_hmm_tr, ...
%              dastd_82quant_hmm_tr, da_82quant_hmm_te, dastd_82quant_hmm_te);
% Train DA: 0.1639 +/- 0.0087 
% Test DA: 0.1630 +/- 0.0108

%% Train 2,2,1 HQMM from scratch
HIDDEN = 2;
OBS = 2;
Kguess = generateHQMM(HIDDEN,OBS,1);
rho_guess= zeros(HIDDEN,HIDDEN);
rho_guess(1,1)=1;
[K_22quant, r_22quant, hist_22quant] = learnHQMM(HIDDEN, OBS, train_data_22quant, test_data_22quant, Kguess, rho_guess, 1000, 1, 3, 15);
[K_22quant2, r_22quant2, hist_22quant2] = learnHQMM(HIDDEN, OBS, train_data_22quant, test_data_22quant, K_22quant, r_22quant, 1000, 4, 4, 5);
[m,s] = llstats(train_data_22quant, K_22quant2, r_22quant2, BURN_IN);
[m2,s2] = llstats(test_data_22quant, K_22quant2, r_22quant2, BURN_IN);
[da_22quant_hqmm_tr, dastd_22quant_hqmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
[da_22quant_hqmm_te, dastd_22quant_hqmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
fprintf('\nBest Learned HQMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
fprintf('Best Learned HQMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_22quant_hqmm_tr, ...
             dastd_22quant_hqmm_tr, da_22quant_hqmm_te, dastd_22quant_hqmm_te);
% Train DA: 0.1640 +/- 0.0088
% Test DA: 0.1631 +/- 0.0111
