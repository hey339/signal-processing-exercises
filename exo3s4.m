x1 = [1 -2 1];
x2 = ones(1,6); % 1 for 0<=n<=5
y_conv = conv(x1, x2);
disp(y_conv);% Define sequences
x1 = [1 -2 1];
x2 = ones(1,6); 
y_conv = conv(x1, x2);
disp('Convolution result:');
disp(y_conv);
figure;
stem(y_conv);
title('Convolution x1(n) * x2(n)');
xlabel('n'); ylabel('y[n]');