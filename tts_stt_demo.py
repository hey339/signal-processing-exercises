# tts_stt_demo.py

import pyttsx3
import speech_recognition as sr

def tts(texte):
    """Convertit le texte en parole"""
    engine = pyttsx3.init()
    engine.say(texte)
    engine.runAndWait()

def stt():
    """Reconnaissance vocale depuis le micro"""
    recognizer = sr.Recognizer()
    mic = sr.Microphone()

    with mic as source:
        print("Calibration du bruit ambiant...")
        recognizer.adjust_for_ambient_noise(source, duration=1)
        print("Parlez maintenant...")
        audio = recognizer.listen(source)

    try:
        texte = recognizer.recognize_google(audio, language="fr-FR")
        print("\nTexte reconnu :")
        print(texte)
        with open("transcription.txt", "w", encoding="utf-8") as f:
            f.write(texte)
        print("\nTexte sauvegardé dans 'transcription.txt'")
    except sr.UnknownValueError:
        print("Impossible de comprendre l'audio")
    except sr.RequestError as e:
        print(f"Erreur du service STT : {e}")

def menu():
    while True:
        print("\n=== Menu TTS / STT ===")
        print("1. Text-to-Speech (TTS)")
        print("2. Speech-to-Text (STT)")
        print("3. Quitter")
        choix = input("Votre choix: ")

        if choix == '1':
            texte = input("Entrez le texte à prononcer : ")
            tts(texte)
        elif choix == '2':
            stt()
        elif choix == '3':
            print("Au revoir !")
            break
        else:
            print("Choix invalide !")

if __name__ == "__main__":
    menu()
