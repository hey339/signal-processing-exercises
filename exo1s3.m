
[guitar, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\guitar.wav');
[bass, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\bass.wav');
[battement, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\battement.wav');

duree_guitar = length(guitar)/fs;
duree_bass = length(bass)/fs;
duree_battement = length(battement)/fs;

disp(['Durée guitar = ', num2str(duree_guitar), ' s']);
disp(['Durée bass = ', num2str(duree_bass), ' s']);
disp(['Durée battement = ', num2str(duree_battement), ' s']);

% === Début et fin du segment ===
d = 0;     % début
f = 5;     % fin souhaitée

% === Ajustement pour ne pas dépasser la durée de chaque son ===
f_guitar = min(f, duree_guitar);
f_bass = min(f, duree_bass);
f_battement = min(f, duree_battement);

% === Extraction ===
guitar_seg = guitar(fs*d + 1 : fs*f_guitar, :);
bass_seg = bass(fs*d + 1 : fs*f_bass, :);
battement_seg = battement(fs*d + 1 : fs*f_battement, :);

% === Vérification tailles ===
disp(['Taille guitar : ', num2str(length(guitar_seg))]);
disp(['Taille bass : ', num2str(length(bass_seg))]);
disp(['Taille battement : ', num2str(length(battement_seg))]);

% === Vérif égalité ===
if isequal(length(guitar_seg), length(bass_seg), length(battement_seg))
    disp('? Les trois segments ont la même taille.');
else
    disp('?? Les tailles diffèrent. On aligne sur le plus petit segment.');

    % On tronque pour égaliser
    min_len = min([length(guitar_seg), length(bass_seg), length(battement_seg)]);
    guitar_seg = guitar_seg(1:min_len, :);
    bass_seg = bass_seg(1:min_len, :);
    battement_seg = battement_seg(1:min_len, :);
end

% === Axe temporel ===
t = (0:length(guitar_seg)-1)/fs;




% === Affichage ===
figure;
subplot(3,1,1);
plot(t, guitar_seg);
title('Guitar Segment');
xlabel('Temps (s)'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
plot(t, bass_seg);
title('Bass Segment');
xlabel('Temps (s)'); ylabel('Amplitude'); grid on;

subplot(3,1,3);
plot(t, battement_seg);
title('battements Segment');
xlabel('Temps (s)'); ylabel('Amplitude'); grid on;

