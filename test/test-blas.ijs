load'stats/base/random'
a =. rand01 100,120
b =. rand01 120,100
c=: a mp b
cb=: a bmp b
cff=:  a fbmp b

dtol =: 1000 * 9!:18 '' 


blasck =: 3 : 0
 assert.  dtol >  | c - cb 
)

fblasck=: 3 : 0
 assert. (dtol^0.25) > | c - cf
)

blasck ''
fblasck ''

NB. NB. speed test
NB. a =. rand01 1000,1200
NB. b =. rand01 1200,1000
NB. tj =. 6!:2 'c=. a mp b'
NB. tb =. 6!:2 'cb=. a bmp b'
NB. tfb =. 6!:2 'cf=. a fbmp b'
NB. smoutput 'OpenBlas speedup over J: ', (": tj % tb), ' tj= ', (": tj),' tblas= ',":tb
NB. smoutput 'OpenBlasFloat speedup over OpenBlas: ', (": tb % tfb), ' tblas= ', (": tb),' tfblas= ',":tfb
NB. NB. Note a fair amount of overhead here, from the deep copy