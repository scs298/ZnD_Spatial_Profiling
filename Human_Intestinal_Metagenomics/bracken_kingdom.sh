#!/bin/bash

# Path to Kraken2 database
KRAKEN2_DB="/home/scs298/k2_pluspf_20241228"

# Input and output directories
INPUT_DIR="/home/scs298/human_int_metagenome/kraken_outputs"
OUTPUT_DIR="/home/scs298/human_int_metagenome/bracken_output/kingdom"

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Loop through all Kraken report files in the input directory
for report in "$INPUT_DIR"/*_kraken_report.txt; do
    # Extract the base name without the _kraken_report.txt extension
    base=$(basename "$report" _kraken_report.txt)

    echo "Processing $base at kingdom level..."

    # Run Bracken for kingdom level
    bracken -i "$report" \
            -o "$OUTPUT_DIR/${base}_bracken_kingdom.txt" \
            -d $KRAKEN2_DB \
            -r 150 \
            -l K \
            -t 10

    echo "Completed $base at kingdom level."
done

echo "All files processed at kingdom level."

