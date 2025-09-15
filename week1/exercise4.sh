bedtools intersect -a hg19-kc.bed -b snps-chr1.bed | sort -k 4 | cut -f 4 | uniq -c | sort
# The gene with the most SNPs is ENST00000490107.6_7 (5445 SNPs). The human name is SMYD3. It is hg19 chr1:245912649-246670581. It is 757,932
# bp long. It has 30 exons. My guess is that this gene has the most SNPs in part because of simple statistical likelihood - it is a 
# very large gene and therefore it is more likely any SNPs would occur there. Additionally, SMYD3 is a histone methyltransferase
# that functions in RNA Polymerase II via interaction with a helicase. There are multiple transcriptional variants for isoforms of 
# SMYD3. Given this naturally large transcriptional variance in the site, it therefore makes sense that a gene with such variation
# might also accumulate many SNPs/differences as a result.

bedtools sample -n 20 -seed 42 -i snps-chr1.bed

bedtools sample -n 20 -seed 42 -i snps-chr1.bed | bedtools sort > random-snps.bed

bedtools sort -i hg19-kc.bed > sorted-hg19-kc.bed

bedtools closest -d -t first -a random-snps.bed -b sorted-hg19-kc.bed

bedtools closest -d -t first -a random-snps.bed -b sorted-hg19-kc.bed | cut -f 11 | grep -w "0" | wc -l

# Any SNP inside a gene will return a distance of 0. By this logic, using this command we can find there are 15 SNPs
# in this particular data set contained within genes.

bedtools closest -d -t first -a random-snps.bed -b sorted-hg19-kc.bed | cut -f 11 | sort -n

# Using this we can see the distances in a sorted list. When going past all the 0s, we can see that the smallest non 0 value is 1664
# and the highest is 22944, meaning the ranges for distances away from a genes for these SNPs is 1664 bp to 22944 bp.