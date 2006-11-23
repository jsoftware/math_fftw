
FM=: jpath '~Addons/math/fftw/'
TO=: jpath '~addons/math/fftw/'

(TO,'jfftw.dll') fcopynew FM,'jfftw.dll'
(TO,'fftw.ijt') fcopynew FM,'fftw.ijt'

load jpath '~addons/math/fftw/fftw.ijs'
