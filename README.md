# zooplankton_barcode

## get_bold_seqs.R
Required packages: `bold`, `seqinr`, `tidyverse`, `optparse`

Retrieve Cytochrome c oxidase subunit I sequences from BOLD (Barcode Of Life Data System).

Example use:  
`Rscript get_bold_seqs.R -i data/species.xlsx -o test_out -g Salpida -m 1`

To view help, run:  
`Rscript get_bold_seqs.R -h`


## Alignment with MEGA 11
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
