# Python
import numpy as np
import matplotlib.pyplot as plt

t = np.linspace(-np.pi, np.pi, 1200)
f = np.abs(t)
N = 80
S = (np.pi/2)*np.ones_like(t)
plt.figure(figsize=(10,4)); plt.grid(True)
plt.title('Exercise 3A: f(t)=|t| (even) — Visualization of Harmonics')
for n in range(1,N+1):
    an = 2*((-1)**n - 1)/(np.pi*n**2)
    term = an*np.cos(n*t)
    plt.plot(t, term, color=(0.5,0.5,0.5,0.25), linewidth=0.8)
    S += term
plt.plot(t, S, 'r', linewidth=1.6, label='Reconstructed S(t)')
plt.plot(t, f, 'k', linewidth=1.2, label='Original f(t)')
plt.legend(); plt.show()