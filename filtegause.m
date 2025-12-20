clear; clc; close all;


[audio, Fs] = audioread('C:\Users\Aya\Documents\souds_Master\sunday.wav');  


audio = audio(:,1);                   
N = length(audio);
t = (0:N-1)/Fs;

X = fft(audio);
X_shift = fftshift(X);
f_shift = linspace(-Fs/2, Fs/2, N);

LOW_MAX  = 300;
MED_MIN  = 300;
MED_MAX  = 2000;
HIGH_MIN = 3000;  

LF_mask = abs(f_shift) <= LOW_MAX;
MF_mask = (abs(f_shift) >= MED_MIN) & (abs(f_shift) <= MED_MAX);
HF_mask = abs(f_shift) >= HIGH_MIN;




X_low_shift  = X_shift .* LF_mask.';
X_med_shift  = X_shift .* MF_mask.';
X_high_shift = X_shift .* HF_mask.';




X_low  = ifftshift(X_low_shift);
X_med  = ifftshift(X_med_shift);
X_high = ifftshift(X_high_shift);

%% --- IFFT ---
low_signal  = real(ifft(X_low));
med_signal  = real(ifft(X_med));
high_signal = real(ifft(X_high));


low_signal  = low_signal  / max(abs(low_signal));
med_signal  = med_signal  / max(abs(med_signal));
high_signal = high_signal / max(abs(high_signal)) * 3; % boost high for audibility

figure;
subplot(4,1,1);
plot(f_shift, abs(X_shift));
title('Full Spectrum (FFT)');
xlabel('Frequency (Hz)');

subplot(4,1,2);
plot(f_shift, abs(X_low_shift));
title('Low Frequencies (0–300 Hz)');

subplot(4,1,3);
plot(f_shift, abs(X_med_shift));
title('Medium Frequencies (300–3000 Hz)');

subplot(4,1,4);
plot(f_shift, abs(X_high_shift));
title('High Frequencies (>2000 Hz)');
xlabel('Frequency (Hz)');

figure;
subplot(3,1,1);
plot(t, low_signal);
title('Low Frequency Signal (time domain)');

subplot(3,1,2);
plot(t, med_signal);
title('Medium Frequency Signal (time domain)');

subplot(3,1,3);
plot(t, high_signal);
title('High Frequency Signal (time domain)');
xlabel('Time (s)');










disp('"Playing LOW frequencies..."');
soundsc(low_signal, Fs);
pause(length(low_signal)/Fs + 1);

disp('"Playing MEDIUM frequencies..."');
soundsc(med_signal, Fs);
pause(length(med_signal)/Fs + 1);

disp('"Playing HIGH frequencies..."');
soundsc(high_signal, Fs);
pause(length(high_signal)/Fs + 1);