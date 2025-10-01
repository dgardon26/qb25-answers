#!/usr/bin/env python3

# Question 3.1: Taking a look at this section of the genome, my hypothesis based on this would be that 
# strains 09, 11, 23, 35, and 39 are lab derived, while the ones from the wine strain are 24, 27, 31
# 62 and 63.

# sample IDs (in order, corresponding to the VCF sample columns)
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
              "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

# open the VCF file
my_file = open("biallelic.vcf")
my_other_file = open("gt_long.txt", 'w')

for line in my_file:
    if line.startswith("#"):
        continue
    
    # split the line into fields by tab, then
    fields = line.split("\t")
    chrom = fields[0]
    pos   = fields[1]
    
    # print(fields)
    start_index = 9 
    # for each sample in sample_ids:
    for i in range(start_index, len(fields)):
       current_field = fields[i]
       genotype = current_field[0]
       current_sample_id = sample_ids[i - 9]

       ## if current_sample[0] == "."
       ## continue
       
       if genotype == "0" or genotype == "1":
           my_other_file.write(current_sample_id + " " + chrom + " " + pos + " " + genotype + "\n")

        # get the sample's data from fields[9], fields[10], ...
        # genotypes are represented by the first value before ":" in that sample's data
        # if genotype is "0" then print "0"
        # if genotype is "1" then print "1"
        #
        #  otherwise skip
