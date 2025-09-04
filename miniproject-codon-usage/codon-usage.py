#!/usr/bin/env python3

import sys
import fasta

import codons

# print(codons.forward)


aas1 = {}
aas2 = {}

my_file = open(sys.argv[1])
my_file2 = open(sys.argv[2])
codons_reader = fasta.FASTAReader(my_file)
codons2_reader = fasta.FASTAReader(my_file2)

for ident, sequence in codons_reader:
    
    for i in range(0, len(sequence), 3):
        # print(ident)
        codon = sequence[i:i+3]
        # print(codon)

        current_aa = codons.forward.get(codon)
        

        if codon not in aas1.keys():
            aas1.setdefault(current_aa, 0)
            aas1[current_aa] += 1
        
        else: 
            aas1[current_aa] += 1



for ident, sequence in codons2_reader:

    for i in range(0, len(sequence), 3):
        codon = sequence[i:i+3]

        current_aa2 = codons.forward.get(codon)

        if codon not in aas2.keys():
            aas2.setdefault(current_aa2, 0)
            aas2[current_aa2] += 1

        else: 
            aas2[current_aa2] += 1

table_list = list(codons.reverse.keys())
table_list.sort()
print(table_list)

for letter in table_list:
    count1 = aas1.get(letter)
    count2 = aas2.get(letter)
    print(f"{letter}\t{count1}\t{count2}")