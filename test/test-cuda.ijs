dtol =: 1000 * 9!:18 '' 
load'stats/base/random'
load'/home/scott/src/jCUDA/CUDA.ijs'

CGetDevMem''
CGetDevV''
a=. CMalloc 8
CFree a

a=. CMalloc 4
zx=. 1&fc 1.1
err=. CCopy a;zx;4;1
NB. the cuckorachas go in but they don't come out....
zy=. mema 4
err=. CCopy a;zy;4;2
err=. CCopyOut a;zy;4;2

CFree a




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
