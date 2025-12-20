clc; clear; close all;

%% --- 1?? Enregistrement audio ---
fs = 44100; % fréquence d'échantillonnage
nBits = 16; 
nChannels = 1;
duration = 5; % durée en secondes

recObj = audiorecorder(fs, nBits, nChannels);
disp('Parlez maintenant...');
recordblocking(recObj, duration);
disp('Fin de l''enregistrement');

% Récupérer le signal audio
y = getaudiodata(recObj);
audiowrite('speech.wav', y, fs);

%% --- 2?? STT simulé (saisie manuelle du texte) ---
prompt = 'Tapez le texte que vous vouliez dire : ';
recognizedText = input(prompt,'s');
disp(['Texte reconnu : ', recognizedText]);

%% --- 3?? TTS Windows SAPI ---
try
    speaker = actxserver('SAPI.SpVoice'); % objet COM Windows SAPI
    speaker.Speak(recognizedText);
    delete(speaker); % libérer ressource
catch
    disp('Erreur TTS : Windows SAPI non disponible.');
end
