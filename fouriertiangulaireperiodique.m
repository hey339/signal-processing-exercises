


T = 2*pi;         
t = linspace(-T, T, 2000);  
A = 1;             
tau = pi/2;        
x = sawtooth(2*pi*(1/T)*t, 0.5);   
x = A * (x + 1)/2;                

%  la Transformée de Fourier 
N = length(t);
X = fftshift(fft(x));
f = linspace(-1/(2*(t(2)-t(1))), 1/(2*(t(2)-t(1))), N);

% Affichage
figure;
subplot(2,1,1);
plot(t, x, 'LineWidth', 1.5);
xlabel('Temps (s)'); ylabel('x(t)');
title('Signal triangulaire périodique');
grid on;

subplot(2,1,2);
plot(f, abs(X)/max(abs(X)), 'LineWidth', 1.5);
xlabel('Fréquence (Hz)'); ylabel('|X(f)| normalisé');
title('Spectre de Fourier du signal triangulaire');
grid on;
