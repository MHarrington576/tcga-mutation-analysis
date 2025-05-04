#!/bin/bash

# Initialize counter variables for total mutations
total_sp1=0
total_s100a4=0
total_yap1=0
total_rhoa=0
total_wwtr1=0
total_lats1=0

# Initialize counters for samples with at least one mutation
samples_with_sp1=0
samples_with_s100a4=0
samples_with_yap1=0
samples_with_rhoa=0
samples_with_wwtr1=0
samples_with_lats1=0

# Initialize counter for total samples
total_samples=0

# Process each MAF file
for i in *.maf
do
  # Count total samples
  total_samples=$((total_samples + 1))
  
  # Count mutations for each gene in the current file
  sp1_count=$(grep -c 'SP1' $i)
  s100a4_count=$(grep -c 'S100A4' $i)
  yap1_count=$(grep -c 'YAP1' $i)
  rhoa_count=$(grep -c 'RHOA' $i)
  wwtr1_count=$(grep -c 'WWTR1' $i)
  lats1_count=$(grep -c 'LATS1' $i)
  
  # Add to running totals
  total_sp1=$((total_sp1 + sp1_count))
  total_s100a4=$((total_s100a4 + s100a4_count))
  total_yap1=$((total_yap1 + yap1_count))
  total_rhoa=$((total_rhoa + rhoa_count))
  total_wwtr1=$((total_wwtr1 + wwtr1_count))
  total_lats1=$((total_lats1 + lats1_count))
  
  # Check if this sample has at least one mutation for each gene
  if [ $sp1_count -gt 0 ]; then
    samples_with_sp1=$((samples_with_sp1 + 1))
  fi
  if [ $s100a4_count -gt 0 ]; then
    samples_with_s100a4=$((samples_with_s100a4 + 1))
  fi
  if [ $yap1_count -gt 0 ]; then
    samples_with_yap1=$((samples_with_yap1 + 1))
  fi
  if [ $rhoa_count -gt 0 ]; then
    samples_with_rhoa=$((samples_with_rhoa + 1))
  fi
  if [ $wwtr1_count -gt 0 ]; then
    samples_with_wwtr1=$((samples_with_wwtr1 + 1))
  fi
  if [ $lats1_count -gt 0 ]; then
    samples_with_lats1=$((samples_with_lats1 + 1))
  fi
done

# Calculate percentages using awk for floating-point arithmetic
if [ $total_samples -gt 0 ]; then
  percent_sp1=$(awk "BEGIN {printf \"%.2f\", ($samples_with_sp1 * 100 / $total_samples)}")
  percent_s100a4=$(awk "BEGIN {printf \"%.2f\", ($samples_with_s100a4 * 100 / $total_samples)}")
  percent_yap1=$(awk "BEGIN {printf \"%.2f\", ($samples_with_yap1 * 100 / $total_samples)}")
  percent_rhoa=$(awk "BEGIN {printf \"%.2f\", ($samples_with_rhoa * 100 / $total_samples)}")
  percent_wwtr1=$(awk "BEGIN {printf \"%.2f\", ($samples_with_wwtr1 * 100 / $total_samples)}")
  percent_lats1=$(awk "BEGIN {printf \"%.2f\", ($samples_with_lats1 * 100 / $total_samples)}")
else
  percent_sp1="0.00"
  percent_s100a4="0.00"
  percent_yap1="0.00"
  percent_rhoa="0.00"
  percent_wwtr1="0.00"
  percent_lats1="0.00"
fi

# Output the results
{
  echo "TOTAL MUTATION COUNTS ACROSS ALL SAMPLES"
  echo "========================================"
  echo "SP1: $total_sp1 (Present in $percent_sp1% of samples)"
  echo "S100A4: $total_s100a4 (Present in $percent_s100a4% of samples)"
  echo "YAP1: $total_yap1 (Present in $percent_yap1% of samples)"
  echo "RHOA: $total_rhoa (Present in $percent_rhoa% of samples)"
  echo "WWTR1: $total_wwtr1 (Present in $percent_wwtr1% of samples)"
  echo "LATS1: $total_lats1 (Present in $percent_lats1% of samples)"
  echo ""
  echo "SAMPLE STATISTICS"
  echo "================="
  echo "Total samples analyzed: $total_samples"
} > total-brca-mechano-mutations.txt
