import soundfile as sf # type: ignore
import sounddevice as sd # type: ignore
import numpy as np # type: ignore
import matplotlib.pyplot as plt # type: ignore

# === Lecture du fichier audio ===
y, fs = sf.read('C:/Users/Aya/Desktop/souds_Master/compte.wav')

# Si le son est stéréo → on prend un seul canal
if y.ndim > 1:
    y = y[:, 0]

# === Lecture du son normal ===
print("Lecture du son normal...")
sd.play(y, fs)
sd.wait()


print("Lecture du son accéléré...")
sd.play(y, 2 * fs)
sd.wait()

time = np.arange(len(y)) / fs
plt.figure(figsize=(8, 4))
plt.plot(time, y)
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.title('Waveform of compte.wav')
plt.grid(True)
plt.show()
