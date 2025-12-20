import lzma

def lzma_compress(data):
    """Compress data using LZMA"""
    compressed = lzma.compress(data.encode('utf-8'))
    return compressed

def lzma_decompress(compressed):
    """Decompress LZMA data"""
    decompressed = lzma.decompress(compressed).decode('utf-8')
    return decompressed

def main():
    print("=== LZMA Compression ===\n")
    
    # User input
    text = input("Enter text (longer text gives better compression): ").strip()
    if not text:
        print("Error: empty text.")
        return
    
    print(f"\nOriginal text: {text[:100]}")  # Show first 100 chars
    if len(text) > 100:
        print(f"... (total {len(text)} characters)")
    print(f"Original size: {len(text)} bytes")
    
    # Compress
    try:
        compressed = lzma_compress(text)
        
        print(f"\nCompressed size: {len(compressed)} bytes")
        
        # Calculate compression ratio
        ratio = len(text) / len(compressed) if len(compressed) > 0 else 0
        print(f"Compression ratio: {ratio:.2f}:1")
        print(f"Space saved: {((len(text) - len(compressed)) / len(text) * 100):.1f}%")
        
        # Decompress to verify
        decompressed = lzma_decompress(compressed)
        print(f"\nCorrectly decompressed: {text == decompressed}")
        
        # Note about compression
        if len(text) < 100:
            print("\nNote: LZMA works best with longer texts (500+ characters)")
            print("Try entering a longer text for better compression results!")
        
    except Exception as e:
        print(f"Compression error: {e}")

if __name__ == "__main__":
    main()