x = -pi:0.001:pi;             
u = sin(pi/4 * x);              
v = cos(pi/4 * x);              

noise_amp = 0.5;                 % amplitude du bruit (à varier)
noise_u = noise_amp * randn(size(x));
noise_v = noise_amp * randn(size(x));

u_noisy = u + noise_u;           % sin bruit
v_noisy = v + noise_v;           % cos avec bruit

% Affichage
figure;
subplot(2,1,1);
plot(x, u_noisy, 'r', 'LineWidth', 1.5);hold on;
plot(x, u, 'b', 'LineWidth', 1.5); 

xlabel('x'); ylabel('Amplitude');
legend('u(x) original','u(x) avec bruit');
title('Signal sinus bruité');
grid on;

subplot(2,1,2);
plot(x, v_noisy, 'r', 'LineWidth', 1.5);hold on;
plot(x, v, 'b', 'LineWidth', 1.5); 

xlabel('x'); ylabel('Amplitude');
legend('v(x) original','v(x) avec bruit');
title('Signal cosinus bruité');
grid on;
