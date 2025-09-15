bedtools intersect -v -a nhek-active.bed -b nhek-repressed.bed | wc -l # and
bedtools intersect -v -a nhlf-active.bed -b nhlf-repressed.bed | wc -l

#these commands return 14013 and 14888 lines, respectively, or in other words, 14013 and 14888 lines that occur in nhek-active.bed
#and nhlf-active.bed that do not occur in the respective repressed files. Reversing the ordering of files gives you 32314 and 34469
#respectively. In other words, none of the lines in these files overlap as the line count from this command matches the total line
#count in the file

bedtools intersect -a nhek-active.bed -b nhlf-active.bed | wc -l
#12174 lines

bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed | wc -l
#2405 lines, which sums up to 14579, more than the total number of lines that exist in nhek-active.bed.

bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed | wc -l
# Using this modifier just tells if if there were any hits, (>=1), rather than counting each hit separately. This reduces the
# output here to 11608. This plus 2405 in total adds up to 14013, which is the correct number of lines in nhek and tells us we're
# getting one feature per hit now.

bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed | head
# the head is just to make it convienent to copy paste the coordinates of the first feature (chr1	25558413	25559413)
# -f reports overlaps only if they meet the minimal fraction specified (in this case, 100% of the feature in a needs to be in b 
# to be reported)

bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed | head
# Head is to make grabbing the first feature coordinates simple (chr1	19923013	19924213)
# -F reports an overlap only if it meets the minimal fraction specified. However, since it's capital F, it will report the feature 
# in a only if it has 100% overlap in B

bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed | head
# Head makes grabbing the first feature easier (chr1	1051137	1051537)

# Comparing the first two example features, the regions generally align with this logic. In the case using -f, once I zoom out enough
# I see the active region in nhlf is bigger than the nhek region, as 100% of the feature in a is present in b in this instance. Using
# -F, the opposite is true - the active region indicated on nhek is bigger than the nhlf active region at this site, as 100% of the
# region here in b is present in a, therefore making it a hit. Following this logic, a feature that is both 100% present in a and
# 100% present in b is a region of perfect overlap where the active regions for both nhek and nhlf perfectly align. Looking at the 
# example feature taken, this lines up with what you would expect - the active promoter region at this site is exactly the same across
# both.

bedtools intersect -a nhek-active.bed -b nhlf-active.bed | head

# head is once again just to make it easier to browse the output and pick a sample entry. I used chr1	11796213	11797013 as my example
# In this example it seems like all nine conditions have an active promoter at or very close to the site that both NHEK
# and NHLF do. More specifically:
# NHLF is active, with a weak promoter and enhancer nearby.
# NHEK is active, surrounded by enhancers.
# K562 is active, surrounded by enhancers.
# HUVEC is active, with weak and strong enhancers and a promoter nearby.
# HSMM is active, with weak and strong enhancers and a promoter nearby.
# HMEC is active, but in a much smaller region than the others with enhancers nearby.
# HepG2 is active with a weak promoter and strong enhancer nearby, as well as a region of heterochromatin before the promoter.
# H1-hESC is active with a weak enhancer and promoter nearby.
# GM12878 is active, surrounded by weak promoters and a region of heterochromatin before the weak promoter.

bedtools intersect -a nhek-active.bed -b nhlf-repressed.bed | head

# In this example I used chr1	55266612	55267212 as my sample entry.
# As you'd expect, NHLF at this site is repressed.
# NHEK is active and surrounded by promoters, again as expected.
# K562 has a section of heterochromatin proceeding a poised promoter at the site of interest.
# HUVEC is mostly repressed, with a short poised promoter section.
# HSMM is similarly mostly repressed with a short poised promoter section.
# HMEC is a strong enhancer, with some nearby promoter and weak enhancer regions.
# HepG2 is mostly weak_txn with a short insulator region.
# H1-hESC is a poised promoter region.
# GM12878 is an active promoter region surrounded by weak promoters.

bedtools intersect -a nhek-repressed.bed -b nhlf-repressed.bed | head

# In this example I used chr1	11537413	11538213
# NHLF at this site, as expected, is repressed, preceded by heterochromatin and before an insulator region.
# NHEK is also as you'd expect, repressed at this site, and has a poised promoter region after it.
# K562 is heterochromatin with a insulator region after it.
# HUVEC is heterochromatin, and similarly has an insulator region after it.
# HSMM is repressed in this site with heterochromatin before it and a weak promoter after it.
# HMEC is repressed, with an enhancer region after it.
# HepG2 is heterochromatin with a weak promoter after it.
# H1-hESC is repressed, preceded by a heterochromatin region and with a weak enhancer and promoter after it.
# GM12878 is heterochromatin with a weak enhancer region after it.


