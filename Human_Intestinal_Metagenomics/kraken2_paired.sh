#!/bin/bash

# Path to Kraken2 database
KRAKEN2_DB="/home/scs298/k2_pluspf_20241228"

# Create an output directory for Kraken2 results
mkdir -p kraken_outputs

# Change to the directory containing your FASTQ files
cd /home/scs298/human_int_metagenome

# Loop through all paired-end FASTQ files in the directory
for file1 in *_1.fastq*; do
    # Extract the base name without the _1 or .fastq/.fastq.gz extension
    base=$(basename "$file1" _1.fastq)

    # Identify the corresponding paired file
    file2="${base}_2.fastq"

    # Check if the paired file exists
    if [[ -f "$file2" ]]; then
        echo "Processing paired-end reads: $file1 and $file2"
        kraken2 --db $KRAKEN2_DB \
                --paired \
                --output kraken_outputs/${base}_kraken_output.txt \
                --report kraken_outputs/${base}_kraken_report.txt \
                "$file1" "$file2"
   
    else
        echo "Paired file not found for: $file1"
        continue
    fi

    # Display message indicating which files have been processed
    echo "Processed: $file1 and its pair"
done

echo "All paired-end files processed."
i
