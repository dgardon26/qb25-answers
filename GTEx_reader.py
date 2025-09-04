#!/usr/bin/env python3

import sys

import gzip

GTEx_file = gzip.open(sys.argv[1])

_ = GTEx_file.readline()
_ = GTEx_file.readline()

header_line = GTEx_file.readline().decode()

header_line = header_line.strip("\n")

header_fields = header_line.split("\t")

data_line = GTEx_file.readline().decode()

data_line = data_line.strip("\n")

data_fields = data_line.split("\t")

GTEx_dictionary = {}

for i in range(len(header_fields)):
    GTEx_dictionary[header_fields[i]] = data_fields[i]

metadata = "/Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt"

for line in open(metadata):
    
    fields = line.split("\t")

    if fields[0] not in GTEx_dictionary:
        continue

    elif fields[0] in GTEx_dictionary:
        print(str(fields[0]) + "\t" +  str(GTEx_dictionary.get(fields[0])) + "\t" + str(fields[6]))

# input to use in terminal to get first three non-zero tissues
# ./GTEx_reader.py ~/Data/GTEx/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct.gz | sort -k 2 | awk '$2 != 0 {print $2,$3}' | sort | head -3
# Tissues are: Artery, Kidney, Brain





