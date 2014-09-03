dtol =: 1000 * 9!:18 '' 
load'stats/base/random'
load'/home/scott/src/jCUDA/CUDA.ijs'


CDevReset ''
CSetDev 0 NB. returns 0...

'ptr err'=. CMalloc 4000 NB. error code 11
'ptr err'=. CMalloc2 4000 NB. error code 11
'err n'=.CGetCount '' NB. error code 11

CBlasHandle ''  NB. no such function...




NB. I'm guessing this is going to require wrapping the CUDA kernels
NB. into a C thing