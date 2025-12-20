clear; clc; close all;

n = 100;                         % number of Fourier harmonics
x = linspace(-pi, pi, 2000);     % interval from -pi to pi
f = zeros(size(x));              % Fourier sum

for k = 1:n
    bn = 2*((-1)^(k+1)) / k;     % Fourier coefficient of odd function
    f = f + bn * sin(k * x);     % accumulate Fourier series
end

% Define the original function
orig = zeros(size(x));
orig(x >= 0) = x(x >= 0);
orig(x < 0)  = -x(x < 0);

% Plot ONLY final approximation + original function
plot(x, f, 'r', 'LineWidth', 2); hold on;


title('Fourier Series of f(t) = t and -t on [-\pi, \pi]');
xlabel('t'); ylabel('f(t)');
legend('Fourier approximation', 'Original f(t)', 'Location', 'best');
grid on;

