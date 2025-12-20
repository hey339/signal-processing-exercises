clc; clear; close all;

filename = 'C:\Users\Aya\Documents\test.txt';
fid = fopen(filename,'r');
txt = fscanf(fid,'%c');
fclose(fid);

disp('Original text:');
disp(txt);
disp(' ');

% Convert text to binary
txt_uint = uint8(txt);
txt_bin = de2bi(txt_uint,8,'left-msb')'; 
txt_bin = txt_bin(:);

% Pad bits to multiple of 4 for Hamming(7,4)
pad_len = 4 - mod(length(txt_bin),4);
if pad_len ~= 4
    txt_bin = [txt_bin; zeros(pad_len,1)];
else
    pad_len = 0;
end

% Reshape into 4-bit blocks
data_bits = reshape(txt_bin,4,[])';
n = size(data_bits,1);
disp(['Number of 4-bit data blocks: ' num2str(n)]);
disp(' ');

%% 3. Hamming(7,4) encoding
% Codeword structure: [p1 p2 d1 p3 d2 d3 d4]
encoded_bits = zeros(n,7);
for i=1:n
    d = data_bits(i,:);  % [d1 d2 d3 d4]
    p1 = mod(d(1)+d(2)+d(4),2);
    p2 = mod(d(1)+d(3)+d(4),2);
    p3 = mod(d(2)+d(3)+d(4),2);
    encoded_bits(i,:) = [p1 p2 d(1) p3 d(2) d(3) d(4)];
end

disp('Example - First codeword:');
disp(['Data bits: ' num2str(data_bits(1,:))]);
disp(['Encoded:   ' num2str(encoded_bits(1,:)) ' (7 bits with parity)']);
disp(' ');

% Introduce random errors (1 to 3 bits per codeword)
rx_bits = encoded_bits;
error_positions = [];
actual_bit_positions = {};  % cell array

for i = 1:n
    if rand < 0.15  % 15% chance to introduce errors
        num_errors = randi([1 3]); % 1 à 3 erreurs par codeword
        bits_to_flip = randperm(7, num_errors); % positions aléatoires
        rx_bits(i, bits_to_flip) = ~rx_bits(i, bits_to_flip);
        error_positions = [error_positions i];
        actual_bit_positions{end+1} = [i bits_to_flip];
    end
end

%Display text with errors
error_data_bits = zeros(n,4);
for i=1:n
    cw = rx_bits(i,:);
    error_data_bits(i,:) = [cw(3) cw(5) cw(6) cw(7)];
end
error_data_bits = error_data_bits';
error_data_bits = error_data_bits(:);
error_data_bits = error_data_bits(1:end-pad_len);
error_matrix = reshape(error_data_bits,8,[])';
error_text = char(bi2de(error_matrix,'left-msb'))';

disp('Text with random errors (before correction):');
disp(error_text);
disp(['Number of codewords with errors: ' num2str(length(error_positions))]);
disp(['Codewords with errors: ', num2str(error_positions)]);
disp(' ');


decoded_bits = zeros(n,7);
corrected_count = 0;

for i = 1:n
    cw = rx_bits(i,:);  % [p1 p2 d1 p3 d2 d3 d4]
    
    % Calculate syndrome
    s1 = mod(cw(1)+cw(3)+cw(5)+cw(7),2);
    s2 = mod(cw(2)+cw(3)+cw(6)+cw(7),2);
    s3 = mod(cw(4)+cw(5)+cw(6)+cw(7),2);
    syndrome = [s3 s2 s1];
    error_pos = s1*1 + s2*2 + s3*4;
    
    % DEBUG for first 5 codewords with errors
    if ismember(i,error_positions) && corrected_count < 5
        actual_flip = actual_bit_positions{find(error_positions==i)};
        disp(['--- Codeword #' num2str(i) ' ---']);
        disp(['Actual error positions: ' num2str(actual_flip(2:end))]);
        disp(['Original: ' num2str(encoded_bits(i,:))]);
        disp(['Received: ' num2str(rx_bits(i,:))]);
        disp(['Syndrome: [' num2str(syndrome) '] Detected position: ' num2str(error_pos)]);
    end
    
    % Correct 1 error if syndrome indicates
    if error_pos >= 1 && error_pos <= 7
        cw(error_pos) = ~cw(error_pos);  % corrige 1 bit
        if ismember(i,error_positions) && length(actual_bit_positions{find(error_positions==i)})>2
            disp(['Warning: multiple errors in codeword ', num2str(i), ' - only 1 corrected']);
        end
        
        % DEBUG
        if ismember(i,error_positions) && corrected_count < 5
            disp(['Corrected: ' num2str(cw)]);
            if isequal(cw, encoded_bits(i,:))
                disp('? SUCCESS - matches original!');
            else
                disp('? FAILED - does not match!');
            end
            disp(' ');
            corrected_count = corrected_count + 1;
        end
    end
    
    decoded_bits(i,:) = cw;
end

% Extract corrected data bits
final_data_bits = zeros(n,4);
for i=1:n
    cw = decoded_bits(i,:);
    final_data_bits(i,:) = [cw(3) cw(5) cw(6) cw(7)];
end
final_data_bits = final_data_bits';
final_data_bits = final_data_bits(:);
final_data_bits = final_data_bits(1:end-pad_len);
final_matrix = reshape(final_data_bits,8,[])';
decoded_text = char(bi2de(final_matrix,'left-msb'))';

disp('CORRECTED TEXT after Hamming(7,4):');
disp(decoded_text);
disp(' ');

%Compare with original
if strcmp(decoded_text, txt)
    disp('??? PERFECT! Decoded text matches original! ???');
else
    disp('? Warning: Decoded text differs from original');
    disp(['Original length: ' num2str(length(txt))]);
    disp(['Decoded length:  ' num2str(length(decoded_text))]);
end

%Statistics
disp(' ');
disp('STATISTICS:');
disp(['Total codewords: ' num2str(n)]);
disp(['Errors introduced: ' num2str(length(error_positions))]);
disp(['Error rate: ' num2str(length(error_positions)/n*100, '%.2f') '%']);
disp(['Overhead: 7 bits transmitted per 4 data bits (75% efficiency)']);

% Save corrected text
outputfile = 'C:\Users\Aya\Documents\decoded_text.txt';
fid = fopen(outputfile,'w');
fprintf(fid,'%s',decoded_text);
fclose(fid);
disp('Corrected text saved to: ');
disp(outputfile);
