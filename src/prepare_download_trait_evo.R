prepare_download_trait_evo = function(file, 
                                      trait_series, 
                                      trait_name, 
                                      mode, 
                                      ...)
  {
  df = data.frame(time_myr = trait_series[[1]]$time)
  for (i in seq_along(trait_series)){
    df[[paste("lineage_",i,"_",trait_name, sep = "")]]=trait_series[[i]]$val
  }
  write.csv(df, file = file)
}