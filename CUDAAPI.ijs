NB. These are hooks into the CUDA-API which is more complex than CUDART/runtime

NB. path of CUDA 
3 : 0''
if. UNAME-:'Linux' do.
  CUDA =: '/usr/local/cuda-6.5/lib64/stubs/libcuda.so'
  CUDABLAS=: '/usr/local/cuda-6.5/lib64/stubs/libcublas.so'

elseif. UNAME-:'Darwin' do.
  'platform not supported' 13!:8[10
elseif. UNAME-: 'Win' do.
  'platform not supported' 13!:8[10
elseif. do.
 'platform not supported' 13!:8[10
end.
)


CInit=: 3 : 0
 cmd=. CUDA,' cuInit i i'
 err=. 0 pick cmd cd 0
 err
)

CDevSet=: 3 : 0
 ptr=. 0
 cmd=. CUDA,' cuDeviceGet x x x'
 err=. 0 pick cmd cd 0
 ptr;err
)

CCtxCreate =: 3 : 0
 ptr=. 0
 cmd=. CUDA,' cuCtxCreate x x x'
 err=. 0 pick cmd cd y;ptr
)

CMalloc=: 3 : 0
  ptr=. 0
  cmd=. CUDA, ' cuMemAlloc i i'
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
 
 cmh2 =. CUDA, ' cuMemcpyHtoD x * * x'
 cmd2 =. CUDA, ' cuMemcpyDtoH x * * x'

)

CMemCpy =: 3 : 0
 'data ptr kind' =. y
  count =. */ $data
 cmd=. CUDA, ' cuMemcpy x * *'
 0 pick cmd cd ptr;data;count;kind
)


CBlasHandle =: 3 : 0
  ptr=.0
  cmd=. CUDABLAS, ' cublasCreate x *'
  0 pick cmd cd ptr
)


