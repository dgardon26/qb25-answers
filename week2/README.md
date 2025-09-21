# Exercise 1

bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam

samtools sort -o A01_01.bam A01_01.sam

samtools index A01_01.bam

samtools idxstats A01_01.bam > A01_01.idxstats

# Exercise 2 Haplotype Answer

Looking at the IGV visualizations, samples 1, 3, 4 and samples 2, 5 and 6 seem to be of the same haplotype and look similar. Comparing this to the text file, 1, 3 and 4 seem to generally be the R strain while 2, 5, and 6 seem to generally be B, so this comparison matches and seems to check out with the results I got.

# Exercise 4

minimap2 -a -x map-ont sacCer3.fa ~/qb25-answers/week2/rawdata/ERR8562478.fastq > ~/qb25-answers/week2/longreads/longreads.sam 

samtools sort -o longreads.bam longreads.sam

samtools index longreads.bam

# Exercise 5

hisat2 -x ../genomes/sacCer3 -U ~/qb25-answers/week2/rawdata/SRR10143769.fastq > SRRhisat2.sam

samtools sort -o SRRhisat2.bam SRRhisat2.sam 

samtools index SRRhisat2.bam

The region selected happens to have 4 active genes with at least 20 reads: FUN26, CCR4, ATS1 and FUN30. The parts of the genes with the most coverage generally seem to around the boundaries of the gene, as pretty much all the reads for all of these genes are on one of the ends. Assuming the arrows indicate direction the gene is meant to be read in, even more specifically then, the reads seem to be clustered around the end/stop site of the gene specifically, as this would be true of all four of the genes.
