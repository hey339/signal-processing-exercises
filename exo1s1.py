import numpy as np #cest la bibliorheque pour faire calcule numeique 
import matplotlib.pyplot as plt #bib pour ploter 


x = np.arange(-np.pi, np.pi, 0.001)  #ca permet de cree un vecteur de -pi a pi et pas 0.001


u = np.sin(np.pi/4 * x)
v = np.cos(np.pi/4 * x)

# Trace des signaux
plt.plot(x, u, 'b', linewidth=1.5, label=r'u(x) = sin($\pi/4 x$)')
plt.plot(x, v, 'r', linewidth=1.5, label=r'v(x) = cos($\pi/4 x$)')
plt.xlabel('x')
plt.ylabel('Amplitude')
plt.legend()
plt.grid(True)
plt.title('Signaux sinusoïdaux')
# Affichage
plt.show()
