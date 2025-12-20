def lz77_encode(data, window_size=20):
    """Simple LZ77 encoding"""
    i = 0
    output = []
    
    while i < len(data):
        match_length = 0
        match_distance = 0
        
        # Search for the longest match in the window
        for j in range(max(0, i - window_size), i):
            length = 0
            while (i + length < len(data) and 
                   data[j + length] == data[i + length]):
                length += 1
            
            if length > match_length:
                match_length = length
                match_distance = i - j
        
        # Output: (distance, length, next char)
        if match_length > 0:
            next_char = data[i + match_length] if i + match_length < len(data) else ''
            output.append((match_distance, match_length, next_char))
            i += match_length + 1
        else:
            output.append((0, 0, data[i]))
            i += 1
    
    return output

def main():
    print("=== LZ77 Compression ===\n")
    
    # User input
    text = input("Enter text: ").strip()
    if not text:
        print("Error: empty text.")
        return
    
    print(f"\nOriginal text: {text}")
    print(f"Original size: {len(text)} characters")
    
    # Compress
    compressed = lz77_encode(text)
    
    print("\n--- Compression Output ---")
    print("Format: (distance, length, next_char)")
    for i, token in enumerate(compressed):
        print(f"Token {i+1}: {token}")
    
    # Calculate size
    # Each token: distance (2 bytes) + length (1 byte) + char (1 byte) = 4 bytes
    compressed_size = len(compressed) * 4
    ratio = len(text) / compressed_size if compressed_size > 0 else 0
    
    print(f"\nNumber of tokens: {len(compressed)}")
    print(f"Estimated compressed size: {compressed_size} bytes")
    print(f"Compression ratio: {ratio:.2f}:1")

if __name__ == "__main__":
    main()