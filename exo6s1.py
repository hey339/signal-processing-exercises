import numpy as np
import sounddevice as sd
import time


Fs = 8000                    
t = np.arange(0, 0.5, 1/Fs)


F = [440]  
for n in range(1, 12):
    F.append(F[n-1] * 2**(1/12))#append permet dajouter element dans F

#generation et lecture des notes
for f in F:
    y = np.sin(2*np.pi*f*t)
    sd.play(y, Fs)
    sd.wait()       
    time.sleep(0.1) #sleep fait des pose entre ces notes