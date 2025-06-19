#!/bin/bash

# Define the path to the Kraken2 database and the output directory
KRAKEN2_DB="/home/scs298/k2_pluspf_20241228"
REPORT_DIR="/home/scs298/human_int_metagenome/kraken_outputs"
OUTPUT_DIR="/home/scs298/human_int_metagenome/bracken_output"

# Create output directories for each taxonomic level if they don't exist
mkdir -p "$OUTPUT_DIR/species"
mkdir -p "$OUTPUT_DIR/genus"
mkdir -p "$OUTPUT_DIR/family"
mkdir -p "$OUTPUT_DIR/phylum"

# Iterate through all Kraken report files
for report in "$REPORT_DIR"/*_kraken_report.txt; do
    base=$(basename "$report" _kraken_report.txt)

    # Run Bracken for each taxonomic level: species (S), genus (G), family (F), phylum (P)
    for level in S G F P; do
        case $level in
            S) level_name="species" ;;
            G) level_name="genus" ;;
            F) level_name="family" ;;
            P) level_name="phylum" ;;
        esac

        echo "Processing $base at $level_name level..."

        bracken -i "$report" \
                -o "$OUTPUT_DIR/$level_name/${base}_bracken_${level_name}.txt" \
                -d "$KRAKEN2_DB" \
                -r 150 \
                -l $level

        echo "Completed $base at $level_name level."
    done
done

echo "Bracken abundance calculation completed for all taxonomic levels."

