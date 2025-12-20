[y, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\sunday.wav');
N = length(y);
% Get audio file info
info = audioinfo('C:\Users\Aya\Desktop\souds_Master\sunday.wav');
bits = info.BitsPerSample;

disp(['Sampling frequency (fs) = ', num2str(fs), ' Hz']);
disp(['Number of samples N     = ', num2str(N)]);
disp(['Quantization (bits)     = ', num2str(bits), ' bits']);
