#!/usr/bin/env python3

import sys
import fasta
import codons

my_file = open(sys.argv[1])
my_residue = sys.argv[2]
codon_reader = fasta.FASTAReader(my_file)

counts = {}

for ident, sequence in codon_reader:
    
    for i in range(0, len(sequence), 3):

        current_codon = sequence[i:i+3]

        if current_codon not in counts:
            counts.setdefault(current_codon, 0)
            counts[current_codon] += 1
        
        else: 
            counts[current_codon] += 1


list_of_codons = codons.reverse.get(my_residue)
final_residue_value = 0

for entry in list_of_codons:
    
    if entry not in counts:
        continue

    else: 

        value = counts[entry]
        print(f"{entry}\t{value}")




