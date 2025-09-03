#!/usr/bin/env python3

import sys 

gene_data = open(sys.argv[1])

new_score_list = []

for line in gene_data:

    info_list = line.strip("\n").split("\t")

    chrom = info_list[0]
    start = int(info_list[1])
    end = int(info_list[2])
    feature_length = end - start
    sample = info_list[3]
    expression_score = int(info_list[4])
    strand = info_list[5]

    new_score = feature_length * expression_score

    if strand == "+":
        new_score_list.append(new_score)

    else:
        new_score *= -1
        new_score_list.append(new_score)
    


    print(chrom + "\t" + str(start) + "\t" + str(end) + "\t" + sample + "\t" + str(new_score) + "\t" + strand)
