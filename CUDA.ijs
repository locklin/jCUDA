cd=: 15!:0

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
  CUDA =: '/usr/local/cuda-6.5/lib64/libcudart.so'
  CUBLAS =: '/usr/local/cuda-6.5/lib64/libcublas.so'
elseif. UNAME-:'Darwin' do.
  'platform not supported' 13!:8[10
elseif. UNAME-: 'Win' do.
  'platform not supported' 13!:8[10
elseif. do.
 'platform not supported' 13!:8[10
end.
)


CSetDev=: 3 : 0
 cmd=. CUDA, ' cudaSetDevice x x'
 0 pick cmd cd y
)

CGetDevProp =: 3 : 0
 cmd=. CUDA, ' cudaGetDeviceProperties * * x'
 
)

CMalloc=: 3 : 0
  ptr =. 0
  cmd=. CUDA, ' cudaMalloc * x x'
  err=. 0 pick cmd cd ptr;y
  ptr;err
)


CDevReset=: 3 : 0
  cmd=. CUDA, ' cudaDeviceReset x'
  err=. cmd cd ''
)



CBlasHandle =: 3 : 0
  ptr=.0
  cmd=. CUBLAS, ' cublasCreate x *'
  0 pick cmd cd ptr
)

CGetCount =: 3 : 0
 a=. 0
 cmd=. CUDA,' cudaGetDeviceCount x x'
 err=.0 pick cmd cd;a
 err;a
)

CFree =: 3 : 0
 cmd=. CUDA, ' cudaFree x *'
 0 pick cmd cd y
)

CMemCpy =: 3 : 0
 'data ptr kind' =. y
  count =. */ $data
 cmd=. CUDA, ' cudaMemcpy x * *'
 0 pick cmd cd ptr;data;count;kind
)







NB. probably don't need these:
NB. cudaMallocPitch?
NB. cudaThreadSynchronize?
NB. cudaThreadSetLimit ? 
NB. cudaMemcpy2d?
NB. These may require some C hooks; check the Torch7 source for inspiration
