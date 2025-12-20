%dctmtx(4)
%x=[0 1 2 3]

%Y = fft(x)
%z=ifft(y)
%hadamard(4)
clc; clear; close all;
T = 2*pi;        
A = 1;            
t = linspace(-3*T, 3*T, 4000);  

% 0 t<0, t pour t>=0
x = zeros(size(t));
t_mod = mod(t + pi, T) - pi; 
x(t_mod >= 0) = t_mod(t_mod >= 0);

N = length(t);
dt = t(2) - t(1);
f = linspace(-1/(2*dt), 1/(2*dt), N);

% 1
X_fft = fftshift(fft(x));
x_fft_rec = ifft(ifftshift(X_fft));

% 2
X_realOnly = real(X_fft);       
x_realOnly = ifft(ifftshift(X_realOnly));

N_h = 2^nextpow2(N);
x_pad = [x, zeros(1, N_h - N)];  
H = hadamard(N_h);                
X_hadamard = H * x_pad.';         
x_hadamard_inv = (H' * X_hadamard) / N_h;  


figure('Position', [100, 100, 1200, 800]);

subplot(4,1,1);
plot(t, x, 'r', 'LineWidth', 1.5);
xlabel('Temps (t)'); ylabel('f(t)');
title('Signal original'); grid on;

subplot(4,1,2);
plot(t, real(x_fft_rec), 'b', 'LineWidth', 1.5);
xlabel('Temps (t)'); ylabel('Amplitude');
title('Reconstruction via FFT classique'); grid on;

subplot(4,1,3);
plot(t, real(x_realOnly), 'g', 'LineWidth', 1.5);
xlabel('Temps (t)'); ylabel('Amplitude');
title(' Omar Khayyam'); grid on;

subplot(4,1,4);
plot(linspace(-3*T, 3*T, N_h), x_hadamard_inv, 'm', 'LineWidth', 1.5);
xlabel('Temps (t)'); ylabel('Amplitude');
title(' Hadamard'); grid on;

