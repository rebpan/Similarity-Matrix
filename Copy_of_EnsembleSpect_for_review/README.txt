Two versions are included:

- EnsembleSpect.m
- EnsembleSpect_C.m

The later one uses two functions in C so as to avoid slow LOOP in matlab.
You may comppile them in matlab command prompt by:

>> mex StabilityC.c
>> mex SimilarityC.c

For NcutClustering, go to the directory Ncut in matlab, and run compileDir_simple.m to compile the *.cpp files. 