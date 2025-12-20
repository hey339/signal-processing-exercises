% Lire les deux fichiers audio
[y, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\compte.wav');
[y1, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\orage et pluie.wav');

minLen = min(length(y), length(y1));
y = y(1:minLen, :);
y1 = y1(1:minLen, :);


if size(y,2) ~= size(y1,2)
    if size(y,2) == 1
        y = [y y];
    elseif size(y1,2) == 1
        y1 = [y1 y1];
    end
end

mix = y + 0.3 * y1;

mix = mix / max(abs(mix(:)));


sound(mix, fs);


audiowrite('C:\Users\Aya\Desktop\souds_Master\compte_pluie.wav', mix, fs);
