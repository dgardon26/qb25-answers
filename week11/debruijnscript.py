#!/usr/bin/env python3


# Part 2 of the code

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
graph = set()
k = 3

for item in reads:
  for i in range(len(item) - k):
     kmer1 = item[i: i+k]
     kmer2 = item[i+1: i+1+k]
     graph.add(kmer1 + "->" + kmer2)

print("digraph T {")
for item in graph:
    print("    " + item + ";")
print("}")