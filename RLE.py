def run_length_encode(data):
    """Compress data using Run-Length Encoding"""
    if not data:
        return ""
    
    encoded = []
    count = 1
    current = data[0]
    
    for i in range(1, len(data)):
        if data[i] == current:
            count += 1
        else:
            encoded.append(f"{count}{current}")
            current = data[i]
            count = 1
    
    # Add the last run
    encoded.append(f"{count}{current}")
    return ''.join(encoded)

def run_length_decode(encoded):
    """Decompress RLE encoded data"""
    decoded = []
    i = 0
    
    while i < len(encoded):
        # Read the count
        count = ""
        while i < len(encoded) and encoded[i].isdigit():
            count += encoded[i]
            i += 1
        
        # Read the character
        if i < len(encoded):
            char = encoded[i]
            decoded.append(char * int(count))
            i += 1
    
    return ''.join(decoded)

def main():
    print("=== Run-Length Encoding (RLE) ===\n")
    
    # User input
    text = input("Enter text: ").strip()
    if not text:
        print("Error: empty text.")
        return
    
    print(f"\nOriginal text: {text}")
    print(f"Original size: {len(text)} characters")
    
    # Encode
    encoded = run_length_encode(text)
    print(f"\nEncoded: {encoded}")
    print(f"Compressed size: {len(encoded)} characters")
    
    # Calculate compression ratio
    if len(encoded) > 0:
        ratio = len(text) / len(encoded)
        print(f"Compression ratio: {ratio:.2f}:1")
        if ratio < 1:#ratio permet de savoir si on a compressé ou pas
            print("Warning: Data expanded instead of compressed!")
    
    # Decode to verify
    decoded = run_length_decode(encoded)
    print(f"\nDecoded: {decoded}")
    print(f"Correctly decoded: {text == decoded}")

if __name__ == "__main__":
    main()