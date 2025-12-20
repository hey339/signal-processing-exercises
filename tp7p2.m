clear; clc; close all;

% Define time range
t = linspace(-pi, pi, 1000);
T = 2*pi;
N = 20; % number of harmonics

% Initialize signal
f_approx = zeros(size(t));

figure;
hold on;

% DC term (a0/2)
a0 = pi/2;
f_approx = f_approx + a0/2;

% Build the series term by term
for n = 1:N
    % Fourier coefficients
    if mod(n,2) == 0
        a_n = 0;
    else
        a_n = -2/(n^2*pi);
    end
    b_n = ((-1)^(n+1))/n;

    % nth harmonic
    v = a_n*cos(n*t) + b_n*sin(n*t);
    f_approx = f_approx + v;

    % Plot each harmonic component
    plot(t, v, 'Color', [0.7 0.7 0.7]); % gray individual harmonic
end

% Plot the final approximation
plot(t, f_approx, 'r', 'LineWidth', 2);
title(['Fourier Series Construction of f(t) = 0 for t<0, f(t)=t for t>0, N=', num2str(N)]);
xlabel('t');
ylabel('f(t)');
grid on;
legend('Harmonic components', 'Final sum');