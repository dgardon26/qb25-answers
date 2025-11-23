# Step 1.1

1 Mbp * 3 = 3 Mbp
3 Mbp / 100 = 30000 reads

# Step 1.4

For the first question, the total number of spots in the genome with 0 coverage in this simulation is 50,123 bases with no coverage.

Per my poisson distribution, I could expect ~5.0% of results to be 0 given the average is 3 with this range. This would translate to about 50,000 bases in a genome of about 1 Mb having no reads, so my result is very slightly higher than this, but matches very well with what you'd expect from a poisson distribution. 

From the normal distribution, it doesn't look quite as close. To me it looks like the normal distribution is predicting more reads higher than the mean than the data set actually had, and less reads lower than the mean than it actually had. It's not hugely off, but does seem a bit off. It seems to be predicting about 51,000 hits for 0, which is a bit less than what I actually got. 

# Step 1.5

This time, the total number of spots in the genome with 0 coverage is 51 (about 0.0051%). 

From the Poisson distribution, I would expect about 0.0045% of results to be 0 with these parameters, so while my result did end up being significantly more in terms of absolute value, relatively speaking 45-51 bases in a 1000000 bp sequence is pretty similar, so considering that at this relatively low percent noise would be contributing, this is very much in line with what I'd expect. 

For the normal distribution, it fits the data much better compared to the 3x coverage example. It still seems to be slightly overestimating reads above the mean and slightly underestimating hits below the mean but overall it is now a much closer fit to a normal distribution. For 0 specifically, though, it does seem to be significantly overestimating the number of reads at 0 as it is predicting ~850 reads at 0 rather than the ~50 we ended up getting.

# Step 1.6

This time, the total number of spots with no coverage was 2. 

The Poisson distribution predicted 0.0000097 spots with 0 coverage on average, so it's actually starting to be a little off in terms of its predictive ability at this point. The normal distribution now fits the data significantly better, and was much better at predicting the number of reads on the low end now since it predicted ~2.27 0 coverage spots.

# Step 2.4

The command I ended up using was ./debruijnscript.py | dot -Tpng > ex2_digraph.png.

# Step 2.5

Assuming a maximum length of 5, one possibility is TCTTATTCTTATTCATTCTTATTGATTT.

# Step 2.6

Accurately reproducing a whole genome would need to apply this same principle behind the De Bruijn graph, but on a much larger scale. Ideally, the reads need to be long enough to identify unique areas - as we saw in this example, short reads can lead to a final reconstruction that is very repetitive, which may or may not reflect the actual sequence of the area at this length of read. Additionally, there needs to be enough read depth that you feel confident you have sampled as close to all of the genome as you can get - for instance, a read depth of 3 would lead to you missing a very significant amount of 5% of the genome. These two factors together, read depth and length, will allow you to apply this principle behind the De Bruijn graph to the whole genome and get as accurate an assembly as possible. 