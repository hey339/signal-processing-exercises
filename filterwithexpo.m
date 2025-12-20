[x, Fs] = audioread('C:\Users\Aya\Desktop\souds_Master\sunday.wav');
x = x(:);  
N = length(x);


h = [0.5 0.5];
M = length(h);


y = zeros(N,1);


for n = 1:N
    for k = 1:M
        if n-k+1 > 0
            y(n) = y(n) + h(k)*x(n-k+1);
        end
    end
end

% Alternative avec représentation complexe
% h = 0.5 + 0.5 * e^(j*theta), ici theta = pi/2 par exemple
theta = pi/2;
h_complex = 0.5 + 0.5 * exp(1j*theta);

y_complex = zeros(N,1);
for n = 1:N
    if n > 1
        y_complex(n) = h_complex * x(n-1) + h_complex * x(n);
    else
        y_complex(n) = h_complex * x(n);
    end
end

% Jouer le signal filtré réel
sound(real(y_complex), Fs);

% Affichage
t = (0:N-1)/Fs;
figure;
subplot(2,1,1);
plot(t, x);
title('Signal original');
grid on;

subplot(2,1,2);
plot(t, real(y_complex));
title('Signal filtré avec e^{j?}');
grid on;
