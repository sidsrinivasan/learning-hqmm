# Learning HQMMs
Implementation of Model described in 'Learning Hidden Quantum Models' as described in http://proceedings.mlr.press/v84/srinivasan18a/srinivasan18a.pdf

# Requirements

- MATLAB
- QETLAB (http://www.qetlab.com/Main_Page) 
  Note: Sometimes you get an error if you try to run the code after downloading QETLAB, this is because some files are missing. Locate the 1-2 missing files and download them separately if necessary.
  

# Directory

 - Evaluation Scripts: Contains code to run the experiments shown in the paper
 - data: the MATLAB data files containing the results (some may be missing) from the experiments shown in the paper
 - generate: functions to generate HMM/HQMM parameters
 - utils: helper functions to compute likelihoods, compute products, etc
 - learnHQMM: main function implementing learning algorithm for HQMMs
