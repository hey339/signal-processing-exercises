clc; clear; close all;

% CHARGER LE SIGNAL
[signal, Fs] = audioread('C:\Users\Aya\Documents\souds_Master\sunday.wav');
signal = signal(:,1);      % Mono
N = length(signal);
t = (0:N-1)/Fs;

%  CRÉATION D’UN WATERMARK 
freq_w = 100;            
alpha = 0.01;              
watermark = alpha * sin(2*pi*freq_w * t)';

%  AJOUT DU WATERMARK
signal_marked = signal + watermark;

% 4. LECTURE AUDIO
disp('Signal original ');
sound(signal, Fs);
pause(length(signal)/Fs + 1);

disp('Signal watermarking');
sound(signal_marked, Fs);
pause(length(signal_marked)/Fs + 1);

% 5. AFFICHAGE
figure;

subplot(3,1,1);
plot(signal);
title('"Signal ORIGINAL"');

subplot(3,1,2);
plot(signal_marked);
title('"Signal AVEC WATERMARK"');

subplot(3,1,3);
plot(signal_marked - signal);
title('"WATERMARK ajouté"');

