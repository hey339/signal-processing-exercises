import numpy as np
import pyaudio
import time

class VoiceGenderDetector:
    def __init__(self):
        self.CHUNK = 4096
        self.FORMAT = pyaudio.paInt16
        self.CHANNELS = 1
        self.RATE = 16000
        self.threshold = 500
        
    def detect_pitch(self, audio_data):
        """Détection fiable de la fréquence fondamentale (pitch)"""
        audio_float = audio_data.astype(np.float32)
        audio_float = audio_float / (np.max(np.abs(audio_float)) + 1e-8)

        corr = np.correlate(audio_float, audio_float, mode='full')
        corr = corr[len(corr)//2:]

        # Fenêtre pour la fréquence humaine (50-300 Hz)
        min_period = int(self.RATE / 300)  # 300 Hz max
        max_period = int(self.RATE / 50)   # 50 Hz min

        window = corr[min_period:max_period]
        if len(window) == 0:
            return 0

        peak_index = np.argmax(window)
        true_period = peak_index + min_period
        pitch = self.RATE / true_period
        return pitch
    
    def extract_features(self, audio_data):
        """Extraire les caractéristiques audio"""
        audio_float = audio_data.astype(np.float32) / 32768.0
        
        pitch = self.detect_pitch(audio_data)
        
        spectrum = np.abs(np.fft.rfft(audio_float))
        freqs = np.fft.rfftfreq(len(audio_float), 1/self.RATE)
        spectral_centroid = np.sum(freqs * spectrum) / (np.sum(spectrum) + 1e-8)
        
        low_energy = np.sum(spectrum[freqs < 300])
        mid_energy = np.sum(spectrum[(freqs >= 300) & (freqs < 3000)])
        high_energy = np.sum(spectrum[freqs >= 3000])
        
        return {
            'pitch': pitch,
            'spectral_centroid': spectral_centroid,
            'low_energy': low_energy,
            'mid_energy': mid_energy,
            'high_energy': high_energy
        }
    
    def is_voice_active(self, audio_data):
        """Détecter si la voix est active"""
        energy = np.sum(np.abs(audio_data))
        return energy > self.threshold
    
    def analyze_and_decide(self, all_features):
        """Analyser toutes les caractéristiques et décider du genre"""
        if len(all_features) == 0:
            return "❌ Aucune voix détectée", 0, 0
        
        male_votes = 0
        female_votes = 0
        total_pitch = 0
        pitch_count = 0
        
        for features in all_features:
            pitch = features['pitch']
            spectral_centroid = features['spectral_centroid']
            
            if pitch == 0 or pitch < 50 or pitch > 400:
                continue
            
            total_pitch += pitch
            pitch_count += 1
            
            male_score = 0
            female_score = 0
            
            # Seuils pitch Homme/Femme
            if 100 <= pitch <= 150:
                male_score += 5
            elif 150 < pitch < 200:
                male_score += 2
                female_score += 2
            elif 200 <= pitch <= 300:
                female_score += 5
            elif pitch > 300:
                female_score += 3
            
            # Centroïde spectral
            if spectral_centroid < 1200:
                male_score += 2
            elif spectral_centroid > 1800:
                female_score += 2
            else:
                male_score += 1
                female_score += 1
            
            # Ratio haute fréquence
            high_ratio = features['high_energy'] / (features['mid_energy'] + 1e-8)
            if high_ratio > 0.3:
                female_score += 1
            else:
                male_score += 1
            
            if male_score > female_score:
                male_votes += 1
            elif female_score > male_score:
                female_votes += 1
        
        avg_pitch = total_pitch / pitch_count if pitch_count > 0 else 0
        
        if male_votes > female_votes:
            confidence = (male_votes / (male_votes + female_votes)) * 100
            return "👨 HOMME (Male)", confidence, avg_pitch
        elif female_votes > male_votes:
            confidence = (female_votes / (male_votes + female_votes)) * 100
            return "👩 FEMME (Female)", confidence, avg_pitch
        else:
            return "❓ Incertain", 50.0, avg_pitch
    
    def record_and_detect(self, duration=10):
        """Enregistrer et détecter le genre"""
        print("\n" + "="*70)
        print("🎤 DÉTECTION DE GENRE VOCAL")
        print("   VOICE GENDER DETECTION")
        print("="*70)
        print(f"\n⏱️  Enregistrement pendant {duration} secondes...")
        print(f"⏱️  Recording for {duration} seconds...")
        print("🎙️  Parlez maintenant! / Speak now!\n")
        
        p = pyaudio.PyAudio()
        try:
            stream = p.open(format=self.FORMAT,
                            channels=self.CHANNELS,
                            rate=self.RATE,
                            input=True,
                            frames_per_buffer=self.CHUNK)
            
            all_features = []
            start_time = time.time()
            print("📊 Progression: [", end='', flush=True)
            last_progress = 0
            
            while time.time() - start_time < duration:
                data = stream.read(self.CHUNK, exception_on_overflow=False)
                audio_data = np.frombuffer(data, dtype=np.int16)
                
                if self.is_voice_active(audio_data):
                    features = self.extract_features(audio_data)
                    all_features.append(features)
                
                progress = int((time.time() - start_time) / duration * 50)
                if progress > last_progress:
                    print("█" * (progress - last_progress), end='', flush=True)
                    last_progress = progress
            
            print("] ✅\n")
            stream.stop_stream()
            stream.close()
            p.terminate()
            
            print("🔍 Analyse en cours...\n")
            time.sleep(0.5)
            
            gender, confidence, avg_pitch = self.analyze_and_decide(all_features)
            
            print("="*70)
            print("📊 RÉSULTAT FINAL / FINAL RESULT")
            print("="*70)
            print(f"\n🎯 Genre détecté: {gender}")
            print(f"📈 Confiance: {confidence:.1f}%")
            print(f"🎵 Pitch moyen: {avg_pitch:.1f} Hz")
            print(f"📝 Frames analysés: {len(all_features)}")
            
            if avg_pitch > 0:
                if 100 <= avg_pitch <= 150:
                    print("💡 Analyse: Fréquence masculine typique (100-150 Hz)")
                elif 200 <= avg_pitch <= 300:
                    print("💡 Analyse: Fréquence féminine typique (200-300 Hz)")
                elif 150 < avg_pitch < 200:
                    print("💡 Analyse: Zone de transition (150-200 Hz)")
                elif avg_pitch < 100:
                    print("💡 Analyse: Fréquence très basse (< 100 Hz)")
                else:
                    print("💡 Analyse: Fréquence très haute (> 300 Hz)")
            
            print("="*70 + "\n")
            
        except Exception as e:
            print(f"\n❌ Erreur: {e}")
            p.terminate()


if __name__ == "__main__":
    detector = VoiceGenderDetector()
    
    print("\n📋 Instructions:")
    print("   1. Microphone connecté")
    print("   2. Parlez clairement pendant l'enregistrement")
    print("   3. Le résultat s'affichera à la fin\n")
    
    duration_input = input("⏱️  Durée d'enregistrement en secondes (défaut=10): ")
    try:
        duration = int(duration_input) if duration_input else 10
    except:
        duration = 10
    
    input("\n✅ Appuyez sur Entrée pour commencer...")
    detector.record_and_detect(duration)
    
    while True:
        retry = input("\n🔄 Voulez-vous réessayer? (o/n): ").lower()
        if retry in ['o', 'y']:
            detector.record_and_detect(duration)
        else:
            print("\n👋 Au revoir!")
            break
