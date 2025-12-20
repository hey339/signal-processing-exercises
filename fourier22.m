clc; clear; close all;
T = 2*pi;        
A = 1;            
t = linspace(-3*T, 3*T, 4000);  


x = zeros(size(t));
t_mod = mod(t + pi, T) - pi; 
x(t_mod >= 0) = t_mod(t_mod >= 0);

%  Fourier
N = length(t);
X = fftshift(fft(x));
f = linspace(-1/(2*(t(2)-t(1))), 1/(2*(t(2)-t(1))), N);

figure('Position', [100, 100, 1200, 600]);


subplot(2,1,1);
plot(t, x, 'r', 'LineWidth', 1.5);
xlabel('Temps (t)');
ylabel('f(t)');
title('Signal périodique : 0 pour t<0, t pour t>=0');
grid on;
xlim([-3*T 3*T]);







subplot(2,1,2);
plot(f, abs(X)/max(abs(X)), 'r', 'LineWidth', 1.5);
xlabel('Fréquence (Hz)');
ylabel('|X(f)| normalisé');
title('Spectre de Fourier du signal');
grid on;
xlim([-5 5]); 
