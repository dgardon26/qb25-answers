# Question 2.2
For this model, I got a slope of 0.37757. This means that for every year of maternal age, there is approximately 0.37 more maternal de novo mutations. In more practical terms, every 10 years of maternal age leads to about 3-4 maternal de novo mutations. This seems to match the plot.

In terms of p-value, it returned 2.2e-16, which is the probability that this relationship would happen assuming the null hypothesis of there being no relation between maternal de novo mutations and maternal age. This is an incredibly tiny probability to say the least, so I would conclude this relationship is definitely significant.

# Question 2.3

For this model, I got a slope of 1.35384. This means that for every year of paternal age, there is about 1.35 more paternal de novo mutations on average. In other words, for every year older a father is there will be a little over 1 more mutations on average. This also seems to match the plot.

For the p-value, I got 2e-16 again, which is the probability that this relationship would happen assuming null hypothesis of there being no relation between paternal de novo mutations and paternal age. This is once again an incredibly tiny probability, so I would conclude this relationship is also significant.

# Question 2.4

The intercept for the paternal model was 10.32632 and the slope was 1.35384. Therefore, I did 1.35384 * 50.5 + 10.32632 and saved it to a varaible in my R script to get the predicted number of mutations for a 50.5 year old father. The predicted amount is about 78.7 de novo mutations for a father of that age.

# Question 2.6 

The size of the relationship seems to be that on average, there are about 39.23 less maternal de novo mutations compared to paternal. Looking at the graph from 2.5, this does seem to roughly check out and match the plot - the paternal DNMs are much higher overall. The relationship is significant and I know this because the p value is less than 2e-16, which is incredibly tiny. Once again this is saying that assuming the null hypothesis of there being no differences between the groups, the chance of the result I have occurring is that small. This suggests the relationship is significant and thus that the paternal DNMs are higher on average. 

Comparing the intercept term from lm(y ~ 1), that returned 39.23. This returned a positive number because I subtracted mother from father this time, but otherwise exactly matches the mean found from the t test. This is because I'm telling R to, given the average difference between PNM and MNM, find the best answer (horizontal line), which is ultimately the same computation as what was done in the t test and is what this intercept represents.

# Exercise 3

For exercise 3, I am using #13, the Pokemon dataset (https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-04-01/readme.md).

# Question 3.2

I started with generating a plot for height and weight. This mostly seemed to be relatively linear, with heavy clustering at shorter heights and weights, but there were quite a few notable outliers in terms of being much heavier or much taller than most of the Pokemon in the dataset.

My next thought was to compare attack with speed, with the thought of seeing if high attack correlates with high speed and thus being a "glass cannon" in terms of gameplay or not. The result was extremely roughly linear from the looks of the scatter plot, but doesn't seem super tightly linearly defined and not as tight as the height/weight graph. 

Wondering if the relationship between special attack (essentially magic damage compared to attack's physical damage) and speed was any different, I next tried special attack versus speed. This looks almost identical to the attack and speed graph, with what seems to be a roughly linear relationship but not one that is super tight, either.

Now wondering if weight correlates with being "bulky" and thus higher HP pools, I also tested weight vs HP. This seemed to have an intercept, because even pokemon that are close to 0 still have HP, but there did seem to be a linear relationship present, even if a lot of outliers were in the data.

Finally, for a totally "out there" one I tried species id versus base experience. Base experience in pokemon games refers to how much XP a pokemon will give upon beating them and species ID is just that. I tried this with the thought that often early game pokemon that can be earlier in the species ID list give less XP, but I didn't think about the fact that evolutions that give more are listed alongside something like, say, Bulbasaur, so this didn't end up looking like any type of relationship. 

# Question 3.3

I decided to focus on the fourth graph, pokemon weight versus higher HP pools. I hypothesize that there will be a positive intercept, representing that even Pokemon as close to 0 weight as possible will still have a floor on their HP for gameplay reasons, and that there will be a positive slope representing that weight increasing corresponds with HP increases. 

Using lm(), I got an intercept of 62.7 and a slope of 0.09, meaning that for every 1 pound a Pokemon weighs, their HP will increase by about 0.1, which is not a super strong relationship but most certainly positive. Notably, the p values for both of these calculations were 2e-16, suggesting the relationship might be weak but is absolutely statistically significant, and that Pokemon weight is indeed correlated with HP. 

Final linear model was HP = 0.094510 * weight + 62.696909. 