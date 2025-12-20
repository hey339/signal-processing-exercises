%% Voice Gender Detection - MATLAB
% Records 10 seconds of audio and detects male/female voice

clc; clear; close all;

%% Parameters
fs = 16000;           % Sampling rate
duration = 10;        % Recording duration (seconds)
threshold = 0.01;     % Energy threshold for voice activity
min_pitch = 50;       % Minimum pitch (Hz)
max_pitch = 300;      % Maximum pitch (Hz)

%% Record audio
recObj = audiorecorder(fs, 16, 1); % mono, 16-bit
disp('Recording 10 seconds... Speak now!');
recordblocking(recObj, duration);
audioData = getaudiodata(recObj);

%% Normalize audio
audioData = double(audioData);
audioData = audioData / max(abs(audioData));

%% Split into frames
frameLen = 4096;
numFrames = floor(length(audioData)/frameLen);
allFeatures = [];

for i = 1:numFrames
    frame = audioData((i-1)*frameLen + 1 : i*frameLen);
    
    % Voice activity detection
    if sum(abs(frame)) < threshold
        continue;
    end
    
    %% Pitch detection using autocorrelation
    corrVec = xcorr(frame);
    corrVec = corrVec(length(corrVec)/2:end);
    
    minLag = floor(fs/max_pitch);
    maxLag = floor(fs/min_pitch);
    corrWindow = corrVec(minLag:maxLag);
    
    if isempty(corrWindow)
        pitch = 0;
    else
        [~, peakIdx] = max(corrWindow);
        truePeriod = peakIdx + minLag - 1;
        pitch = fs / truePeriod;
    end
    
    %% Spectral features
    spectrum = abs(fft(frame));
    freqs = (0:length(spectrum)-1)*(fs/length(spectrum));
    
    spectral_centroid = sum(freqs .* spectrum') / (sum(spectrum)+1e-8);
    
    low_energy = sum(spectrum(freqs<300));
    mid_energy = sum(spectrum(freqs>=300 & freqs<3000));
    high_energy = sum(spectrum(freqs>=3000));
    
    allFeatures = [allFeatures; pitch, spectral_centroid, low_energy, mid_energy, high_energy];
end

%% Analyze and decide gender
male_votes = 0;
female_votes = 0;
total_pitch = 0;
pitch_count = 0;

for i = 1:size(allFeatures,1)
    pitch = allFeatures(i,1);
    spectral_centroid = allFeatures(i,2);
    low_energy = allFeatures(i,3);
    mid_energy = allFeatures(i,4);
    high_energy = allFeatures(i,5);
    
    if pitch < 50 || pitch > 400
        continue;
    end
    
    total_pitch = total_pitch + pitch;
    pitch_count = pitch_count + 1;
    
    male_score = 0;
    female_score = 0;
    
    % Pitch scoring
    if pitch >= 100 && pitch <= 150
        male_score = male_score + 5;
    elseif pitch > 150 && pitch < 200
        male_score = male_score + 2;
        female_score = female_score + 2;
    elseif pitch >= 200 && pitch <= 300
        female_score = female_score + 5;
    elseif pitch > 300
        female_score = female_score + 3;
    end
    
    % Spectral centroid
    if spectral_centroid < 1200
        male_score = male_score + 2;
    elseif spectral_centroid > 1800
        female_score = female_score + 2;
    else
        male_score = male_score + 1;
        female_score = female_score + 1;
    end
    
    % High frequency ratio
    high_ratio = high_energy / (mid_energy + 1e-8);
    if high_ratio > 0.3
        female_score = female_score + 1;
    else
        male_score = male_score + 1;
    end
    
    if male_score > female_score
        male_votes = male_votes + 1;
    elseif female_score > male_score
        female_votes = female_votes + 1;
    end
end

avg_pitch = total_pitch / max(pitch_count,1);

% Decision
if male_votes > female_votes
    gender = 'MALE';
    confidence = male_votes / (male_votes+female_votes) * 100;
elseif female_votes > male_votes
    gender = 'FEMALE';
    confidence = female_votes / (male_votes+female_votes) * 100;
else
    gender = 'UNCERTAIN';
    confidence = 50;
end

fprintf('\n========== FINAL RESULT ==========\n');
fprintf('Detected Gender: %s\n', gender);
fprintf('Confidence: %.1f%%\n', confidence);
fprintf('Average Pitch: %.1f Hz\n', avg_pitch);
if avg_pitch >= 100 && avg_pitch <= 150
    fprintf('Analysis: Typical male frequency (100-150 Hz)\n');
elseif avg_pitch >= 200 && avg_pitch <= 300
    fprintf('Analysis: Typical female frequency (200-300 Hz)\n');
elseif avg_pitch > 150 && avg_pitch < 200
    fprintf('Analysis: Transition zone (150-200 Hz)\n');
elseif avg_pitch < 100
    fprintf('Analysis: Very low frequency (<100 Hz)\n');
else
    fprintf('Analysis: Very high frequency (>300 Hz)\n');
end
fprintf('==================================\n');
