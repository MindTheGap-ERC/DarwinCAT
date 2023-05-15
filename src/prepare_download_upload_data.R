prepare_download_upload_data = function(
    file,
    transformed_ts,
    dist_from_shore_km,
    sampling_strategy,
    no_of_samples,
    dist_between_samples,
    trait_name
) {
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