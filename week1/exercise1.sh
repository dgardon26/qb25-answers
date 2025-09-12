bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed
# creates the bed file with 1 mb intervals

bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed > hg19-kc-count.bed
# counts number of genes per 1 mb interval

