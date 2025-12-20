import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile

# --- Charger l'audio ---
Fs, y = wavfile.read(r"C:\Users\Aya\Documents\souds_Master\sunday.wav")
y = y[:,0] if y.ndim > 1 else y  # convertir en mono
N = len(y)
t = np.arange(N)/Fs

# --- FFT ---
Y = np.fft.fft(y)
f = np.fft.fftfreq(N, d=1/Fs)

# --- Définir les bandes ---
BF = (f >= 20) & (f <= 500)      # basse fréquence
MF = (f > 500) & (f <= 2000)     # moyenne fréquence
HF = (f > 2000) & (f <= Fs/2)    # haute fréquence

# --- Fonction de reconstruction en gardant seulement certaines fréquences ---
def compress_band(Y, band_mask):
    Y_new = np.zeros_like(Y)
    # garder les indices positifs
    Y_new[band_mask] = Y[band_mask]
    # garder les indices négatifs (FFT symétrique)
    Y_new[-np.where(band_mask)[0]] = Y[-np.where(band_mask)[0]]
    return np.real(np.fft.ifft(Y_new))

# --- Reconstruction ---
y_BF = compress_band(Y, BF)
y_MF = compress_band(Y, MF)
y_HF = compress_band(Y, HF)

# --- Tracer ---
plt.figure(figsize=(12,6))
plt.plot(t, y, label="Original", alpha=0.8)
plt.plot(t, y_BF, label="BF Compression", alpha=0.8)
plt.plot(t, y_MF, label="MF Compression", alpha=0.8)
plt.plot(t, y_HF, label="HF Compression", alpha=0.8)
plt.xlim(0, 0.05)  # zoom sur les premières 50 ms pour mieux voir
plt.xlabel("Time [s]")
plt.ylabel("Amplitude")
plt.title("Comparison of Original vs BF/MF/HF Compression")
plt.legend()
plt.show()
