NB. test fftw system
NB.
NB. load this file with 0!:2
NB.
NB.   0!:2 <'\jx\addon\fftw\fftw\testfftw.ijs'

load '~system\packages\fftw\fftw.ijs'

clean=: 1e_10&$: : (4 : 0)
if. (3!:0 y) e. 16 16384 do.
  j./"1 y* x <: | y=. +.y
else.
  y * x <: |y
end.
)

dfft=: 3 : '+/ y * ^ (#y) %~ (- o. 0j2 ) * */~ i.#y'
matchclean=: 0: *./ . = clean @ , @: -
round=: [ * [: <. 0.5"_ + %~

A34=: j./?.1+i.2 3 4

FFTA34=: ". ;._2 (0 : 0)
39j99 _10j_10 10.3661j18.8301 9.3205j_6.6795
_8j6 _33.0788j_17.2417 _13.9282j3.0526 8.634j10.1698
_1j13 _25.3205j_41.3205 24.0789j_39.7584 _0.0718j_35.0526
)

NB. =========================================================
NB. test dat = ifftw fftw dat

f=: matchclean ifftw@fftw
f i.8
f i.4096
f i.2 3 4
f ?.(6?.10)$100

NB. =========================================================
NB. test against direct calculation

f=: dfft matchclean fftw
f i.8
f i.132

NB. =========================================================
NB. known examples:
a=: 2 0 1 0 0 0 1 0
b=: 4 2 0 2 4 2 0 2

a matchclean ifftw b
b matchclean fftw a
FFTA34 matchclean 1e_4 round fftw A34

NB. =========================================================
NB. createplan
NB. existimate:
P=: createplan_jfftw_ 3 4;_1;0
FFTA34 matchclean 1e_4 round fftwndone_jfftw_ P;_1;A34
FFTA34 matchclean 1e_4 round  -: fftwndone_jfftw_ P;_1;A34*2
destroyplan_jfftw_ P

NB. performance measure:
P=: createplan_jfftw_ 3 4;_1;1
FFTA34 matchclean 1e_4 round fftwndone_jfftw_ P;_1;A34
FFTA34 matchclean 1e_4 round  -: fftwndone_jfftw_ P;_1;A34*2
destroyplan_jfftw_ P
