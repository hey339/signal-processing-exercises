x = -10:10;              
U = (x >= 0);           
V = exp(-0.3*abs(x));   

Y_add  = U + V;          % Addition
Y_mult = 0.6*U + 0.4*V;  % Combinaison linéaire
Y_trunc = U .* (abs(x)<=5); % Troncature
Y_rev = fliplr(U);       % Reverse

stem(x, Y_add); title('Addition');
figure, stem(x, Y_mult); title('Multiplication');
figure, stem(x, Y_trunc); title('Troncature');
figure, stem(x, Y_rev); title('Reverse');

