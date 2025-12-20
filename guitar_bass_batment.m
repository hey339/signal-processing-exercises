[battement, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\battement.wav');
[guitar, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\guitar.wav');
[bass, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\bass.wav');
t = (0:length(bass)-1)/fs;
plot(t, bass);
xlabel('Temps (s)');
ylabel('Amplitude');
title('Signal de la basse');
% Convertir en mono si st?r?o
if size(battement,2) == 2
    battement = mean(battement,2);
end
if size(guitar,2) == 2
    guitar = mean(guitar,2);
end
if size(bass,2) == 2
    bass = mean(bass,2);
end

% Ajuster les longueurs
minLen = min([length(battement), length(guitar), length(bass)]);
battement = battement(1:minLen);
guitar = guitar(1:minLen);
bass = bass(1:minLen);
disp(['Amplitude moyenne battement : ', num2str(mean(abs(battement)))]);
disp(['Amplitude moyenne guitare   : ', num2str(mean(abs(guitar)))]);
disp(['Amplitude moyenne basse     : ', num2str(mean(abs(bass)))]);

% Amplifier la basse si trop faible
bass = bass * 5;   % essaie 2 ou 3 selon ton ressenti

% Fusion ?quilibr?e
mix = 0.8*battement + 1.0*guitar + 1.5*bass;
mix = mix / max(abs(mix));   % normalisation finale
t = (0:length(mix)-1) / fs;
plot(t, mix);
xlabel('Temps (s)');
ylabel('Amplitude');
title('Signal audio mix');


sound(mix, fs);
audiowrite('mix_final_boost.wav', mix, fs);

