clear; clc;

fprintf('================================================\n');
fprintf('   ENCODEUR/DECODEUR HAMMING \n');
fprintf('================================================\n\n');

if ~license('test', 'Communication_Toolbox')
    warning('Communications Toolbox non disponible!');
    return;
end

m = 3;
n = 2^m - 1;
k = n - m;

fprintf('Code Hamming (%d,%d)\n\n', n, k);

%% SAISIE DU TEXTE
texte = input('Entrez votre texte: ', 's');

if isempty(texte)
    error('Texte vide!');
end

fprintf('\n--- TEXTE ORIGINAL ---\n');
fprintf('"%s"\n', texte);
fprintf('Longueur: %d caracteres\n\n', length(texte));

%% CONVERSION EN BINAIRE
binaire = dec2bin(double(texte), 8);
binaire = binaire';
binaire_vecteur = str2num(binaire(:))';

fprintf('--- REPRESENTATION BINAIRE ---\n');
fprintf('%s\n', num2str(binaire_vecteur));
fprintf('Total: %d bits\n\n', length(binaire_vecteur));

%% PADDING
reste = mod(length(binaire_vecteur), k);
if reste ~= 0
    padding = k - reste;
    binaire_vecteur = [binaire_vecteur zeros(1, padding)];
    fprintf('Padding: +%d bits\n\n', padding);
end

%% ENCODAGE
nBlocs = length(binaire_vecteur) / k;
dataBlocs = reshape(binaire_vecteur, k, nBlocs)';

fprintf('--- ENCODAGE HAMMING ---\n');
encodedBlocs = encode(dataBlocs, n, k, 'hamming/binary');
encoded_vecteur = reshape(encodedBlocs', 1, []);

fprintf('Blocs encodes: %d\n', nBlocs);
fprintf('Bits originaux: %d\n', length(binaire_vecteur));
fprintf('Bits encodes: %d\n', length(encoded_vecteur));
fprintf('Redondance: %.1f%%\n\n', 100*(length(encoded_vecteur)-length(binaire_vecteur))/length(binaire_vecteur));

fprintf('--- MESSAGE ENCODE ---\n');
fprintf('%s\n\n', num2str(encoded_vecteur));

% SIMULATION D'ERREUR
fprintf('--- SIMULATION D''ERREURS ---\n');
tauxErreur = input('Taux d''erreur (0.01 = 1%%, 0 = aucune): ');

if isempty(tauxErreur)
    tauxErreur = 0;
end

received = encoded_vecteur;
if tauxErreur > 0
    erreurs = rand(1, length(encoded_vecteur)) < tauxErreur;
    received(erreurs) = ~received(erreurs);
    nErreurs = sum(erreurs);
    fprintf('Erreurs introduites: %d (%.2f%%)\n', nErreurs, 100*nErreurs/length(encoded_vecteur));
    if nErreurs > 0
        fprintf('Positions: %s\n', mat2str(find(erreurs)));
    end
else
    fprintf('Aucune erreur introduite\n');
end
fprintf('\n');

% DECODAGE
fprintf('--- DECODAGE ---\n');
receivedBlocs = reshape(received, n, nBlocs)';
decodedBlocs = decode(receivedBlocs, n, k, 'hamming/binary');
decoded_vecteur = reshape(decodedBlocs', 1, []);

fprintf('Decodage termine!\n\n');

% CONVERSION EN TEXTE
nBytes = floor(length(decoded_vecteur) / 8);
decoded_vecteur = decoded_vecteur(1:nBytes*8);
bytes_matrix = reshape(decoded_vecteur, 8, nBytes)';
texte_decode = '';

for i = 1:nBytes
    valeur = bin2dec(num2str(bytes_matrix(i, :)));
    if valeur > 0
        texte_decode = [texte_decode char(valeur)];
    end
end

% RESULTATS
fprintf('--- RESULTATS ---\n');
fprintf('Texte original: "%s"\n', texte);
fprintf('Texte decode:   "%s"\n\n', texte_decode);

if strcmp(texte, texte_decode)
    fprintf('SUCCESS! Le texte est identique!\n');
else
    fprintf('ATTENTION! Le texte differe!\n');
end

if tauxErreur > 0
    [nBitErrors, ber] = biterr(binaire_vecteur(1:length(decoded_vecteur)), decoded_vecteur);
    fprintf('\nErreurs residuelles: %d bits\n', nBitErrors);
    fprintf('BER final: %.6f\n', ber);
end

fprintf('\n================================================\n');