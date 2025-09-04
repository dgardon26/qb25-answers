cut -f 3 ~/Data/References/hg38/gencode.v46.basic.annotation.gtf | grep -v '^#' | sort | uniq -c

# entries per feature type
# 664771 CDS
# 865650 exon
# 63086 gene
# 107 Selenocysteine
# 64970 start_codon
# 64806 stop_codon
# 118625 transcript
# 182871 UTR

grep -c lncRNA ~/Data/References/hg38/gencode.v46.basic.annotation.gtf

# entries with lncRNA is 156661