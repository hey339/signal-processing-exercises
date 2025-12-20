
[guitar, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\guitar.wav');
[bass, ~] = audioread('C:\Users\Aya\Desktop\souds_Master\bass.wav');
[battement, ~] = audioread('C:\Users\Aya\Desktop\souds_Master\battement.wav');

min_len = min([length(guitar), length(bass), length(battement)]);
guitar = guitar(1:min_len, :);
bass = bass(1:min_len, :);
battement = battement(1:min_len, :);

ramp = linspace(0, 1, min_len)';
ramped_guitar = guitar .* ramp;

% === Écoute du son avec effet fade-in ===
sound(ramped_guitar, fs);
pause(6);

% === Visualisation ===
figure;
subplot(2,1,1); plot(guitar); title('Original Guitar Signal');
subplot(2,1,2); plot(ramped_guitar); title('Ramp-Multiplied Guitar (Fade-in Effect)');

% === Fusion avec les autres sons ===
merged = ramped_guitar + bass + battement;
pause(6);
sound(merged, fs);
