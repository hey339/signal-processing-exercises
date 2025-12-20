t = linspace(-pi, pi, 2000);
f = zeros(size(t));
f(t>0 & t<=pi) = t(t>0 & t<=pi);

a0 = pi/2;
S = a0/2 * ones(size(t));
N = 50;

figure; hold on;
for n = 1:N
    an = ((-1)^n - 1)/(pi * n^2);
    bn = (-1)^(n+1)/n;
    term = an*cos(n*t) + bn*sin(n*t);
    plot(t, term, 'Color', [0.5 0.5 0.5 0.25], 'LineWidth', 0.8);
    S = S + term;
end

plot(t, S, 'r', 'LineWidth', 1.8);
plot(t, f, 'k', 'LineWidth', 1.4);
grid on;
title('Fourier Reconstruction with Visualization of Harmonics');