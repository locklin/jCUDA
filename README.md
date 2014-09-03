jCUDA
=====

experiments with providing L3 BLAS and CUDA for J for array math speedup

Step completed: dgemm, sgemm

Org emacs list of nice things to put in here to make it useful;

** TODO jCUDA [40%]
  - [X] Try dgemm BLAS port [100%]
    - [X] Does it work?
    - [X] simple test script
    - [X] Make it work with vectors
  - [X] Build wrapper for sgemm [100%]
    - [X] Wrapper done
    - [X] Make it work with raw float arrays
    - [X] Add to test script
  - [ ] Port sgemm wrapper to CUDA [0%]
    - [ ] CMalloc/Free
    - [ ] CMmemcpy, host2dev,dev2host,dev2dev
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