#!/usr/bin/env python3

# I used this website for additional help with modeling the code https://wilkelab.org/classes/SDS348/2019_spring/labs/lab13-solution.html

import sys

import numpy as np

from fasta import readFASTA



#====================#
# Read in parameters #
#====================#

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code

FASTA_file = sys.argv[1]
sigma_file = sys.argv[2]
penalty = float(sys.argv[3])
out_file = sys.argv[4]



# Read the scoring matrix into a dictionary
fs = open(sigma_file)
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# Read in the actual sequences using readFASTA

input_sequences = readFASTA(open(FASTA_file))
seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]


#=====================#
# Initialize F matrix #
#=====================#

sequence1_length = len(sequence1)
sequence2_length = len(sequence2)

F_matrix = np.empty((sequence1_length + 1, sequence2_length + 1))

#=============================#
# Initialize Traceback Matrix #
#=============================#

traceback_matrix = np.empty((sequence1_length + 1, sequence2_length + 1))

#===================#
# Populate Matrices #
#===================#

for i in range(0, sequence1_length + 1):
	F_matrix[i][0] = penalty * i

for j in range(0, sequence2_length + 1):
	F_matrix[0][j] = penalty * j

for i in range(1, sequence1_length + 1):
	for j in range(1, sequence2_length + 1):

		nucleotide1 = sequence1[i - 1]
		nucleotide2 = sequence2[j - 1]
		match_score = sigma[(nucleotide1, nucleotide2)]

		match = F_matrix[i - 1][j - 1] + match_score
		delete = F_matrix[i - 1][j] + penalty
		insert = F_matrix[i][j - 1] + penalty

		F_matrix[i][j] = max(match, delete, insert)




#========================================#
# Follow traceback to generate alignment #
#========================================#

# The aligned sequences are assumed to be strings named sequence1_aligment
# and sequence2_alignment in later code

sequence1_alignment = ''
sequence2_alignment = ''

i = sequence1_length
j = sequence2_length

while i > 0 and j > 0:
	score_current = F_matrix[i][j]
	score_diagonal = F_matrix[i - 1][j - 1]
	score_up = F_matrix[i - 1][j]
	score_left = F_matrix[i][j - 1]
	nucleotide1 = sequence1[i - 1]
	nucleotide2 = sequence2[j - 1]
	match_score = sigma[(nucleotide1, nucleotide2)]

	if score_current == score_diagonal + match_score:
		sequence1_alignment += sequence1[i - 1]
		sequence2_alignment += sequence2[j - 1]
		i -= 1
		j -= 1
		
	elif score_current == score_up + penalty:
		sequence1_alignment += sequence1[i - 1]
		sequence2_alignment += '-'
		i -= 1
		
	elif score_current == score_left + penalty:
		sequence1_alignment += '-'
		sequence2_alignment += sequence2[j - 1]
		j -= 1
		

while j > 0: 
		sequence2_alignment += sequence2[j - 1]
		sequence1_alignment += '-'
		j -= 1
		

while i > 0:
		sequence2_alignment += '-'
		sequence1_alignment += sequence1[i - 1]
		i -= 1
		

sequence1_alignment = sequence1_alignment[::-1]
sequence2_alignment = sequence2_alignment[::-1]


#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '


#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

output = open(out_file, 'w')

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_alignment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')


#=============================#
# Calculate sequence identity #
#=============================#

gap_sequence_1 = sequence1_alignment.count('-')
gap_sequence_2 = sequence2_alignment.count('-')
percent_sequence_1 = (identity_alignment.count("|")/len(sequence1)) * 100
percent_sequence_2 = (identity_alignment.count("|")/len(sequence2)) * 100

alignment_score = 0

for i in range(0, len(sequence1_alignment)):
	if sequence1_alignment[i] == "-" or sequence2_alignment == "-":
		continue
	else:
		alignment_score += sigma[(nucleotide1, nucleotide2)]


#======================#
# Print alignment info #
#======================#

# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score

print(gap_sequence_1)
print(gap_sequence_2)
print(percent_sequence_1)
print(percent_sequence_2)
print(alignment_score)
