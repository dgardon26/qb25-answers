#for how many features/lines in whole file
wc -l ce11_genes.bed 

#53935

# this will read the first column and determine the number of unique chromosomes 
# (the unique verb has an adverb that lets you count the number of times each thing occurs
cut -f 1 ce11_genes.bed | uniq -c  

# 5460 chrI
#  12 chrM
# 9057 chrV
# 6840 chrX
# 6299 chrII
# 21418 chrIV
# 4849 chrIII

# count number of features per strand (+ and -) 
# unique requires data to be sorted to work properly and only column 1 is sorted in this file by my default

cut -f 6 ce11_genes.bed | sort | uniq -c

# 26626 -
# 27309 +

