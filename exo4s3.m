
Ster_1 = [guitar, bass];                % Guitare à gauche, basse à droite
Ster_2 = [0.8*guitar, 0.2*bass];        % Guitare dominante, basse faible

sound(Ster_1, fs);
pause(6);
sound(Ster_2, fs);

figure;
subplot(2,1,1); plot(Ster_1(:,1)); title('Left Channel - Guitar');
subplot(2,1,2); plot(Ster_1(:,2)); title('Right Channel - Bass');
