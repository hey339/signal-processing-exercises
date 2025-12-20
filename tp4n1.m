[x, fs] =audioread('C:\Users\Aya\Desktop\souds_Master\sunday.wav');
x=x(:,1);
 ecch=[0;x(1:end-1)];
y1=0.5*(x+ecch);
y2=max(x,ecch);
t=(0:length(x)-1);

tmp=(1:length(x))/fs;

subplot(3,1,1);
plot(t,x)
title('auto');
grid on;
% sound( x);

subplot(3,1,2);
plot(t,y1)
title('auto');
grid on;
sound( y1);

subplot(3,1,3);
plot(t,y2)
title('auto');
grid on;