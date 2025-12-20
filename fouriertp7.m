n = 50;
x = 0:0.01:2*pi;
f = zeros(size(x));

figure; hold on;

for i = 0:n
    v = (4/pi) * sin((2*i+1)*x) / (2*i+1);
    f = f + v;
    plot(x,v,'Color',[0.8 0.8 0.8]); 
end

plot(x,f,'r','LineWidth',2) 
title('Fourier Series Convergence')
grid on;