#!/usr/bin/env python3

import sys
import fasta

import codons

# print(codons.forward)


aas = {}

my_file = open(sys.argv[1])
codons_reader = fasta.FASTAReader(my_file)

for ident, sequence in codons_reader:
    
    for i in range(0, len(sequence), 3):
        # print(ident)
        codon = sequence[i:i+3]
        # print(codon)

        current_aa = codons.forward.get(codon)
        

        if codon not in aas.keys():
            aas.setdefault(current_aa, 0)
            aas[current_aa] += 1
        
        else: 
            aas[current_aa] += 1

print(aas)