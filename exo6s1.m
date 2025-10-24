Fs = 8000;                
t = 0:1/Fs:0.5;  
F(1) = 440;
for n = 2:12
    F(n) = F(n-1) * 2^(1/12);
end
% Génération et lecture de chaque note
for n = 1:12
    y = sin(2*pi*F(n)*t);  
    sound(y, Fs);           
    pause(duree);           
end
