cd=: 15!:0

NB. path of libblas
3 : 0''
if. UNAME-:'Linux' do.
  LIBBLAS=: '/usr/lib/libblas.so' 
elseif. UNAME-:'Darwin' do.
  'platform not supported' 13!:8[10
NB.   LIBFLANN=: '"',~'"',jpath '~addons/math/flann/libflann.dylib'
elseif. UNAME-: 'Win' do.
  'platform not supported' 13!:8[10
elseif. do.
  NB. for eventual package inclusion LIBFLANN=: '"',~'"',jpath '~addons/math/flann/libflann.so', (IF64#'_64'), '.dll'
end.
)

NB. *A bmp B
NB. -BLAS multiply of A and B, returns C
bmp =: 4 : 0
 'd1 d2'=. $ x
 'd4 d3'=. $ y
 if. d2=d4 do.
   C =. (d1,d3) $0
   alpha =. 3.2-2.2
   beta =. 2.2-2.2
   Notrans =. 111
   Colmaj =. 101
   cmd =. LIBBLAS,' cblas_dgemm * x x x x x x d *d x *d x d *d x'
   C =. 13 pick cmd cd Colmaj;Notrans;Notrans;d1;d3;d2;alpha;x;d2;y;d1;beta;C;d1
 else. 
   smoutput 'rank error; d2=',(": d2),' d4=',(":d4),' should be the same'
 end.
 C
)


NB. 	cblas_dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, dim1, dim3, dim2, alpha, &*A.begin(), dim1, &*B.begin(), dim2, beta, &*C.begin(), dim1);
load'stats/base/random'
a =. rand01 1000,1200
b =. rand01 1200,1000
tj =. 6!:2 'c=. a mp b'
tb =. 6!:2 'c=. a bmp b'
smoutput 'OpenBlas speedup over J: ', (": tj % tb), ' tj= ', (": tj),' tblas= ',":tb
