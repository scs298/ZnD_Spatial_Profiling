#!/bin/bash

# Path to Kraken2 database
KRAKEN2_DB="/home/scs298/k2_pluspf_20241228"

# Create an output directory for Kraken2 results
mkdir -p kraken_outputs

# Loop through all single-end FASTQ files in the directory
for file in *.fastq; do
    # Extract the base name (without extension) for output file naming
    base=$(basename "$file" .fastq)

    # Run Kraken2 for single-end read files
    kraken2 --db $KRAKEN2_DB \
            --output kraken_outputs/${base}_kraken_output.txt \
            --report kraken_outputs/${base}_kraken_report.txt \
            "$file"

    # Display message indicating which file has been processed
    echo "Processed: $file"
done

echo "All files processed."

