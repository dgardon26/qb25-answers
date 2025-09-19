#!/usr/bin/env python3

import sys

my_sam_file = open(sys.argv[1])
sam_reads = {}
NM_count = {}

for line in my_sam_file:

    if line.startswith("@"):
        continue
    
    columns = line.split('\t')

    chromosome = columns[2]

    if chromosome not in sam_reads:
        sam_reads[chromosome] = 0
        sam_reads[chromosome] += 1
    
    else:
        sam_reads[chromosome] += 1


    for i in columns:

        if i.startswith("NM"):
        
            if int(i[5:]) not in NM_count:
                NM_count[int(i[5:])] = 0
                NM_count[int(i[5:])] += 1
        
            else:
                NM_count[int(i[5:])] += 1


for i in sam_reads:
    print(i + " " + str(sam_reads[i]))

sorted_NM_counts = sorted(NM_count.items())

for i in sorted_NM_counts:
    print(str(i[0]) + " " + str(i[1]))

