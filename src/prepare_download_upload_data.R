prepare_download_upload_data = function(
    file,
    transformed_ts,
    dist_from_shore_km,
    sampling_strategy,
    no_of_samples,
    dist_between_samples,
    trait_name
) {
  
  #' @title prepare_download_strat_pal
  #'
  #' @description generates csv file for download in data upload tab
  #'
  #' @param file path of temp file
  #' @param transformed_ts output generated by function transfrom_ts
  #' @param dist_from_shore_km distance from shore in km
  #' @param sampling_strategy CHaracter string, either "Fixed Distance"
  #'  or "Fixed Number"
  #' @param no_of_samples positive integer. Number of samples taken
  #' along the strat column
  #' @param dist_between_samples positive scalar. Distance between
  #' samples in strat column (in meter)
  #' @param trait_name character string, name of trait

  #' @return a csv file
  
  
  ## Generate data frame
  ## write strat. position and time
  df <- data.frame(strat_pos_m = transformed_ts[[1]]$pos, time_myr = transformed_ts[[1]]$time)
  # write trait values of all lineages
  for (i in seq_along(transformed_ts)) {
    df[[paste("lineage_", i, "_", trait_name, sep = "")]] <- transformed_ts[[i]]$val
  }
  
  ## add metadata to file
  metadata <- rep("", length(transformed_ts[[1]]$pos))
  
  # sampling strategy
  if (sampling_strategy == "Fixed Number") {
    df[["sampling_strategy"]] <- replace(metadata, 1, "Fixed Number")
    df[["number_of_samples"]] <- replace(metadata, 1, no_of_samples)
  }
  if (sampling_strategy == "Fixed Distance") {
    df[["sampling_strategy"]] <- replace(metadata, 1, "Fixed Distance")
    df[["distance_between_samples_m"]] <- replace(metadata, 1, dist_between_samples)
  }
  
  # distance from shore
  df[["distance_from_shore_km"]] <- replace(metadata, 1, dist_from_shore_km)
  # citation
  df[["citation"]] <- replace(metadata, 1, citation_text)
  
  ## generate file for dowload
  write.csv(df, file = file, row.names = TRUE)
  
}