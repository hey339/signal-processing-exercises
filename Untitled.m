[x1, Fs] = audioread('C:\Users\Aya\Desktop\souds_Master\compte.wav');
[x2, Fs] = audioread('C:\Users\Aya\Desktop\souds_Master\orage et pluie.wav');



if size(x1,2) > 1
    x1 = mean(x1, 2); 
end
if size(x2,2) > 1
    x2 = mean(x2, 2);
end

L1 = length(x1);
L2 = length(x2);
Lmax = max(L1, L2);

x1(L1+1:Lmax,:) = 0;
x2(L2+1:Lmax,:) = 0;


x_fusion = x1 + x2;


audiowrite('fusion.wav', x_fusion, Fs);

sound(x_fusion, Fs);