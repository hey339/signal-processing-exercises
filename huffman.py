import heapq
import math


class Node:
    def __init__(self, symbol=None, prob=0, left=None, right=None):
        self.symbol = symbol
        self.prob = prob
        self.left = left
        self.right = right

    def __lt__(self, other):
        return self.prob < other.prob  




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
    print("=== Génération des codes Huffman ===")

    
    n = int(input("Combien de symboles ? "))
    symbols = []
    probs = []

    for i in range(n):
        s = input(f"Symbole {i+1} : ")
        p = float(input(f"Probabilité de {s} : "))
        symbols.append(s)
        probs.append(p)

    #  création d’une file 
    heap = [Node(symbols[i], probs[i]) for i in range(n)]
    heapq.heapify(heap)

    print("\n--- Construction de l’arbre ---")
    step = 1
    while len(heap) > 1:
        n1 = heapq.heappop(heap)
        n2 = heapq.heappop(heap)
        merged = Node(None, n1.prob + n2.prob, n1, n2)
        heapq.heappush(heap, merged)
        print(f"Étape {step}: Combiner ({n1.symbol or 'N'})[{n1.prob}] + ({n2.symbol or 'N'})[{n2.prob}] → {merged.prob}")
        step += 1

    # code generation
    root = heap[0]
    codes = generate_codes(root)

    print("\n--- Codes Huffman générés ---")
    print("{:<10} {:<15} {}".format("Symbole", "Probabilité", "Code"))
    print("-" * 40)
    for s, p in sorted(zip(symbols, probs), key=lambda x: x[1], reverse=True):
        print(f"{s:<10} {p:<15} {codes[s]}")

    # verfication somme 
    print("\nSomme des probabilités :", sum(probs))

    #L_moy et H
    L_moy = sum([probs[i] * len(codes[symbols[i]]) for i in range(n)])
    H = -sum([probs[i] * math.log2(probs[i]) for i in range(n)])

    print(f"\nLongueur moyenne du code (L_moy) : {L_moy:.4f}")
    print(f"Entropie (H) : {H:.4f} bits/symbole")


if __name__ == "__main__":
    main()
