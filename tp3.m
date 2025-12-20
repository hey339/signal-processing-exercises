[y, fs] =audioread('C:\Users\Aya\Desktop\souds_Master\sunday.wav'); 
er=0.1*randn(size(y));
yn=y+er;
t = (0:length(yn)-1)/fs;
sound(yn,fs);
plot(t,yn);