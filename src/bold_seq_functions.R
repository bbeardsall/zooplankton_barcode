filter_seqspec_results <- function(result_df, n_results = NULL) {
  result_df <- result_df %>%
    {
      if (!is.null(n_results))
        head(., n = n_results)
      else
        .
    } %>%
    filter(markercode == 'COI-5P') %>%
    mutate_all(~ str_replace_na(., '')) %>%
    mutate(
      fasta_name = paste(
        species_name,
        subspecies_name,
        markercode,
        sampleid,
        processid,
        sep = '|'
      )
    ) %>%
    filter(nchar(nucleotides) > 500)
  
  return(result_df)
}


write_species_df_fasta <- function(species_df, output_dir) {
  for (i in 1:nrow(species_df)) {
    seqinr::write.fasta(
      species_df$nucleotides[i],
      species_df$fasta_name[i],
      file.out = file.path(output_dir,
                           paste(species_df$fasta_name[i], ".fasta", sep = ''))
    )
  }
}

error_fetching_specimen <- function(taxon_name) {
  is_error <- FALSE
  
  tryCatch(
    specimens_df <- bold_specimens(taxon = taxon_name),
    error = function(error) {
      is_error <<- TRUE
    }
  )
  
  return(is_error)
}