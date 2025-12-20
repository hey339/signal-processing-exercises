
[y, Fs] = audioread('C:\Users\Aya\Documents\souds_Master\sunday.wav');
y = y(:,1); % mono
N = length(y);
t = (0:N-1)/Fs;


Y = fft(y);
f = (0:N-1)*(Fs/N);

% Plot comparison
figure;

plot(t, y, 'b'); hold on;
plot(t, y_BF, 'r'); 
title('Basic Frequency Compression'); xlabel('Time [s]'); ylabel('Amplitude');
legend('Original','Compressed');


