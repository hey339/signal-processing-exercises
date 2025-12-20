% Charger le fichier audio
[x, Fs] = audioread('C:\Users\Aya\Desktop\souds_Master\sunday.wav');

h = [0.5 0.5];


y = filter(h, 1, x);  

sound(y, Fs);


t = (0:length(x)-1)/Fs;  
t_y = (0:length(y)-1)/Fs;  

figure;
subplot(2,1,1);
plot(t, x);
title('Signal original');
xlabel('Temps (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t_y, y);
title('filter');
xlabel('Temps (s)');
ylabel('Amplitude');
grid on;
