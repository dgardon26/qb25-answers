#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1])
codons = fasta.FASTAReader(my_file)

for ident, sequence in codons:
    
    for i in range(0, len(sequence), 3):
        # print(ident)
        codon = sequence[i:i+3]
        # print(codon)