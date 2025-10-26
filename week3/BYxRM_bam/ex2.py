#!/usr/bin/env python3


my_file = open("AF.txt", 'w')
my_other_file = open("DP.txt", 'w')

for line in open("biallelic.vcf"):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')
    info = fields[7]
    info_items = info.split(";")
    for thing in info_items:
        if thing.startswith("AF"):
            my_file.write(thing[3:] + "\n")
    i = 9
    for i in fields: # GT:GQ:DP:AD:RO:QR:AO:QA:GL so want 3rd item in list (depth)
        info = fields[9]
        separated_info = info.split("\t")
        for entry in separated_info:
            separated_entry = entry.split(":")
            my_other_file.write(separated_entry[2] + "\n")

            
    
   # for items in separated_info:
      #  if items.startswith("AF"):
          #  my_file.write(items[3:] + "\n")
        
       # if items.startswith("DP"):

         #   if items.startswith("DPB"):
            #    continue
          #  if items.startswith("DPRA"):
            #    continue
          #  my_other_file.write(items[3:] + "\n")

     



