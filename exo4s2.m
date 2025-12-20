[x, Fs] =audioread('C:\Users\Aya\Desktop\souds_Master\sunday.wav'); 

% Reverse using fliplr (for row vectors)
x_row = x';           % convert to row vector if needed
x_rev_lr = fliplr(x_row);

% Reverse using flipud (for column vectors)
x_col = x;            % column vector
x_rev_ud = flipud(x_col);

% Play original and reversed signals
sound(x, Fs);           % original signal
pause(length(x)/Fs + 1)
sound(x_rev_lr, Fs);    % reversed signal using fliplr
pause(length(x_rev_lr)/Fs + 1)
sound(x_rev_ud, Fs);    % reversed signal using flipud