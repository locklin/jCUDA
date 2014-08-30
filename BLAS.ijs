cd=: 15!:0
typeof=: 3!:0 
fltBk =: $ $ [: _1&fc ,

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


NB. *A fbmp B
NB. -BLAS float multiply of A and B, returns C
fbmp =: 4 : 0
 'd1 d2'=. $ x
 'd4 d3'=. $ y
 if. d2=d4 do.
   if. 8 = typeof x do.
    A =. 1&fc"0 x
   else.
    A =. x
   end.
   if. 8 = typeof x do.
    B =. 1&fc"0 y
   else. 
    B =. y
   end.
   Cm =. 1&fc (d1*d3) # 0
   alpha =. 3.2-2.2
   beta =.  2.2-2.2
   Notrans =. 111
   Colmaj =. 101
   cmd =. LIBBLAS,' cblas_sgemm * x x x x x x f *f x *f x f * x'
   Cf =.  13 pick cmd cd Colmaj;Notrans;Notrans;d1;d3;d2;alpha;A;d2;B;d1;beta;Cm;d1
 else. 
   smoutput 'rank error; d2=',(": d2),' d4=',(":d4),' should be the same'
 end.
 (d1,d3) $ _1&fc Cf
)


NB. 	cblas_dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, dim1, dim3, dim2, alpha, &*A.begin(), dim1, &*B.begin(), dim2, beta, &*C.begin(), dim1);
