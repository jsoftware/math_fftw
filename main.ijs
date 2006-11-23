NB. fftw

NB. =========================================================
NB.*createplan v create a plan
NB. y = shape ; direction; flag
NB.
NB.   direction = FFTW_FORWARD | FFTW_BACKWARD
NB.   flag = FFTW_ESTIMATE | FFTW_MEASURE
createplan=: 3 : 0
'shape dir flag'=. y
assert dir e. FFTW_FORWARD,FFTW_BACKWARD
assert flag e. FFTW_ESTIMATE, FFTW_MEASURE
shape=. ,shape + izero
dir=. dir + izero
flag=. flag + izero
cmd=. DLL,' fftwnd_create_plan + i i *i i i'
0 pick cmd cd (#shape);shape;dir;flag
)

NB. =========================================================
NB.*destroyplan v destroy a plan
destroyplan=: 3 : 0
cmd=. DLL,' fftw_destroy_plan + i i'
1 [ cmd cd y
)

NB. =========================================================
NB.*fftwnd d n-dimensional FFT
NB. x =  _1 forward
NB.        1 backward
NB. y =  data
fftwnd=: 4 : 0
assert x e. _1 1
dir=. x + izero
plan=. createplan ($y);dir;FFTW_ESTIMATE
res=. fftwndone plan;dir;y
destroyplan plan
res
)

NB. =========================================================
NB.*fftwndone d one call to n-dimensional FFT
NB. y =  plan;direction;data
fftwndone=: 3 : 0
'plan dir data'=. y
shp=. $data
in=. zzero + , |: data
out=. in * 0
cmd=. DLL,' fftwnd_one + i i *j *j'
res=. |: (|.shp) $ > {: cmd cd plan;in;out
if. dir=1 do. res % */shp end.
)
