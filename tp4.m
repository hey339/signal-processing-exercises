a=[1 1 1 1 1 1];
h=[1 -2 1 ];
convolution= conv(a,h);
autocorr= xcorr(a);

corr=conv(a,h);

subplot(3,1,1);
stem(convolution,'filled');
title('convolution de x avec x');
grid on;

subplot(3,1,2);
stem(autocorr,'filled');
title('auto');
grid on;

subplot(3,1,3);
stem(corr,'filled');
title('corr');
grid on;

disp(convolution);
disp(autocorr);
disp(corr);

