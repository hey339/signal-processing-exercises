import numpy as np

# ======= Fonctions Hamming =======

def hamming74_encode(data_bits):
    """Encode 4 bits of data into 7-bit Hamming (7,4)"""
    d = np.array(data_bits)
    # Matrice de génération (G)
    G = np.array([[1,1,0,1],
                  [1,0,1,1],
                  [1,0,0,0],
                  [0,1,1,1],
                  [0,1,0,0],
                  [0,0,1,0],
                  [0,0,0,1]])
    encoded = np.dot(G, d) % 2
    return encoded

def hamming74_decode(code_bits):
    """Decode 7-bit Hamming (7,4) code and correct single-bit errors"""
    r = np.array(code_bits)
    # Matrice de parité (H)
    H = np.array([[1,0,1,0,1,0,1],
                  [0,1,1,0,0,1,1],
                  [0,0,0,1,1,1,1]])
    syndrome = np.dot(H, r) % 2
    # Convert syndrome to integer
    error_pos = syndrome[0]*4 + syndrome[1]*2 + syndrome[2]*1
    if error_pos != 0:
        # Correction du bit en erreur
        r[error_pos-1] ^= 1
    # Extraire les bits de données
    data_bits = r[[2,4,5,6]]  # positions d0,d1,d2,d3
    return data_bits

# ======= Utilitaires =======

def text_to_bits(text):
    """Convert text to a list of bits"""
    bits = []
    for c in text:
        binval = format(ord(c), '08b')
        bits.extend([int(b) for b in binval])
    return bits

def bits_to_text(bits):
    """Convert list of bits to text"""
    chars = []
    for b in range(0, len(bits), 8):
        byte = bits[b:b+8]
        if len(byte) < 8:
            break
        chars.append(chr(int(''.join(map(str, byte)), 2)))
    return ''.join(chars)

# ======= Programme principal =======

texte = input("Enter your text: ")

# Convertir en binaire
bits = text_to_bits(texte)

# Padding pour diviser en blocs de 4 bits
if len(bits) % 4 != 0:
    padding = 4 - (len(bits) % 4)
    bits += [0]*padding

# Encodage
encoded_bits = []
for i in range(0, len(bits), 4):
    block = bits[i:i+4]
    encoded_bits.extend(hamming74_encode(block))

print("\nEncoded bits:")
print(encoded_bits)

# Simulation d'erreurs
taux_erreur = float(input("Error rate (0.01 = 1%, 0 = none): "))
received_bits = encoded_bits.copy()
if taux_erreur > 0:
    errors = np.random.rand(len(received_bits)) < taux_erreur
    for i, e in enumerate(errors):
        if e:
            received_bits[i] ^= 1
    print(f"Errors introduced: {sum(errors)}")

# Décodage
decoded_bits = []
for i in range(0, len(received_bits), 7):
    block = received_bits[i:i+7]
    decoded_bits.extend(hamming74_decode(block))

# Retirer le padding éventuel
decoded_bits = decoded_bits[:len(bits)]

# Conversion en texte
decoded_text = bits_to_text(decoded_bits)

print("\nOriginal text:", texte)
print("Decoded text: ", decoded_text)
