#!/usr/bin/env python3


import sys
import fasta

my_file = open(sys.argv[1]) # this is a pointer
contigs = fasta.FASTAReader(my_file) #fasta reader - give it the place to go look at

ident_count = 0
sequence_length = 0
contig_length_list = []

for ident, sequence in contigs: #same logic as for line in my_file, tells for loop to expect two items
    
    ident_count += 1
    part_length = len(sequence)
    sequence_length += part_length
    contig_length_list.append(part_length)

average_length = sequence_length / ident_count

contig_length_list.sort(reverse=True)

cumulative_length = 0
cumulative_length_list = []

for entry in contig_length_list:

    cumulative_length += entry
    cumulative_length_list.append(entry)
    
    if cumulative_length > (sequence_length/2):
        break

cumulative_length_list = sorted(cumulative_length_list)

print(f"Number of contigs: {ident_count}")
print(f"Total length: {sequence_length}")
print(f"Average length: {average_length}")
print(f"The sequence length of the shortest contig at 50% of the total assembly is: {cumulative_length_list[0]}")

 
# for line in my_file:
#     print(line)