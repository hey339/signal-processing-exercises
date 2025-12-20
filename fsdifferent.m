
[battement, fs_batt] = audioread('C:\Users\Aya\Desktop\souds_Master\battement.wav');
[guitar, fs_guit]    = audioread('C:\Users\Aya\Desktop\souds_Master\guitar.wav');
[bass, fs_bass]      = audioread('C:\Users\Aya\Desktop\souds_Master\bass.wav');

disp('--- Fréquences d''échantillonnage détectées ---');
disp(['Battement : ', num2str(fs_batt), ' Hz']);
disp(['Guitare   : ', num2str(fs_guit), ' Hz']);
disp(['Basse     : ', num2str(fs_bass), ' Hz']);

target_fs = 44100; % choix standard (qualité CD)

if fs_batt ~= target_fs
    battement = resample(battement, target_fs, fs_batt);
end
if fs_guit ~= target_fs
    guitar = resample(guitar, target_fs, fs_guit);
end
if fs_bass ~= target_fs
    bass = resample(bass, target_fs, fs_bass);
end

fs = target_fs; % fréquence commune finale

if size(battement,2) == 2, battement = mean(battement,2); end
if size(guitar,2) == 2, guitar = mean(guitar,2); end
if size(bass,2) == 2, bass = mean(bass,2); end

maxLen = max([length(battement), length(guitar), length(bass)]);
battement(end+1:maxLen) = 0;
guitar(end+1:maxLen)    = 0;
bass(end+1:maxLen)      = 0;

disp('--- Durées des signaux (en secondes) ---');
disp(['Battement : ', num2str(length(battement)/fs)]);
disp(['Guitare   : ', num2str(length(guitar)/fs)]);
disp(['Basse     : ', num2str(length(bass)/fs)]);

bass = bass * 2; % amplification douce
mix = 0.8*battement + 1.0*guitar + 1.2*bass;

maxVal = max(abs(mix));
if maxVal > 1
    mix = mix / (maxVal + 0.01);
end

t = (0:length(mix)-1) / fs;
figure;
plot(t, mix);
xlabel('Temps (s)');
ylabel('Amplitude');
title('Signal audio mixé (final)');
grid on;

sound(mix, fs);
audiowrite('C:\Users\Aya\Desktop\souds_Master\mix_final.wav', mix, fs);
disp('? Mix final lu et sauvegardé sous "mix_final.wav"');
