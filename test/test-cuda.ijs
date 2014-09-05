dtol =: 1000 * 9!:18 '' 
load'stats/base/random'
load'/home/scott/src/jCUDA/CUDA.ijs'

CGetDevMem''
CPrintDevV''
a=. CMalloc 8





NB. I'm guessing this is going to require wrapping the CUDA kernels
NB. into a C thing
NB. CDevReset ''
NB. CSetDev 0 NB. returns 0...

NB.CGetDevCt '' NB. runtime insufficient
NB. CSetDev 0
NB. CMalloc 4
NB. 'ptr err'=. CMalloc 4000 NB. error code 11
NB. 'ptr err'=. CMalloc2 4000 NB. error code 11
NB. 'err n'=.CGetCount '' NB. error code 11
