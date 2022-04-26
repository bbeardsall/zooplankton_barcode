# zooplankton_barcode

## get_bold_seqs.R
Required packages: `bold`, `seqinr`, `tidyverse`, `optparse`

Retrieve Cytochrome c oxidase subunit I sequences from BOLD (Barcode Of Life Data System).

Arguments:  
`-i`: Path to species xlsx file. Must have a "Species" column.  
`-g`: Group to subset.  
`-o`: Directory to save sequences in.  
`-m`: Max number of sequences per species to retrieve. Defaults to all.  

Example use:
Navigate to the zooplankton_barcode directory in a terminal.  
`Rscript get_bold_seqs.R -i data/species.xlsx -o test_out -g Salpida -m 1`

To view help, run:  
`Rscript get_bold_seqs.R -h`


## Analysis with MEGA 11
Download MEGA 11 from https://www.megasoftware.net/.

### Alignment
- Open a combined sequence file with "File" -> "Open a File/Session".
- Select `GROUPNAME_combined_seqs.fn' file.
- Choose "Align"
- Align with "Alignment" -> "Align by ClustalW"
- Choose "OK" when prompted to select all.
- Leave default options, then "OK".
- Once the alignment finishes, delete overhanging sequences.
- Save alignment as a '.mas' file.
- Close alignment window.

## Choose DNA evolution model
- Open the '.mas' file, choose "Analyze".
- Yes to protein coding.
- "Models" -> "Find Best Protein/DNA Model"
- The model with the lowest BIC score is the best fit. Note any "+" items in the name, and their parameter values. E.g. +G means gamma distributed rate, with parameter value in a (+G) column.

## Compute Pairwise Distance Matrix
- "Distance" -> "Compute Pairwise Distances" 
- Use active data.
Use ~300 bootstrap replicates, and the best fit model (with gamma distributed rates if applicable).
