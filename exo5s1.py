import numpy as np
import matplotlib.pyplot as plt

x = np.arange(-10, 11)

# Signaux
U = (x >= 0).astype(int)          # signal1
V = np.exp(-0.3 * np.abs(x))      # signal 2

# Manipulations
Y_add = U + V                      
Y_mult = 0.6*U + 0.4*V             
Y_trunc = U * (np.abs(x) <= 5)     
Y_rev = U[::-1]                     


plt.figure()
plt.stem(x, Y_add, basefmt=" ")
plt.title('Add')

plt.figure()
plt.stem(x, Y_mult, basefmt=" ")
plt.title('mult')

plt.figure()
plt.stem(x, Y_trunc, basefmt=" ")
plt.title('trunk')

plt.figure()
plt.stem(x, Y_rev, basefmt=" ")
plt.title('Reverse')

plt.show()
