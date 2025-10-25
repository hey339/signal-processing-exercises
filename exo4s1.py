import numpy as np
import matplotlib.pyplot as plt
import sounddevice as sd  # pour le son
x = np.arange(-np.pi, np.pi, 0.001)

# Signaux de base
u = np.sin(np.pi/4 * x)
v = np.cos(np.pi/4 * x)

# Bruit 

noise_u = 0.5 * np.random.randn(len(x))
noise_v = 0.5 * np.random.randn(len(x))

# Signaux bruités
u_noisy = u + noise_u
v_noisy = v + noise_v

# Affichage
plt.figure(figsize=(10,6))

plt.subplot(2,1,1)
plt.plot(x, u_noisy, 'r', linewidth=1.5, label='u(x) avec bruit')
plt.plot(x, u, 'b', linewidth=1.5, label='u(x) original')
plt.xlabel('x')
plt.ylabel('Amplitude')
plt.title('Signal sinus bruité')
plt.legend()
plt.grid(True)

plt.subplot(2,1,2)
plt.plot(x, v_noisy, 'r', linewidth=1.5, label='v(x) avec bruit')
plt.plot(x, v, 'b', linewidth=1.5, label='v(x) original')
plt.xlabel('x')
plt.ylabel('Amplitude')
plt.title('Signal cosinus bruité')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.show()

