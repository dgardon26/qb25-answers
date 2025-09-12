grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes

bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed

cut -f1-3,5 hg19-kc.tsv > hg19-kc.bed

bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed > hg16-kc-count.bed

wc hg19-kc.bed
# number of genes in hg19 is 80269 - the first line is a header, not a real gene.

bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | wc -l
# number of genes in hg19 but not hg16 is 42717

# Genes being in hg19 but not 16 could be due to improved sequencing and assembly methods by the time hg19 was made - better sequencing methods
# allowing for these genes to be sequenced and acknowledged as part of the assembly in 19 but not 16.
# Also, improved sequencing methods may have lead to better "detail" - sections that may have been treated as one gene in 16
# could have had better detail known by 19 that acknowledged them as separate genes in 19, also meaning those sections would not
# exist in 16.

wc hg16-kc.bed 
# number of genes in hg16 is 21364 - the first line is a header, not a real gene.

bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed | wc -l
# number of genes present in hg16 but not 19 is 3460.

# Genes being present in hg16 but not 19 could be due to nomenclature differences between the two sets - perhaps genes
# were labeled/named differently in the hg19 dataset compared to 16 as the field evolved and grew. Additionally, perhaps sections 
# in hg16 were encompassed in different sections by hg19. Finally, the differences across them could be due to differences in 
# sequencing/methodology/assembly methods.
