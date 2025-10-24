
n = -20:20;  % axe discret
dirac_pulse = (n == 0);


step_signal = (n >= 0);

window_signal = (abs(n) <= 5);

gaussian_signal = exp(-(n.^2)/(2*5^2));


figure;
subplot(2,2,1); stem(n, dirac_pulse, 'filled'); title('Dirac');
subplot(2,2,2); stem(n, step_signal, 'filled'); title('Step');
subplot(2,2,3); stem(n, window_signal, 'filled'); title('Window');
subplot(2,2,4); stem(n, gaussian_signal, 'filled'); title('Gaussian');

