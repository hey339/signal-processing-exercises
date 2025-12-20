t = linspace(-pi, pi, 2000);
f = ones(size(t));
f(t <= 0) = -1;
N = 50;
S = zeros(size(t));

figure; hold on;
title('Fourier Series Reconstruction of the Square Wave');
grid on;

for n = 1:N
    if mod(n, 2) == 0
        continue;
    end
    
    bn = 4 / (pi * n);
    term = bn * sin(n * t);
    
    % plot each harmonic in light gray
    plot(t, term, 'Color', [0.5 0.5 0.5 0.3], 'LineWidth', 0.8);
    
    S = S + term;
end

plot(t, S, 'r', 'LineWidth', 1.8);
plot(t, f, 'k', 'LineWidth', 1.4);
ylim([-2 2]);
legend('Reconstructed S(t)', 'Original f(t)');
