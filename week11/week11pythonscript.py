#!/usr/bin/env python3

import numpy as np
import scipy.stats
from scipy.stats import poisson
from scipy.stats import norm
import math
import csv
import graphviz

my_coverage_file = "coverage30_file.txt"
my_range_file = "coverage30_range_file.csv"

# Step 1.2

# num_reads = calculate_number_of_reads(genomesize, readlength, coverage)
genomesize = 1000000
readlength = 100
coverage = 30
num_reads = int((genomesize * coverage)/readlength)

## use an array to keep track of the coverage at each position in the genome
coverage_array = np.zeros(1000000)

for i in range(1, num_reads):

  startpos = int(np.random.uniform(0,genomesize-readlength+1))
  endpos = int(startpos + readlength)
  coverage_array[startpos:endpos] += 1

## get the range of coverages observed
maxcoverage = int(max(coverage_array))
xs = list(range(0, maxcoverage+1))

## Get the poisson pmf at each of these
poisson_estimates = scipy.stats.poisson.pmf(xs, coverage) # xs is the range, mu is the average (in this case the coverage)

## Get normal pdf at each of these (i.e. the density between each adjacent pair of points)
normal_estimates = norm.pdf(xs, coverage, math.sqrt(coverage))

## now plot the histogram and probability distributions

with open(my_coverage_file, "w") as f: # got some help from GPT to fix the error python was throwing here initially
    for item in coverage_array:
       f.write(str(item) + "\n")

with open(my_range_file, "w") as f:
    print(xs)
    for item in xs:
        f.write(str(item) + "\n")

np.savetxt("poisson_coverage30.csv", poisson_estimates, delimiter = " ")
np.savetxt("normal_coverage30.csv", normal_estimates, delimiter = " ")

