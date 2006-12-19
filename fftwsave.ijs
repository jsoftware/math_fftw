
FM=: jpath '~Addons/math/fftw/'
TO=: jpath '~addons/math/fftw/'

(TO,'jfftw.dll') fcopynew FM,'jfftw.dll'
(TO,'fftw.ijs') fcopynew FM,'fftw.ijs'
(TO,'fftw.ijt') fcopynew FM,'fftw.ijt'

load 'math/fftw'
