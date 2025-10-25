import numpy as np
import sounddevice as sd  # pour le son

Fe = 44100              # fréquence d'échantillonnage
t = np.arange(0, 2, 1/Fe)  # vecteur temps de 0 à 2 secondes

# Fréquences
f0 = 400
f1 = 500
f2 = 1000

# le signal complexe
x = np.sin(2*np.pi*f0*t) + 0.7*np.sin(2*np.pi*f1*t) + 0.7*np.sin(2*np.pi*f2*t)

# Lecture du son
sd.play(x, Fe)
sd.wait()  # attendre la fin du son
