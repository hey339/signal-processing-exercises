clc; clear; close all;

% ======== Données d'entrée ========
data = 'ABBCCCDDDDEEEEE';

% ======== Étape 1 : Calcul des fréquences ========
symbols = unique(data);
freq = histc(data, symbols);
prob = freq / sum(freq);

% ======== Étape 2 : Construction de l’arbre Huffman ========
nodes = cell(length(symbols), 2);
for i = 1:length(symbols)
    nodes{i,1} = symbols(i);
    nodes{i,2} = prob(i);
end

while size(nodes,1) > 1
    nodes = sortrows(nodes, 2);
    left = nodes(1,:);
    right = nodes(2,:);
    newNode = {struct('left', left, 'right', right), left{2} + right{2}};
    nodes(1:2,:) = [];
    nodes = [nodes; newNode];
end

tree = nodes{1,1};

% ======== Étape 3 : Génération des codes ========
codes = containers.Map('KeyType','char','ValueType','char');
generate_codes(tree, '', codes);

% ======== Étape 4 : Encodage ========
encoded = '';
for c = data
    encoded = [encoded codes(c)];
end

% ======== Étape 5 : Décodage ========
decoded = '';
node = tree;
for bit = encoded
    if bit == '0'
        node = node.left;
    else
        node = node.right;
    end
    if ischar(node{1})
        decoded = [decoded node{1}];
        node = tree;
    end
end

% ======== Résultats ========
disp('Table de codes Huffman :');
keys = codes.keys;
for i = 1:length(keys)
    fprintf('%s : %s\n', keys{i}, codes(keys{i}));
end

fprintf('\nTexte encodé : %s\n', encoded);
fprintf('Texte décodé : %s\n', decoded);

% ========== FONCTION À LA FIN ==========
function generate_codes(node, code, map)
    if ischar(node{1})
        map(node{1}) = code;
    else
        generate_codes(node{1}.left, [code '0'], map);
        generate_codes(node{1}.right, [code '1'], map);
    end
end

