%% EVALUATION SCRIPT - DATA GEN BY HAND-CRAFTED 6,6 HMM

NUM_TR_DATA = 20;
NUM_TE_DATA = 10;
SEQ_LENGTH = 3000;
BURN_IN = 1000;

HIDDEN = 4;
OBS = 6;


%% HQMM Synthetic Data -- 2 states, 4 outputs
A66class = [0.8,0.01,0,0.1,0.3,0; 0.02,0.02,0.1,0.15,0.05,0; 0.08,0.03,0.1,0.4,0.05,0.5; 0.05,0.04,0.5,0.35,0,0.5; 0.03,0.5,0.03,0,0.6,0; 0.02,0.4,0.27,0,0,0];
C66class = [0.2,0,0.05,0.95,0.01,0.05; 0.7,0.1,0.05,0.01,0.05,0.05; 0.05,0.8,0.1,0.02,0.05,0.04; 0.04,0.04,0.02,0,0.84,0.11; 0.01,0.03,0.7,0.01,0.02,0.2; 0,0.03,0.08,0.01,0.03,0.55];
% [~,A66class, C66class] = generateHMMParams(6,6);

load('hmm_data.mat');
% train_data_66class = zeros(NUM_TR_DATA, SEQ_LENGTH);
% test_data_66class = zeros(NUM_TE_DATA, SEQ_LENGTH);
% for i = 1:NUM_TR_DATA
%     [seq, states] = hmmgenerate(SEQ_LENGTH,A66class',C66class');
%     train_data_66class(i,:) = seq;
% end
% for i = 1:NUM_TE_DATA
%     [seq, states] = hmmgenerate(SEQ_LENGTH,A66class',C66class');
%     test_data_66class(i,:) = seq;
% end
% [m,s] = llstatsclass(train_data_66class, A66class, C66class, [1;0;0;0;0;0],BURN_IN);
% [m2,s2] = llstatsclass(test_data_66class, A66class, C66class, [1;0;0;0;0;0],BURN_IN);
% [da_666class_true_tr, dastd_666class_true_tr] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_666class_true_te, dastd_666class_true_te] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('True (Gen Model) Train DA: %f +/- %f, Val DA: %f +/- %f\n\n', da_666class_true_tr, ...
%          dastd_666class_true_tr, da_666class_true_te, dastd_666class_true_te);
% Train DA: 0.1838 +/- 0.0095
% Test DA: 0.1903 +/- 0.0071

%% Train 4,6 HMMs 10 times, take the best
% bestLL = -Inf;
% [~,bestTR_46class, bestEM_46class] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_66class, bestTR_46class, bestEM_46class, [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_66class, bestTR_46class, bestEM_46class, [1;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_66class(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_66class, ESTTR', ESTEM', [1;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_46class = ESTTR;
%         bestEM_46class = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_66class, bestTR_46class', bestEM_46class', [1;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_66class, bestTR_46class', bestEM_46class', [1;0;0;0], BURN_IN);
% [da_46class_hmm_tr, dastd_46class_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_46class_hmm_te, dastd_46class_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_46class_hmm_tr, ...
%              dastd_46class_hmm_tr, da_46class_hmm_te, dastd_46class_hmm_te);

%% Train 6,6 HMMs 10 times, take the best
% HIDDEN = 6;
% OBS = 6;
% bestLL = -Inf;
% [~,bestTR_666class, bestEM_666class] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_66class, bestTR_666class, bestEM_666class, [1;0;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_66class, bestTR_666class, bestEM_666class, [1;0;0;0;0;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_66class(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_66class, ESTTR', ESTEM', [1;0;0;0;0;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_666class = ESTTR;
%         bestEM_666class = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_66class, bestTR_666class', bestEM_666class', [1;0;0;0;0;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_66class, bestTR_666class', bestEM_666class', [1;0;0;0;0;0], BURN_IN);
% [da_666class_hmm_tr, dastd_666class_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_666class_hmm_te, dastd_666class_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_666class_hmm_tr, ...
%              dastd_666class_hmm_tr, da_666class_hmm_te, dastd_666class_hmm_te);
% Train 3,6 DA: 0.1555 +/- 0.0097
% Test 3,6 DA: 0.1625 +/- 0.0073 (bestTR/EM_666class)
% Train 4,6 DA: 0.1667 +/- 0.0099
% Test 4,6 DA: 0.1732 +/- 0.0068 (bestTR/EM_46class)

%% Train 5,6 HMMs 10 times, take the best
% HIDDEN = 5;
% OBS = 6;
% bestLL = -Inf;
% [~,bestTR_26class, bestEM_26class] = generateHMMParams(HIDDEN,OBS);
% [m,s] = llstatsclass(train_data_66class, bestTR_26class, bestEM_26class, [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_66class, bestTR_26class, bestEM_26class, [1;0], BURN_IN);
% [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
% [da_2, dastd2] = getDA(m2, OBS, SEQ_LENGTH - BURN_IN, s2);
% fprintf('Initial (Random) Guess DA Training: %f +/- %f, Val: %f +/- %f\n', da_, dastd, da_2, dastd2);
% 
% for i = 1:10
%     fprintf('Training HMM Round %i\n\n', i);
%     [~,TR,EM] = generateHMMParams(HIDDEN,OBS);
%     [ESTTR, ESTEM] = hmmtrain(train_data_66class(:,BURN_IN+1:end),TR',EM','verbose',true,'maxiterations',10000,'tolerance',7e-6);
%     [m,s] = llstatsclass(test_data_66class, ESTTR', ESTEM', [1;0], BURN_IN);
%     [da_, dastd] = getDA(m, OBS, SEQ_LENGTH - BURN_IN, s);
%     fprintf('\nMean Val LL: %f +/- %f, DA: %f +/- %f\n\n', m, s, da_, dastd);
%     if m > bestLL
%         bestLL = m;
%         bestTR_26class = ESTTR;
%         bestEM_26class = ESTEM;
%     end
% end
% 
% [m,s] = llstatsclass(train_data_66class, bestTR_26class', bestEM_26class', [1;0], BURN_IN);
% [m2,s2] = llstatsclass(test_data_66class, bestTR_26class', bestEM_26class', [1;0], BURN_IN);
% [da_26class_hmm_tr, dastd_26class_hmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_26class_hmm_te, dastd_26class_hmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_26class_hmm_tr, ...
%              dastd_26class_hmm_tr, da_26class_hmm_te, dastd_26class_hmm_te);
% Train 5,6 DA: 0.1751 +/- 0.0097
% Test 5,6 DA: 0.1816 +/- 0.0070
% Train 2,6 DA: 0.128184 +/- 0.007381
% Test 2,6 DA: 0.131381 +/- 0.006171 (bestTR/EM_26class)


%% Train 6,6,1 HQMMs
HIDDEN = 6;
OBS = 6;
% Kguess = reshape(genArbKraus(2,3),6,1);
Kguess = generateHQMM(HIDDEN,OBS,1);
rho_guess= zeros(HIDDEN,HIDDEN);
rho_guess(1,1)=1;
[K_666class5, r_666class5] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, Kguess, rho_guess, 1000, 1, 6, 20);
% [K_666class2, r_666class2, hist_666_class2] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_666class, r_666class, 1000, 4, 6, 15);
% [K_666class3, r_666class3, hist_666_class3] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_666class2, r_666class2, 1000, 6, 5, 20);
% [K_666class4, r_666class4, hist_666_class4] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_666class3, r_666class3, 1000, 8, 4, 25);
% [K_666class5, r_666class5, hist_666_class5] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_666class4, r_666class4, 1000, 10, 3, 35);
[m,s] = llstats(train_data_66class, K_666class5, r_666class5, BURN_IN);
[m2,s2] = llstats(test_data_66class, K_666class5, r_666class5, BURN_IN);

[da_666class_hqmm_tr, dastd_666class_hqmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
[da_666class_hqmm_te, dastd_666class_hqmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
fprintf('\nBest Learned HQMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
fprintf('Best Learned HQMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_666class_hqmm_tr, ...
             dastd_666class_hqmm_tr, da_666class_hqmm_te, dastd_666class_hqmm_te);


%% Train 6,6,2 HQMMs
% Kguess = generateHQMM(HIDDEN,OBS,2);
% rho_guess= zeros(HIDDEN,HIDDEN);
% rho_guess(1,1)=1;
% [K_6662class, r_6662class, hist_6662class] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, Kguess, rho_guess, 1000, 1, 6, 35);
% [K_6662class2, r_6662class2, hist_6662_class2] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6662class, r_6662class, 1000, 3, 6, 30);
% [K_6662class3, r_6662class3, hist_6662_class3] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6662class2, r_6662class2, 1000, 6, 5, 25);
% [K_6662class4, r_6662class4, hist_6662_class4] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6662class3, r_6662class3, 1000, 8, 4, 30);
% [K_6662class5, r_6662class5, hist_6662_class5] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6662class4, r_6662class4, 1000, 10, 3, 35);
% % [K_6662class6, r_6662class6, hist_6662_class6] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6662class5, r_6662class5, 1000, 10, 3, 35);
% 
% [m,s] = llstats(train_data_66class, K_6662class5, r_6662class5, BURN_IN);
% [m2,s2] = llstats(test_data_66class, K_6662class5, r_6662class5, BURN_IN);
% 
% [da_6662class_hqmm_tr, dastd_6662class_hqmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_6662class_hqmm_te, dastd_6662class_hqmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HQMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HQMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_6662class_hqmm_tr, ...
%              dastd_6662class_hqmm_tr, da_6662class_hqmm_te, dastd_6662class_hqmm_te);

%% Train 5,6,1 HQMMs
% Kguess = generateHQMM(HIDDEN,OBS,5)
% Kguesss = genArbKraus(5,6);
% rho_guess= zeros(HIDDEN,HIDDEN);
% rho_guess(1,1)=1;
% [K_6665class, r_6665class, hist_6665class] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, Kguess, rho_guess, 1000, 1, 6, 35);
% [K_6665class2, r_6665class2, hist_6665_class2] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6665class, r_6665class, 1000, 4, 6, 30);
% [K_6665class3, r_6665class3, hist_6665_class3] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6665class2, r_6665class2, 1000, 6, 5, 30);
% [K_6665class4, r_6665class4, hist_6665_class4] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6665class3, r_6665class3, 1000, 8, 4, 35);
% [K_6665class5, r_6665class5, hist_6665_class5] = learnHQMM(HIDDEN, OBS, train_data_66class, test_data_66class, K_6665class4, r_6665class4, 1000, 10, 3, 35);
% [m,s] = llstats(train_data_66class, K_6665class5, r_6665class5, BURN_IN);
% [m2,s2] = llstats(test_data_66class, K_6665class5, r_6665class5, BURN_IN);
% 
% [da_6665class_hqmm_tr, dastd_6665class_hqmm_tr] = getDA(m, OBS, SEQ_LENGTH-BURN_IN, s);
% [da_6665class_hqmm_te, dastd_6665class_hqmm_te] = getDA(m2, OBS, SEQ_LENGTH-BURN_IN, s2);
% fprintf('\nBest Learned HQMM Train LL: %f +/- %f, Val LL: %f +/- %f\n', m, s, m2, s2);
% fprintf('Best Learned HQMM Train DA: %f +/- %f, Val DA: %f +/- %f\n', da_6665class_hqmm_tr, ...
%              dastd_6665class_hqmm_tr, da_6665class_hqmm_te, dastd_6665class_hqmm_te);
 
