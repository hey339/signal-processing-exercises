% === Lecture des sons ===
[battement, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\battement.wav');
[guitar, fs]    = audioread('C:\Users\Aya\Desktop\souds_Master\guitar.wav');
[bass, fs]      = audioread('C:\Users\Aya\Desktop\souds_Master\bass.wav');


if size(battement,2) == 2
    battement = mean(battement, 2);
end
if size(guitar,2) == 2
    guitar = mean(guitar, 2);
end
if size(bass,2) == 2
    bass = mean(bass, 2);
end


maxLen = max([length(battement), length(guitar), length(bass)]);

if length(battement) < maxLen
    battement(end+1:maxLen) = 0;
end
if length(guitar) < maxLen
    guitar(end+1:maxLen) = 0;
end
if length(bass) < maxLen
    bass(end+1:maxLen) = 0;
end


disp(['Durée battement : ', num2str(length(battement)/fs), ' s']);
disp(['Durée guitare   : ', num2str(length(guitar)/fs), ' s']);
disp(['Durée basse     : ', num2str(length(bass)/fs), ' s']);
disp(['Amplitude moyenne battement : ', num2str(mean(abs(battement)))]);
disp(['Amplitude moyenne guitare   : ', num2str(mean(abs(guitar)))]);
disp(['Amplitude moyenne basse     : ', num2str(mean(abs(bass)))]);

% === Amplification douce de la basse (si nécessaire) ===
bass = bass * 2;  

% === Fusion équilibrée ===
mix = 0.8*battement + 1.0*guitar + 1.2*bass;

% === Normalisation douce ===
maxVal = max(abs(mix));
if maxVal > 1
    mix = mix / (maxVal + 0.01);
end

% === Tracé du signal final ===
t = (0:length(mix)-1) / fs;
plot(t, mix);
xlabel('Temps (s)');
ylabel('Amplitude');
title('Signal audio mixé (corrigé)');

% === Lecture et sauvegarde ===
sound(mix, fs);
audiowrite('C:\Users\Aya\Desktop\souds_Master\mix_final_corrige.wav', mix, fs);
disp('? Mix final sauvegardé sous "mix_final_corrige.wav"');
