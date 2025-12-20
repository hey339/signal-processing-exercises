def lz78_encode(data):
    """LZ78 encoding"""
    dictionary = {"": 0}
    dict_size = 1
    current = ""
    output = []
    
    for char in data:
        current_plus = current + char
        if current_plus in dictionary:
            current = current_plus
        else:
            output.append((dictionary[current], char))
            dictionary[current_plus] = dict_size
            dict_size += 1
            current = ""
    
    if current:
        output.append((dictionary[current], ""))
    
    return output, dictionary

def lz78_decode(encoded):
    """LZ78 decoding"""
    dictionary = {0: ""}
    dict_size = 1
    output = []
    
    for index, char in encoded:
        entry = dictionary[index] + char
        output.append(entry)
        dictionary[dict_size] = entry
        dict_size += 1
    
    return ''.join(output)

def main():
    print("=== LZ78 Compression ===\n")
    
    # User input
    text = input("Enter text: ").strip()
    if not text:
        print("Error: empty text.")
        return
    
    print(f"\nOriginal text: {text}")
    print(f"Original size: {len(text)} characters")
    
    # Encode
    encoded, dictionary = lz78_encode(text)
    
    print("\n--- Compression Output ---")
    print("Format: (dictionary_index, character)")
    for i, token in enumerate(encoded):
        print(f"Token {i+1}: {token}")
    
    print("\n--- Dictionary Built ---")
    sorted_dict = sorted(dictionary.items(), key=lambda x: x[1])
    for pattern, index in sorted_dict[:10]:  # Show first 10 entries
        print(f"Index {index}: '{pattern}'")
    if len(dictionary) > 10:
        print(f"... and {len(dictionary) - 10} more entries")
    
    # Decode
    decoded = lz78_decode(encoded)
    
    print(f"\nDecoded text: {decoded}")
    print(f"Correctly decoded: {text == decoded}")
    
    # Calculate compression
    compressed_size = len(encoded) * 2  # Simplified: 2 bytes per token
    ratio = len(text) / compressed_size if compressed_size > 0 else 0
    print(f"\nNumber of tokens: {len(encoded)}")
    print(f"Estimated compressed size: {compressed_size} bytes")
    print(f"Compression ratio: {ratio:.2f}:1")

if __name__ == "__main__":
    main()