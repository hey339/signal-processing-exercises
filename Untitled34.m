% Charger le signal audio
[x, Fs] = audioread('Sunday.wav');

% Downsampling par 2
x_down = x(1:2:end);

% Upsampling par 2 (insertion de zéros)
x_up_zeros = zeros(2*length(x),1);
x_up_zeros(1:2:end) = x;

% Upsampling par 2 (répétition)
x_up_repeat = repelem(x,2);

% Écouter les signaux
sound(x, Fs);           % signal original
pause(length(x)/Fs + 1)
sound(x_down, Fs/2);    % signal downsamplé
pause(length(x_down)/(Fs/2) + 1)
sound(x_up_zeros, Fs);  % signal upsamplé avec zéros
pause(length(x_up_zeros)/Fs + 1)
sound(x_up_repeat, Fs); % signal upsamplé par répétition