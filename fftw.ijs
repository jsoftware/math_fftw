NB. built from project: ~Addons/math/fftw/fftw
NB. z definitions:

script_z_ '~system\main\dll.ijs'

coclass 'jfftw'


fftw_z_=: (_1 & fftwnd_jfftw_) :. (1 & fftwnd_jfftw_)
ifftw_z_=: (1 & fftwnd_jfftw_) :. (_1 & fftwnd_jfftw_)

NB. fftw utils
NB.
NB. cd            15!:0
NB. clean         clean numbers near 0
NB. info          cover for wdinfo
NB. matchclean    if clean x-y is all 0

izero=: 23-23
ione=: 23-22
dzero=: 1.1-1.1
done=: 2.1-1.1
zzero=: 1j1-1j1
zone=: 2j1-1j1

DLL=: '"',~'"',jpath '~addons\math\fftw\jfftw.dll'
 
FFTW_FORWARD=: _1
FFTW_BACKWARD=: ione
FFTW_ESTIMATE=: izero
FFTW_MEASURE=: ione

FFTW_VERSION=: 2.01

cd=: 15!:0

info=: wdinfo @ ('FFTW'&;)

matchclean=: 0: *./ . = clean @ , @: -

NB. =========================================================
NB.*clean v clean numbers to tolerance (default 1e_10)
NB. sets values less than tolerance to 0
clean=: (1e_10&$:) : (4 : 0)
if. L. y do.
  x clean each y
else.
  if. 16 ~: 3!:0 y do.
    y * x <: |y
  else.
    j./"1 y* x <: | y=. +.y
  end.
end.
)


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

