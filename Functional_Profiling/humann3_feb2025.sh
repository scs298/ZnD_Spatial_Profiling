#!/bin/bash

# Define directories and parameters
input_dir="/home/scs298/metagenomics_Exp1/fastq/ZnDvZnA"  # Input FASTQ folder
output_dir="/home/scs298/metagenomics_Exp1/humann_output/ZnDvZnA"  # Output folder
chocophlan_db="/home/scs298/chocophlan"  # ChocoPhlAn database
metaphlan_db="/home/scs298/metaphlandb"  # MetaPhlAn database
threads=8  # Threads per job
num_jobs=2  # Parallel jobs

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Check if ChocoPhlAn database exists
if [ ! -d "$chocophlan_db" ] || [ -z "$(ls -A "$chocophlan_db")" ]; then
    echo "Error: ChocoPhlAn database is empty or missing! Run:"
    echo "  humann_databases --download chocophlan full $chocophlan_db"
    exit 1
fi

# Function to process each FASTQ file
process_fastq_file() {
    fastq_file="$1"
    base=$(basename "$fastq_file" .fastq)
    final_output="$output_dir/${base}_genefamilies.tsv"

    if [ -f "$final_output" ]; then
        echo "Skipping $fastq_file: HUMAnN3 has already been run on this file."
    else
        echo "Running HUMAnN3 on $fastq_file..."
        humann --input "$fastq_file" --output "$output_dir/${base}_humann_output" \
        --threads $threads \
        --nucleotide-database "$chocophlan_db" \
        --metaphlan-options "--bowtie2db $metaphlan_db" \
        --bypass-prescreen --input-format fastq
    fi
}

export -f process_fastq_file
export output_dir
export threads
export chocophlan_db
export metaphlan_db

# Find FASTQ files and process in parallel
find "$input_dir" -name "*.fastq" | parallel -j "$num_jobs" process_fastq_file {}

echo "Finished processing all files."

