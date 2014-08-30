jCUDA
=====

experiments with providing L3 BLAS and CUDA for J for array math speedup

First step completed: dgemm

Org emacs list of nice things to put in here to make it useful;

** TODO jCUDA [20%]
  - [-] Try dgemm BLAS port [66%]
    - [X] Does it work?
    - [X] simple test script
    - [ ] Make it work with vectors
  - [X] Build wrapper for sgemm [100%]
    - [X] Wrapper done
    - [X] Make it work with raw float arrays
  - [ ] Port sgemm wrapper to CUDA [0%]
    - [ ] Push double to float on GPU
    - [ ] Pull float to double on GPU
    - [ ] Pull intermediate float from GPU for multiple MM's
    - [ ] sgemm
  - [ ] Other CUDA functions [0%]
    - [ ] "log", "log1p", "exp","cos",  "sin",  "sqrt","ceil", "floor","abs"
    - [ ] "acos", "cosh","tan", "atan", "asin", "sinh","tanh",
    - [ ] random number generators
  - [ ] stuff looted from R package gputools [0%]
    - [ ] distance
    - [ ] qrdecomp
    - [ ] mi
    - [ ] hcluster
    - [ ] kendall
    - [ ] sort
    - [ ] lsfit (same as qrdecomp?)