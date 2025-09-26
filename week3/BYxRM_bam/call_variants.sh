#!/bin/bash

for sample in A01_09 A01_11 A01_23 A01_24 A01_27 A01_31 A01_35 A01_39 A01_62 A01_63
    do
    ls $sample.bam
    samtools index $sample.bam
    samtools view -c $sample.bam >> read_counts.txt
    echo $sample.bam >> bamListFile.txt
done

#last part of 1 is freebayes -f ~/qb25-answers/week2/genomes/sacCer3.fa -L ~/qb25-answers/week3/BYxRM_bam/bamListFile.txt --genotype-qualities -p 1 > unfiltered.vcf