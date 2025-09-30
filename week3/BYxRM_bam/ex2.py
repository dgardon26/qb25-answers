#!/usr/bin/env python3


my_file = open("AF.txt", 'w')
my_other_file = open("DP.txt", 'w')

for line in open("biallelic.vcf"):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')
    info = fields[7]
    
    separated_info = info.split(";")
    
    for items in separated_info:
        if items.startswith("AF"):
            my_file.write(items[3:] + "\n")
        
        if items.startswith("DP"):

            if items.startswith("DPB"):
                continue
            if items.startswith("DPRA"):
                continue
            my_other_file.write(items[3:] + "\n")

     



