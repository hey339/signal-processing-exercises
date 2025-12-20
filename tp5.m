x = [0 0 1 1 1 1 1 1 1 1 0 0];
h = [0.5 0.5];

y = conv(x, h); 
nx = 0:length(x)-1;  
ny = 0:length(y)-1;  

subplot(2,1,1);
stem(nx, x, 'filled'); 
title('Signal x[n]');
grid on;

subplot(2,1,2);
stem(ny, y, 'filled');  
title('Convolution y[n] = x[n] * h[n]');
grid on;
