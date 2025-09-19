
bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam

samtools sort -o A01_01.bam A01_01.sam

samtools index A01_01.bam

samtools idxstats A01_01.bam > A01_01.idxstats

# Exercise 2 Haplotype Answer

Looking at the IGV visualizations, samples 1, 3, 4 and samples 2, 5 and 6 seem to be of the same haplotype and look similar. Comparing this to the text file, 1, 3 and 4 seem to generally be the R strain while 2, 5, and 6 seem to generally be B, so this comparison matches and seems to check out with the results I got.

