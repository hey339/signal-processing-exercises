x = [1 2 3 1];
h = [1 2 1 -1];
y = conv(x, h);
disp('Output of convolution:');
disp(y);
figure;
stem(y);
title('Convolution x(n) * h(n)');
xlabel('n'); ylabel('y[n]');