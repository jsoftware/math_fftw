
FM=: jpath '~Addons/math/fftw/'
TO=: jpath '~addons/math/fftw/'

(TO,'libfftw3-3.dll') fcopynew FM,'libfftw3-3.dll'
(TO,'fftw.ijs') fcopynew FM,'fftw.ijs'
(TO,'fftw.ijt') fcopynew FM,'fftw.ijt'

load 'math/fftw'
