%% EVALUATION SCRIPT - DATA GEN BY 2,6 Fully Quantum HQMM

NUM_TR_DATA = 20;
NUM_TE_DATA = 10;
SEQ_LENGTH = 3000;
BURN_IN = 1000;

HIDDEN = 2;
OBS = 6;

%% HQMM Synthetic Data -- 2 states, 6 outputs
K_true_26quant = cell(6,1);
K_true_26quant{1} = [1/sqrt(3), 0; 0,0];
K_true_26quant{2} = [0, 0; 0,1/sqrt(3)];
K_true_26quant{3} = [1/(2*sqrt(3)), 1/(2*sqrt(3)); 1/(2*sqrt(3)),1/(2*sqrt(3))];
K_true_26quant{4} = [1/(2*sqrt(3)), -1/(2*sqrt(3)); -1/(2*sqrt(3)),1/(2*sqrt(3))];
K_true_26quant{5} = [1/(2*sqrt(3)), -1i/(2*sqrt(3)); 1i/(2*sqrt(3)),1/(2*sqrt(3))];
K_true_26quant{6} = [1/(2*sqrt(3)), 1i/(2*sqrt(3)); -1i/(2*sqrt(3)),1/(2*sqrt(3))];
rho_true_26quant = [1,0;0,0];

load('fully_quantum_hqmm.mat');
% train_data_26quant = generateObs(K_true_26quant, rho_true_26quant, NUM_TR_DATA, SEQ_LENGTH);
% test_data_26quant = generateObs(K_true_26quant, rho_true_26quant, NUM_TE_DATA, SEQ_LENGTH);
% [m,s] = llstats(train_data_26quant, K_true_26quant, rho_true_26quant, BURN_IN);
% [m2,s2] = llstats(test_data_26quant, K_true_26quant, rho_true_26quant, BURN_IN);
% [da_26quant_true_tr, dastd_26quant_true_tr] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_26quant_true_te, dastd_26quant_true_te] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('True (Gen Model) Train DA: %f +/- %f, Val DA: %f +/- %f\n\n', da_26quant_true_tr, ...
%          dastd_26quant_true_tr, da_26quant_true_te, dastd_26quant_true_te);
% Train DA: 
% Test DA: 

%% Train 2,6 HMMs 10 times, take the best
% bestLL = -Inf;
% [~,bestTR_26quant, bestEM_26quant] = generateHMMParams(2,6);
% [m,s] = llstatsclass(train_data_26quant, bestTR_26quant, bestEM_26quant, [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_26quant, bestEM_26quant, [1;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_26quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_26quant, ESTTR', ESTEM', [1;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_26quant = ESTTR;
%         bestEM_26quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_26quant, bestTR_26quant', bestEM_26quant', [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_26quant', bestEM_26quant', [1;0], BURN_IN);
% [da_26quant_hmm_tr, dastd_26quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_26quant_hmm_te, dastd_26quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_26quant_hmm_tr, ...
%              dastd_26quant_hmm_tr, da_26quant_hmm_te, dastd_26quant_hmm_te);
% % Train DA: 
% % Test DA: 
% 

%% Train 3,6 HMMs 10 times, take the best
% HIDDEN = 3;
% OBS = 6;
% bestLL = -Inf;
% [~,bestTR_36quant, bestEM_36quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_26quant, bestTR_36quant, bestEM_36quant, [1;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_36quant, bestEM_36quant, [1;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_26quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_26quant, ESTTR', ESTEM', [1;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_36quant = ESTTR;
%         bestEM_36quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_26quant, bestTR_36quant', bestEM_36quant', [1;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_36quant', bestEM_36quant', [1;0;0], BURN_IN);
% [da_36quant_hmm_tr, dastd_36quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_36quant_hmm_te, dastd_36quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_36quant_hmm_tr, ...
%              dastd_36quant_hmm_tr, da_36quant_hmm_te, dastd_36quant_hmm_te);
% 

%% Train 4,6 HMMs 10 times, take the best
% HIDDEN = 4;
% OBS = 6;
% bestLL = -Inf;
% [~,bestTR_46quant, bestEM_46quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_26quant, bestTR_46quant, bestEM_46quant, [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_46quant, bestEM_46quant, [1;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_26quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_26quant, ESTTR', ESTEM', [1;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_46quant = ESTTR;
%         bestEM_46quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_26quant, bestTR_46quant', bestEM_46quant', [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_46quant', bestEM_46quant', [1;0;0;0], BURN_IN);
% [da_46quant_hmm_tr, dastd_46quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_46quant_hmm_te, dastd_46quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_46quant_hmm_tr, ...
%              dastd_46quant_hmm_tr, da_46quant_hmm_te, dastd_46quant_hmm_te);
% 

%% Train 5,6 HMMs 10 times, take the best
% HIDDEN = 5;
% OBS = 6;
% bestLL = -Inf;
% [~,bestTR_56quant, bestEM_56quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_26quant, bestTR_56quant, bestEM_56quant, [1;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_56quant, bestEM_56quant, [1;0;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_26quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_26quant, ESTTR', ESTEM', [1;0;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_56quant = ESTTR;
%         bestEM_56quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_26quant, bestTR_56quant', bestEM_56quant', [1;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_56quant', bestEM_56quant', [1;0;0;0;0], BURN_IN);
% [da_56quant_hmm_tr, dastd_56quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_56quant_hmm_te, dastd_56quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_56quant_hmm_tr, ...
%              dastd_56quant_hmm_tr, da_56quant_hmm_te, dastd_56quant_hmm_te);
% 

%% Train 6,6 HMMs 10 times, take the best
% HIDDEN = 6;
% OBS = 6;
% bestLL = -Inf;
% [~,bestTR_66quant, bestEM_66quant] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_26quant, bestTR_66quant, bestEM_66quant, [1;0;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_66quant, bestEM_66quant, [1;0;0;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_26quant(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_26quant, ESTTR', ESTEM', [1;0;0;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_66quant = ESTTR;
%         bestEM_66quant = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_26quant, bestTR_66quant', bestEM_66quant', [1;0;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_26quant, bestTR_66quant', bestEM_66quant', [1;0;0;0;0;0], BURN_IN);
% [da_66quant_hmm_tr, dastd_66quant_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_66quant_hmm_te, dastd_66quant_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_66quant_hmm_tr, ...
%              dastd_66quant_hmm_tr, da_66quant_hmm_te, dastd_66quant_hmm_te);
% 

% % Train HQMM from scratch
HIDDEN = 2;
OBS = 6;
% Kguess = generateHQMM(HIDDEN,OBS,1);
Kguess = reshape(genArbKraus(2,3),6,1);
rho_guess= zeros(HIDDEN,HIDDEN);
rho_guess(1,1)=1;
[K_26quant, r_26quant, hist_26quant] = learnHQMM(HIDDEN, OBS, train_data_26quant, test_data_26quant, Kguess, rho_guess, 1000, 1, 6, 30);
[K_26quant2, r_26quant2, hist_26quant2] = learnHQMM(HIDDEN, OBS, train_data_26quant, test_data_26quant, K_26quant, r_26quant, 1000, 4, 5, 15);
[K_26quant3, r_26quant3, hist_26quant3] = learnHQMM(HIDDEN, OBS, train_data_26quant, test_data_26quant, K_26quant2, r_26quant2, 1000, 10, 3, 10);
[m,s] = llstats(train_data_26quant, K_26quant3, r_26quant3, BURN_IN);
[m2,s2] = llstats(test_data_26quant, K_26quant3, r_26quant3, BURN_IN);
[da_26quant_hqmm_tr, dastd_26quant_hqmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
[da_26quant_hqmm_te, dastd_26quant_hqmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
fprintf('\nBest Learned HQMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
fprintf('Best Learned HQMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_26quant_hqmm_tr, ...
             dastd_26quant_hqmm_tr, da_26quant_hqmm_te, dastd_26quant_hqmm_te);
% % Train DA: 
% % Test DA: 
% 
