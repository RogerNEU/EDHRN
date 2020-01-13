import nmrglue as ng
import mat4py as mt
import pylab
import numpy as np
import scipy.io as sio




dic, data = ng.pipe.read("./nmr/ft4sp.xyza.2D")
print(data.ndim)
print(data.shape)
print(data.dtype)

M = sio.loadmat('rec_FID.mat')
Data = M['rec_FID']
Data = np.array(Data, dtype=np.float32)

ng.pipe.write("./nmr/rec_FID.dat", dic, Data, overwrite=True)