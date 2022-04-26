library(bold)
library(seqinr)
suppressPackageStartupMessages(library(tidyverse))

source('bold_seq_functions.R')

species_excel <- 'species.xlsx'
out_dir <- 'sequences'
max_results <- 1
GROUP <- "Calanoida"

species_df <- readxl::read_excel(species_excel) %>%
  dplyr::filter(Group == GROUP)

unique_species <- na.omit(unique(species_df$Species))

individual_seq_dir <- file.path(out_dir, "individual_seqs")
dir.create(individual_seq_dir, showWarnings = FALSE, recursive=TRUE)

for (taxon_name in unique_species[1:10]) {

  if (error_fetching_specimen(taxon_name)) {
    warning(paste('Taxon "', taxon_name, '" not found.', sep=""))
    next
  }
  
  result_df <- bold_seqspec(taxon = taxon_name,
                            marker = 'COI-5P')
  
  if (!is.data.frame(result_df)) {next}
  print(taxon_name)
  
  species_df <- filter_seqspec_results(result_df, n_results = max_results)
  write_species_df_fasta(species_df, individual_seq_dir)
  
}

system2("cat",
        args=file.path(individual_seq_dir, "*.fn"),
        stdout=file.path(out_dir, paste(GROUP, '_combined_seqs.fn', sep = ""))
)