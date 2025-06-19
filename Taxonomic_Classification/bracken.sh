for report in /home/scs298/metagenomics_Exp1/kraken_output/*_kraken_report.txt; do
    base=$(basename "$report" _kraken_report.txt)
    bracken -i "$report" \
            -o /home/scs298/metagenomics_Exp1/bracken_output/${base}_bracken_output.txt \
            -d /home/scs298/k2_pluspf_20240904 \
	    -r 150 \
            -l S
done
