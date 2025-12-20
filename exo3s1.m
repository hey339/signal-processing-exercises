Fe = 44100;                     
t = 0:1/Fe:2;        
f0 = 400;
f1 = 500;
f2 = 1000;
% Construction du signal complexe
x = sin(2*pi*f0*t) + 0.7*sin(2*pi*f1*t) + 0.7*sin(2*pi*f2*t);
sound(x, Fe); 

plot(x,t);