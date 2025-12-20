clc; clear; close all;

% ----- Paramètres -----
A = 1;          % Amplitude
tau = pi/2;     % Demi-largeur du triangle
T = 2*pi;       % Période

% Axe temporel
t = linspace(-3*T, 3*T, 4000);

% ----- Signal triangulaire de base -----
x_single = A * (1 - abs(t)/tau) .* (abs(t) <= tau);

% ----- Signal périodique : somme des triangles -----
x_periodic = zeros(size(t));
for k = -3:3
    x_periodic = x_periodic + A * (1 - abs(t - k*T)/tau) .* (abs(t - k*T) <= tau);
end

% ----- Transformée de Fourier -----
N = length(t);
X = fftshift(fft(x_periodic));
f = linspace(-1/(2*(t(2)-t(1))), 1/(2*(t(2)-t(1))), N);

% ----- Affichage -----
figure;

subplot(2,1,1);
plot(t, x_periodic, 'LineWidth', 1.5);
xlabel('Temps (t)');
ylabel('x_3(t)');
title('Signal n°3 : train de triangles périodique');
grid on;

subplot(2,1,2);
plot(f, abs(X)/max(abs(X)), 'LineWidth', 1.5);
xlabel('Fréquence (Hz)');
ylabel('|X(f)| normalisé');
title('Spectre de Fourier du signal n°3');
grid on;
