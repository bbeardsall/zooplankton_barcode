library(bold)
library(seqinr)
suppressPackageStartupMessages(library(tidyverse))
source('src/bold_seq_functions.R')
library(optparse)

parser <- OptionParser()
parser <-
  add_option(
    parser,
    c('-i', '--input_excel', help = 'Path to species xlsx file', default =
        'data/species.xlsx')
  )
parser <-
  add_option(
    parser,
    c('-o', '--output_dir', help = 'Directory to save sequences', default =
        'out_sequences')
  )
parser <-
  add_option(parser,
             c("-g", '--group', type = 'character', help = 'Group to subset'))
parser <-
  add_option(parser, c("-m", "--max_sequences"), type = 'integer')

args <- parse_args(parser)

species_df <- readxl::read_excel(args$input_excel) %>%
  dplyr::filter(Group == args$group)

unique_species <- na.omit(unique(species_df$Species))

individual_seq_dir <- file.path(args$output_dir, "individual_seqs")
dir.create(individual_seq_dir,
           showWarnings = FALSE,
           recursive = TRUE)

for (taxon_name in unique_species[1:3]) {
  if (error_fetching_specimen(taxon_name)) {
    warning(paste('Taxon "', taxon_name, '" not found.', sep = ""))
    next
  }
  
  result_df <- bold_seqspec(taxon = taxon_name,
                            marker = 'COI-5P')
  
  if (!is.data.frame(result_df)) {
    next
  }
  print(taxon_name)
  
  species_df <-
    filter_seqspec_results(result_df, n_results = args$max_sequences)
  write_species_df_fasta(species_df, individual_seq_dir)
  
}

system2(
  "cat",
  args = file.path(individual_seq_dir, "*.fn"),
  stdout = file.path(
    args$output_dir,
    paste(args$group, '_combined_seqs.fn', sep = "")
  )
)