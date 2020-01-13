import warnings
warnings.filterwarnings('ignore')
import os
import keras
from keras import backend as K
print("Keras = {}".format(keras.__version__))
import tensorflow as tf
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'  # or any {'0', '1', '2'}
import numpy as np
import pylab
import sys
import math
import keras.backend.tensorflow_backend as KTF
from keras.models import load_model
from sklearn import metrics
#from model_logic2 import *
#from generator2 import *
import scipy.io as sio
from keras.utils import plot_model
os.environ["CUDA_VISIBLE_DEVICES"]="5"

config = tf.ConfigProto(allow_soft_placement=True)
config.gpu_options.per_process_gpu_memory_fraction = 0.9
#config.gpu_options.allow_growth = True
session = tf.Session(config = config)
KTF.set_session(session)

sys.setrecursionlimit(2000)



def bce_dice_loss(y_true, y_pred):
    return NMSE(y_true, y_pred)

def NMSE(y_true, y_pred):
    a = K.sqrt(K.sum(K.square(y_true - y_pred)))
    b = K.sqrt(K.sum(K.square(y_true)))
    return a / b


indirect1=120
indirect2=120
batch_size=732
model_path = "./model/EDHRN/"


print('[*] load data ... ')

X_test=sio.loadmat('./undersampled_Azurin.mat')
X_test=X_test['undersampled_Azurin']
X_test=np.reshape(X_test, (batch_size,indirect1,indirect2,1))



################################################

print('[*] define model ...')

model = load_model(os.path.join(model_path, "EDHRN_3D.h5"), custom_objects={'bce_dice_loss':bce_dice_loss, 'NMSE':NMSE})

print('[*] start testing ...')

x_gen = model.predict(X_test, batch_size=64, verbose=1)
sio.savemat('rec_spec.mat',{'rec_spec':x_gen})

print("[*] Job finished!")

