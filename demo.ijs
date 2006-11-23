require 'plot numeric stats trig'
require 'system\packages\fftw\fftw.ijs'

t=: steps 0 0.1 200
x=: (sin t*2p1*3) + sin t*2p1*5
y=: x
y=: x + rand11 #t

NB. plot y
plot {.@+. fftw y

conv=: ifftw @: * & fftw
