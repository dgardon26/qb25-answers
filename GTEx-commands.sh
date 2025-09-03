## Which three SMTSDs (Tissue Site Detail) have the most samples?

cut -f 7 ~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort | tail -n 3

#  867 Lung
# 1132 Muscle - Skeletal
# 3288 Whole Blood

## How many lines have “RNA”?

grep -c RNA ~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt

# 20017

## How many lines do not have “RNA”?

grep -vc RNA ~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt

# 2935