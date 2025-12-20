%% 1) Definition of x and original signals
x = -pi : 0.001 : pi;
U = sin((pi/4)*x);
V = cos((pi/4)*x);

%% 2) Addition of signals: Y(x) = U(x) + V(x)
Y_add = U + V;

figure;
plot(x, Y_add, 'LineWidth', 1.2); grid on;
title('Addition of Signals: Y(x) = U(x) + V(x)');
xlabel('x'); ylabel('Amplitude');

%% 3) Multiplication by coefficients: Y(x) = ?U(x) + ?V(x)
alpha = 0.6;
beta  = 0.4;
Y_lincomb = alpha * U + beta * V;

figure;
plot(x, Y_lincomb, 'LineWidth', 1.2); grid on;
title('Linear Combination: Y(x) = \alpha U(x) + \beta V(x)');
xlabel('x'); ylabel('Amplitude');

%% 4) Truncation using a rectangular window ?(x)
% Example: keep only x in [-1, 1]
window = double((x >= -1) & (x <= 1));
Y_trunc = U .* window;  % element-wise multiplication

figure;
plot(x, U, 'LineWidth', 1); hold on;
plot(x, Y_trunc, 'LineWidth', 2); grid on; hold off;
title('Signal Truncation: Y(x) = U(x) * \Pi(x)');
xlabel('x'); ylabel('Amplitude');
legend('Original U(x)', 'Truncated U(x)');

%% 5) Reverse Effect (time inversion): U(-x)
Y_reverse = fliplr(U);

figure;
plot(x, U, 'LineWidth', 1); hold on;
plot(x, Y_reverse, 'LineWidth', 2); grid on; hold off;
title('Reverse Effect: U(-x)');
xlabel('x'); ylabel('Amplitude');
legend('Original U(x)', 'Reversed U(-x)');