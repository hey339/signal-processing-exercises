signal1 = [1 2 3 4 5 4 3 2 1];
signal2 = [2 3 4 5 4 3 2 1 0];
% Auto-correlation
auto = xcorr(signal1, signal1);
% Cross-correlation
cross = xcorr(signal1, signal2);

figure;
n = -length(signal1)+1:length(signal1)-1; % lags for plotting
plot(n, auto, 'b', 'LineWidth', 1.5);
hold on;
plot(n, cross, 'r--', 'LineWidth', 1.5);
hold off;
title('Auto-correlation(blue)vsCross-correlation(red)');
xlabel('Lag');
ylabel('Amplitude');
legend('Auto-correlation','Cross-correlation');
grid on;
