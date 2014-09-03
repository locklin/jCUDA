load'/home/scott/src/jCUDA/BLAS.ijs'
load'stats/base/random'
dtol =: 1000 * 9!:18 '' 

mp =: +/ . *

blasck =: 3 : 0
 assert.  (dtol^0.5) >  | c - cbb 
)


fblasck=: 3 : 0
 assert. (dtol^0.25) > | c - cf
)

setmul=: 3 : 0
'ra ca rb cb'=.y
 a =: rand01 ra,ca
 b =: rand01 rb,cb
 c =: a mp b
 cf =: fltBk a fbmp b
 cbb =: a bmp b
''
)


setmul 5;4;4;3
blasck ''
fblasck ''
setmul 5;4;4;5
blasck ''
fblasck ''
setmul 3;4;4;5
blasck ''
fblasck ''
setmul 100;120;120;101
blasck ''
fblasck ''



NB. NB. speed test
NB. a =. rand01 1000,1200
NB. b =. rand01 1200,1000
NB. tj =. 6!:2 'c=. a mp b'
NB. tb =. 6!:2 'cbb=. a bmp b'
NB. tfb =. 6!:2 'cf=. fltBk a fbmp b'
NB. smoutput 'OpenBlas speedup over J: ', (": tj % tb), ' tj= ', (": tj),' tblas= ',":tb
NB. smoutput 'OpenBlasFloat speedup over OpenBlas: ', (": tb % tfb), ' tblas= ', (": tb),' tfblas= ',":tfb
NB. NB. Note a fair amount of overhead here, from the deep copy


