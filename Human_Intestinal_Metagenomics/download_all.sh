#!/bin/bash

# Make sure the SRA Toolkit (prefetch, fastq-dump) is in your PATH

# Loop through each accession and download + convert
while read accession; do
    echo "Processing $accession..."
# Define expected output FASTQ filenames
    file1="${accession}_1.fastq.gz"
    file2="${accession}_2.fastq.gz"

    # Skip if both FASTQ files already exist
    if [[ -f "$file1" && -f "$file2" ]]; then
        echo "FASTQ files for $accession already exist. Skipping."
        echo "--------------------------"
        continue
    fi
    # Download the .sra file
    prefetch "$accession"

    # Convert to gzipped FASTQ files
    fastq-dump --split-files --gzip "$accession"

    echo "Finished $accession"
    echo "--------------------------"
done < SRR_Acc_List_device_2_3_4.txt

