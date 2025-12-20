x = -10:10;              
U = (x >= 0);           
V = exp(-0.3*abs(x));   

Y_add  = U + V;          % Addition
Y_mult = 0.6*U + 0.4*V;  
Y_trunc = U .* (abs(x)<=5); % Troncature
Y_rev = fliplr(U);       % Reverse

figure;  
subplot(2,2,1)
stem(x, Y_add)
title('Addition')

subplot(2,2,2)
stem(x, Y_mult)
title('Multiplication')

subplot(2,2,3)
stem(x, Y_trunc)
title('Troncature')

subplot(2,2,4)
stem(x, Y_rev)
title('Reverse')

