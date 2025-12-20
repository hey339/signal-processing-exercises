t = linspace(-pi, pi, 1200);
f = abs(t);

N = 80;
S = pi/2 * ones(size(t));

figure; hold on;
for n = 1:N
    an = 2*((-1)^n - 1)/(pi*n^2);
    term = an*cos(n*t);
    plot(t, term, 'Color', [0.5 0.5 0.5 0.25], 'LineWidth', 0.8);
    S = S + term;
end
plot(t, S, 'r', 'LineWidth', 1.6);
plot(t, f, 'k', 'LineWidth', 1.2);
grid on;
title('Exercise 3A: f(t)=|t| (even)');