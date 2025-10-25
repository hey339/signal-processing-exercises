import numpy as np
import matplotlib.pyplot as plt


n = np.arange(-20, 21)

dirac_pulse = (n == 0).astype(int)
step_signal = (n >= 0).astype(int)
window_signal = (np.abs(n) <= 5).astype(int)
gaussian_signal = np.exp(-(n**2)/(2*5**2))

plt.figure(figsize=(10,6))

plt.subplot(2,2,1)
plt.stem(n, dirac_pulse, basefmt=" ")
plt.title('Dirac')

plt.subplot(2,2,2)
plt.stem(n, step_signal, basefmt=" ") #stem plot en forme baton
plt.title('Step')

plt.subplot(2,2,3)
plt.stem(n, window_signal, basefmt=" ")
plt.title('Window')

plt.subplot(2,2,4)
plt.stem(n, gaussian_signal, basefmt=" ")
plt.title('Gaussian')

plt.tight_layout() #tigtht pour eviter melanger ces plots 
plt.show()
