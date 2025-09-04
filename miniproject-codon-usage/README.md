# My Mini Project 2
# Translating codons into amino acids and compare amino acid compositions across proteins using FASTA

# For Step 2:
I believe this output is correct because using the subset.fa file is returning a long field that I assume is the ident containing the information about the current contig (which has a lot of repeats that makes me think it's right) and for the codon output, it seems to be iterating on every line, which would also be correct.

# For Step 3:
I believe this output is correct because using the subset.fa file is returning various amounts of different codons/residues and is returning the letter codes for the residues rather than the codons.

The other point here is the difference between cytoplasmic and membrane amino acids. It's a little hard to tell in the current formatting, but my thought is that the differences would be related to environmental differences - a membrane protein has to content with some very differently charged environnments whereas a cytoplasmic doesn't, possibly explaining the charge differences.