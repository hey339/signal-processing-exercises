t = linspace(-pi, pi, 2000);
f_abs = abs(t);           % original even function
a0 = pi;
S_abs = a0/2 * ones(size(t));
N = 80;                   % number of harmonics

figure; hold on;
for n = 1:N
    if mod(n,2)==0
        an = 0;
    else
        an = -4/(pi * n^2);    % n odd
    end
    S_abs = S_abs + an*cos(n*t);
    % optional: plot each cosine term:
    % plot(t, an*cos(n*t), 'Color', [0.5 0.5 0.5 0.2]);
end
plot(t, S_abs, 'r', 'LineWidth', 1.6);
plot(t, f_abs, 'k', 'LineWidth', 1.2);
title('|t| : Fourier reconstruction'); grid on; legend('Reconstruction','Original');

% Reconstruction of g(t)=t
S_t = zeros(size(t));
for n = 1:N
    bn = 2 * (-1)^(n+1) / n;
    S_t = S_t + bn * sin(n*t);
    % optional: plot each sine term:
    % plot(t, bn*sin(n*t), 'Color', [0.5 0.5 0.5 0.2]);
end
figure; hold on;
plot(t, S_t, 'r', 'LineWidth', 1.6);
plot(t, t, 'k', 'LineWidth', 1.2);
title('t : Fourier reconstruction'); grid on; legend('Reconstruction','Original');