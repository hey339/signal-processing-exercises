fs=44100;
fa=440;
fb=494;
fc=440;
t=0:1/fs:4;
y= sin(2*pi*fa*t);
z= sin(2*pi*fb*t);
h= sin(2*pi*fc*t);
o= 0.5*y+0.9*z+0.2*h;
% sound(y,fs);
sound(o,fs);
plot(t,o);
%exo3 tp1