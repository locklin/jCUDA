cd=: 15!:0
typeof=: 3!:0 
NB. fltBk =: $ $ [: _1&fc ,
fltBk =: (2 {. $) $ [: _1&fc ,

NB. path of libblas
3 : 0''
if. UNAME-:'Linux' do.
  LIBBLAS=: '/usr/lib/libblas.so' 
elseif. UNAME-:'Darwin' do.
  'platform not supported' 13!:8[10
elseif. UNAME-: 'Win' do.
  'platform not supported' 13!:8[10
elseif. do.
 'platform not supported' 13!:8[10
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
   cmd cd Colmaj;Notrans;Notrans;d1;d3;d2;alpha;x;d2;y;d3;beta;C;d3
 else. 
   smoutput 'rank error; d2=',(": d2),' d4=',(":d4),' should be the same'
 end.
 C
)


NB. *C=. A fbmp B
NB. -BLAS float multiply of A and B, returns C
NB. -returns C in a float format that can be reused for another MMUL 
NB. -since this is how the CUDA piece will work -SCL
NB. -floats can be converted into doubles with the correct shape
NB. -using fltBk verb. 
fbmp =: 4 : 0
 'd1 d2'=. $ x
 'd4 d3'=. $ y
 if. d2=d4 do.
   if. 8 = typeof x do.
    A =. 1&fc"0 x
   else.
    A =. x
   end.
   if. 8 = typeof y do.
    B =. 1&fc"0 y
   else. 
    B =. y
   end.
   C =. 1&fc"0 (d1, d3) $ 0
   alpha =. 3.2-2.2
   beta =.  2.2-2.2
   Notrans =. 111
   Colmaj =. 101
   cmd =. LIBBLAS,' cblas_sgemm * x x x x x x f *f x *f x f * x'
   cmd cd Colmaj;Notrans;Notrans;d1;d3;d2;alpha;x;d2;y;d3;beta;C;d3
 else. 
   smoutput 'rank error; d2=',(": d2),' d4=',(":d4),' should be the same'
 end.
C 
)


NB. m = d1, k=d2,d4, n = d3
NB.   cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, 
NB.                m, n, k, alpha, A, k, B, n, beta, C, n);



