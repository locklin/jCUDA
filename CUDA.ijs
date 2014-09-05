cd=: 15!:0
typeof=: 3!:0 
fltBk =: (2 {. $) $ [: _1&fc ,

NB. the cuda piece for sgemm should work the same as openBLAS
NB. 
NB. resources:
NB. http://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#cuda-c-runtime
NB. http://docs.nvidia.com/cuda/cublas/
NB. http://www.cs.cmu.edu/afs/cs/academic/class/15668-s11/www/cuda-doc/html/
NB. 
NB. Not sure where to find these (look in cuda.h) , but they're going to be needed
NB. primitives to move data around: 
NB. 
NB. cudaDeviceSynchronize
NB. cudaMalloc
NB. cudaFree
NB. cudaMemcpy
NB. cudaMemGetInfo 
NB.  cudaMemcpyHostToDevice, cudaMemcpyDeviceToHost, 
NB. cudaGetLastError
NB. cudaDeviceReset

NB. informational ones:
NB. cudaGetDeviceCount
NB. cudaGetDevice
NB. cudaGetDeviceProperties
NB. cudaCreateChannelDesc
NB. cudaGetErrorString

NB. cudaMemcpyHostToHost          =   0,      /**< Host   -> Host */
NB. cudaMemcpyHostToDevice        =   1,      /**< Host   -> Device */
NB. cudaMemcpyDeviceToHost        =   2,      /**< Device -> Host */
NB. cudaMemcpyDeviceToDevice      =   3,      /**< Device -> Device */
NB. cudaMemcpyDefault             =   4       /**< Default unified virtual address space */

HOST2DEV =: 1
DEV2HOST =: 2
DEV2DEV =: 3

NB. path of CUDA 
3 : 0''
if. UNAME-:'Linux' do.
  CUDART =: '/usr/local/cuda-6.5/lib64/libcudart.so' 
  CUBLAS =: '/usr/local/cuda-6.5/lib64/libcublas.so'
  CUDA=: '/home/scott/src/batchCUBLAS/libcb.so'
elseif. UNAME-:'Darwin' do.
  'platform not supported' 13!:8[10
elseif. UNAME-: 'Win' do.
  'platform not supported' 13!:8[10
elseif. do.
 'platform not supported' 13!:8[10
end.
)

CDevRes=: 3 : 0
 cmd=. CUDART,' cudaDeviceReset i'
 >cmd cd ''
)

CGetDevMem=: 3 : 0
 cmd =. CUDA,' getDeviceMemory x'
 >cmd cd ''
)


CGetDevV=: 3 : 0
 cmd =. CUDA,' getDeviceVersion x'
 >cmd cd ''
)


CMalloc=: 3 : 0
  cmd=. CUDA, ' MyCUDAMalloc x x'
  0 pick cmd cd y
)

CFree=: 3 : 0
 cmd=. CUDA,' MyCUDAFree x x'
 0 pick cmd cd y
)

CCopy=: 3 : 0
 'host dev sz kind'=.y
 cmd=. CUDA,' MyCUDACopy x x * x x'
 0 pick cmd cd host;dev;sz;kind  NB. there is probably a reason for making this explicit
)

CCopyOut=: 3 : 0
 'host dev sz kind'=.y
 cmd=. CUDA,' MyCUDACopy x x x x x'
 0 pick cmd cd host;dev;sz;2  
)


CCkErr=: 3 : 0
 cmd=. CUDART, ' cudaGetErrorString * x'
 sm=. 0 pick cmd cd y
 if. (100 > y) +. (sm>0) do.
  memr sm,0,_1
 else. 
  smountput 'not a cuda error value, err= ', :" y
 end.
)



NB. cublasCreate handle for cublas


NB. https://github.com/jakedouglas/cuda-ffi/tree/master/lib/cuda

NB. probably don't need these:
NB. cudaMallocPitch?
NB. cudaThreadSynchronize?
NB. cudaThreadSetLimit ? 
NB. cudaMemcpy2d?
NB. These may require some C hooks; check the Torch7 source for inspiration




NB. CSetDev=: 3 : 0
NB.  cmd=. CUDART, ' cudaSetDevice x x'
NB.  0 pick cmd cd y
NB. )

NB. CGetDevProp =: 3 : 0
NB.  cmd=. CUDART, ' cudaGetDeviceProperties * * x'
 
NB. )



NB. CDevReset=: 3 : 0
NB.   cmd=. CUDART, ' cudaDeviceReset x'
NB.   err=. cmd cd ''
NB. )



NB. CFree =: 3 : 0
NB.  cmd=. CUDART, ' cudaFree x *'
NB.  0 pick cmd cd y
NB. )



NB. CSetDev=: 3 : 0
NB.  cmd=. CUDART,' cudaSetDevice i x'
NB.  err=. 0 pick cmd cd 0
NB. )



NB. CMalloc=: 3 : 0
NB.   ptr=. <0
NB.   cmd=. CUDART, ' cudaMalloc x x'
NB.   err=. 0 pick cmd cd ptr
NB.   ptr;err
NB. )


NB. CVer=: 3 : 0
NB. cmd
NB. cuDeviceGetVersion
NB. )


NB. CFreeHst=: 3 : 0
NB.  cmd=. CUDART,' cudaFreeHost x x'
NB.  err=. 0 pick cmd cd 0
NB.  CCkErr err
NB. )

NB. CGetDevCt=: 3 : 0
NB.  ct=. 99
NB.  cmd=. CUDART,' cudaGetDeviceCount i i'
NB.  err=. 0 pick cmd cd ct
NB.  if. 0= err do.
NB.   smoutput 'Number of devices=',": ct
NB.  else.
NB.   CCkErr err
NB.  end.
NB. )
