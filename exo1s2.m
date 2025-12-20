files = {...
    'C:\Users\Aya\Desktop\souds_Master\sunday.wav', ...
    'C:\Users\Aya\Desktop\souds_Master\orage et pluie.wav', ...
    'C:\Users\Aya\Desktop\souds_Master\battement.wav', ...
    'C:\Users\Aya\Desktop\souds_Master\bass.wav'};

for k = 1:length(files)
    [y, fs] = audioread(files{k});
    y = y(1:5000);  % pour garder le plot lisible
    time = (1:length(y))/fs;
    subplot(2,2,k);
    plot(time, y, 'LineWidth', 1.2);
    [~, name, ext] = fileparts(files{k});
    title(name);
    xlabel('Temps [s]');
    ylabel('Amplitude');
    grid on;
end
