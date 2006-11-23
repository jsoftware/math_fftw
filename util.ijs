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
