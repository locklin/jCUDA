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
  CUDA =: '/usr/local/cuda-6.5/lib64/stubs/libcuda.so'
  CUBLAS =: '/usr/local/cuda-6.5/lib64/libcublas.so'
elseif. UNAME-:'Darwin' do.
  'platform not supported' 13!:8[10
elseif. UNAME-: 'Win' do.
  'platform not supported' 13!:8[10
elseif. do.
 'platform not supported' 13!:8[10
end.
)


CMalloc=: 3 : 0
  cmd=. CUDA, ' cuMemAlloc x x'
  err=. 0 pick cmd cd y
  ptr;err
)

CFree=: 3 : 0
 cmd=. CUDA,' cuMemFree x x'
 err=. 0 pick cmd cd y
 err
)


CMemCpy=: 3 : 0
 sz=. 4 * */ $ y
 
 cmh2 =. CUDA, ' cuMemcpyHtoD * * x'
 cmd2 =. CUDA, ' cuMemcpyDtoH * * x'

)

CMemCpy =: 3 : 0
 'data ptr kind' =. y
  count =. */ $data
 cmd=. CUDA, ' cuMemcpy x * *'
 0 pick cmd cd ptr;data;count;kind
)





NB. https://github.com/jakedouglas/cuda-ffi/tree/master/lib/cuda

NB. probably don't need these:
NB. cudaMallocPitch?
NB. cudaThreadSynchronize?
NB. cudaThreadSetLimit ? 
NB. cudaMemcpy2d?
NB. These may require some C hooks; check the Torch7 source for inspiration



NB. these seem to be C++ versions or something.
NB.  CUDA =: '/usr/local/cuda-6.5/lib64/libcudart.so'

NB. CSetDev=: 3 : 0
NB.  cmd=. CUDA, ' cudaSetDevice x x'
NB.  0 pick cmd cd y
NB. )

NB. CGetDevProp =: 3 : 0
NB.  cmd=. CUDA, ' cudaGetDeviceProperties * * x'
 
NB. )



NB. CDevReset=: 3 : 0
NB.   cmd=. CUDA, ' cudaDeviceReset x'
NB.   err=. cmd cd ''
NB. )



NB. CBlasHandle =: 3 : 0
NB.   ptr=.0
NB.   cmd=. CUBLAS, ' cublasCreate x *'
NB.   0 pick cmd cd ptr
NB. )

NB. CGetCount =: 3 : 0
NB.  a=. 0
NB.  cmd=. CUDA,' cudaGetDeviceCount x x'
NB.  err=.0 pick cmd cd;a
NB.  err;a
NB. )

NB. CFree =: 3 : 0
NB.  cmd=. CUDA, ' cudaFree x *'
NB.  0 pick cmd cd y
NB. )
