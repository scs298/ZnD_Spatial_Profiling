### **README: Multiomics approach to regionally profile Zn-driven host-gut microbiome interactions in the gastrointestinal tract**

![VERSION4 ZnD Spatial Profiling_ Graphical Abstract](https://github.com/user-attachments/assets/161e9b25-b322-42d6-9475-5effbc1a092b)


**Repository Structure**

```
ZnD_Spatial_Profiling/
├── Data_Analysis/
│   ├── LDA_ZnD5.Rmd
│   ├── Metagenomics_ZnD5_ZnDvZnA.Rmd
│   ├── Metagenomics_ZnD5_gutdb.Rmd
│   ├── ZnD5_Humann3.Rmd
│
├── Functional_Profiling/
│   ├── ZnD5_Humann3_Norm_commands.csv
│   ├── humann3_feb2025.sh
│
├── Human_Intestinal_Metagenomics/
│   ├── SRR_Acc_List_device_2_3_4.txt
│   ├── bracken.sh
│   ├── bracken_kingdom.sh
│   ├── download_all.sh
│   ├── human_int_metagenomics.Rmd
│   ├── kraken2_paired.sh
│
├── Taxonomic_Classification/
│   ├── bracken.sh
│   ├── bracken_F.sh
│   ├── bracken_G.sh
│   ├── bracken_K.sh
│   ├── bracken_P.sh
│   ├── process_kraken_single_end.sh
│   ├── process_kraken_single_end_MGBC.sh
│
├── ZnD5_metadata.csv
├── metadata_phy_ZnD5.csv
├── .gitignore (or .gitattributes)
├── .DS_Store  ← (recommended to remove this file)
```


**1. Quality Control**
Tools: FastQC v0.12.1 and MultiQC v1.15
Raw reads were quality-checked, and samples with excessive read depth were downsampled to normalize library sizes.

**2. Taxonomic Classification**
Classifier: Kraken2 v2.1.3 with Bracken v2.9

Databases:

PlusPF (for broad domain coverage including bacteria, viruses, fungi, and host contamination)

MGBC Mouse Gut Database (for mouse-specific bacterial resolution)

Outputs included taxonomic abundances at species, genus, family, phylum, and kingdom levels.

**3. Functional Profiling**
Tool: HUMAnN3 v3.7
Databases: ChocoPhlAn + UniRef90

Steps:
Run HUMAnN3 for each sample (humann3_feb2025.sh)
Normalize to CPM
Regroup to GO terms
Join tables across samples for matrix construction
Human reads in intestinal samples were filtered out prior to HUMAnN3 analysis.

**4. Diversity Analyses**
Alpha diversity: Shannon, Chao1, Observed species (via phyloseq)
Beta diversity: Bray-Curtis + PCoA (via vegan)
Richness ratios (F:B, V:B) and kingdom-level comparisons generated for spatial and treatment insights.


**5. Differential Abundance & Functional Analysis**
Differential taxa: MaAsLin2 and LEfSe 
Functional heatmaps: Top variable GO terms visualized with ComplexHeatmap and pheatmap

**6. Human-Mouse Comparisons**
Human data: Intestinal metagenomes (capsules 2, 3, and 4) from published studies (see scripts)
Comparative genus-level profiling using Kraken2 + Bracken
Overlap with Zn-associated genera in mice visualized via Venn diagrams and log-scaled boxplots

Paths are specific to the author's computing environment and should be modified accordingly.

Required R packages include: phyloseq, vegan, microbiomeMarker, ggplot2, ComplexHeatmap, AnnotationDbi, GO.db, pheatmap, MaAsLin2, tidyverse, ggvenn.

Citation:


