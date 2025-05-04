#!/bin/bash

# TCGA Breast Cancer Somatic Mutations Analysis
# IMPORTANT: Launch script in same directory as manifest file was downloaded

# Matt Harrington, Clemson University
# 2025-03-27

# Install GDC client and put into PATH

# Download data from GDC as a manifest file for a given set of TCGA-BRCA MAF files

# Download MAF datasets from manifest file
# gdc-client download -m [manifest_name.txt]

# Copy all MAF files into PWD
for i in */;
do cp $i/*.maf.gz ./;
done

# Gunzip all MAF.GZ files in PWD, echo the name of the file, and count the number of times that “TP53” appears in the file
for i in *.maf.gz;
do
gunzip -k $i
done

for i in *.maf
do
tp53_count=$(grep -c 'TP53' $i)
stat5_count=$(grep -c 'STAT5' $i)
echo $i
echo TP53: $tp53_count
echo STAT5: $stat5_count
done > tcga-brca-mutations.txt

