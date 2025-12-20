import heapq
import math
from collections import Counter

# Node class for Huffman tree
class Node:
    def __init__(self, symbol=None, prob=0, left=None, right=None):
        self.symbol = symbol
        self.prob = prob
        self.left = left
        self.right = right
    
    def __lt__(self, other):
        return self.prob < other.prob

# Recursive code generation
def generate_codes(node, prefix="", codes=None):
    if codes is None:
        codes = {}
    if node.symbol is not None:
        codes[node.symbol] = prefix or "0"
    else:
        generate_codes(node.left, prefix + "0", codes)
        generate_codes(node.right, prefix + "1", codes)
    return codes

def main():
    print("===Huffman_Coding_from_Text===\n")
    
    # Read text
    texte = input("Enter_text:").strip()
    if not texte:
        print("Error: empty text.")
        return
    
    # Count frequencies
    freqs = Counter(texte)
    total = sum(freqs.values())
    probs = {sym: freq / total for sym, freq in freqs.items()}
    
    print("\n--- Frequencies and Probabilities ---")
    for sym, p in probs.items():
        print(f"'{sym}' : {p:.4f}")
    
    # Build priority queue
    heap = [Node(sym, p) for sym, p in probs.items()]
    heapq.heapify(heap)
    
    print("\n--- Building Tree ---")
    step = 1
    while len(heap) > 1:
        n1 = heapq.heappop(heap)
        n2 = heapq.heappop(heap)
        merged = Node(None, n1.prob + n2.prob, n1, n2)
        heapq.heappush(heap, merged)
        print(f"Step {step}: Combine ({n1.symbol or 'N'})[{n1.prob:.4f}] + ({n2.symbol or 'N'})[{n2.prob:.4f}] -> {merged.prob:.4f}")
        step += 1
    
    # Generate codes
    root = heap[0]
    codes = generate_codes(root)
    
    print("\n--- Generated Huffman Codes ---")
    print("{:<10} {:<15} {}".format("Symbol", "Probability", "Code"))
    print("-" * 40)
    for s, p in sorted(probs.items(), key=lambda x: x[1], reverse=True):
        print(f"{repr(s):<10} {p:<15.4f} {codes[s]}")
    
    # Calculate average length and entropy
    L_moy = sum([p * len(codes[s]) for s, p in probs.items()])
    H = -sum([p * math.log2(p) for p in probs.values()])
    
    print(f"\nAverage code length (L): {L_moy:.4f}")
    print(f"Entropy (H): {H:.4f} bits/symbol")
    
    # Encode text
    encoded = ''.join([codes[ch] for ch in texte])
    print(f"\nEncoded text: {encoded}")
    print(f"Total code length: {len(encoded)} bits")

if __name__ == "__main__":
    main()