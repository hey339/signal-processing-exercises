

x = 1:10; 
Y1 = zeros(size(x));
Y2 = zeros(size(x));

% Compute Y1 and Y2 for the array
for n = 2:length(x)
    Y1(n) = 0.5 * (x(n) + x(n-1));
    Y2(n) = max(Y2(n-1), x(n) + x(n-1)); % running max
end

disp('Y1 for array:');
disp(Y1);
disp('Y2 (running max) for array:');
disp(Y2);

[y, fs] = audioread('C:\Users\Aya\Desktop\souds_Master\compte.wav'); 

% LTI system 1: simple averaging
Y1_voice = filter([0.5 0.5], 1, y);

% LTI system 2: running max
Y2_voice = zeros(size(y));
Y2_voice(1) = y(1);
for n = 2:length(y)
    Y2_voice(n) = max(Y2_voice(n-1), y(n) + y(n-1));
end

% Plot results
figure;
subplot(2,1,1); plot(Y1_voice); title(' Averaging LTI System');
subplot(2,1,2); plot(Y2_voice); title(' Running Max LTI System');
