def lzw_encode(data):
    """LZW encoding"""
    # Initialize dictionary with single characters
    dictionary = {chr(i): i for i in range(256)}
    dict_size = 256
    
    current = ""
    output = []
    
    for char in data:
        current_plus = current + char
        if current_plus in dictionary:
            current = current_plus
        else:
            output.append(dictionary[current])
            dictionary[current_plus] = dict_size
            dict_size += 1
            current = char
    
    if current:
        output.append(dictionary[current])
    
    return output, dictionary

def lzw_decode(encoded):
    """LZW decoding"""
    # Initialize dictionary
    dictionary = {i: chr(i) for i in range(256)}
    dict_size = 256
    
    result = []
    current = chr(encoded[0])
    result.append(current)
    
    for code in encoded[1:]:
        if code in dictionary:
            entry = dictionary[code]
        elif code == dict_size:
            entry = current + current[0]
        else:
            raise ValueError("Bad compressed code")
        
        result.append(entry)
        dictionary[dict_size] = current + entry[0]
        dict_size += 1
        current = entry
    
    return ''.join(result)

def main():
    print("=== LZW Compression ===\n")
    
    # User input
    text = input("Enter text: ").strip()
    if not text:
        print("Error: empty text.")
        return
    
    print(f"\nOriginal text: {text}")
    print(f"Original size: {len(text)} characters ({len(text) * 8} bits)")
    
    # Encode
    encoded, dictionary = lzw_encode(text)
    
    print("\n--- Compression Output ---")
    print(f"Encoded indices: {encoded[:20]}")  # Show first 20
    if len(encoded) > 20:
        print(f"... and {len(encoded) - 20} more indices")
    
    print("\n--- Dictionary Sample (New Entries) ---")
    new_entries = [(k, v) for k, v in dictionary.items() if v >= 256]
    for pattern, index in sorted(new_entries, key=lambda x: x[1])[:10]:
        print(f"Index {index}: '{pattern}'")
    if len(new_entries) > 10:
        print(f"... and {len(new_entries) - 10} more entries")
    
    # Decode
    try:
        decoded = lzw_decode(encoded)
        print(f"\nDecoded text: {decoded[:50]}")  # Show first 50 chars
        if len(decoded) > 50:
            print(f"... (total {len(decoded)} characters)")
        print(f"Correctly decoded: {text == decoded}")
    except Exception as e:
        print(f"Decoding error: {e}")
    
    # Calculate compression
    # Assuming 12 bits per code
    compressed_bits = len(encoded) * 12
    original_bits = len(text) * 8
    ratio = original_bits / compressed_bits if compressed_bits > 0 else 0
    
    print(f"\nNumber of codes: {len(encoded)}")
    print(f"Compressed size: {compressed_bits} bits ({compressed_bits // 8} bytes)")
    print(f"Compression ratio: {ratio:.2f}:1")
    print(f"Space saved: {((original_bits - compressed_bits) / original_bits * 100):.1f}%")

if __name__ == "__main__":
    main()