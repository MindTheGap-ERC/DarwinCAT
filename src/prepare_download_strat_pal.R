prepare_download_strat_pal = function(file, 
                                      transformed_ts,
                                      dist_from_shore_km,
                                      sampling_strategy,
                                      no_of_samples,
                                      dist_between_samples,
                                      trait_name, 
                                      mode, 
                                      ...)
{
  
  df = data.frame(strat_pos_m = transformed_ts[[1]]$pos, time_myr = transformed_ts[[1]]$time)
  for (i in seq_along(transformed_ts)){
    df[[paste("lineage_",i,"_",trait_name, sep = "")]]= transformed_ts[[i]]$val
  }
  
  
  
  metadata = rep("",length(transformed_ts[[1]]$pos))
  
  
  ## write samplling strategy
  if (sampling_strategy == "Fixed Number") {
    df[["sampling_strategy"]] = replace(metadata,1,"Fixed Number")
    df[["number_of_samples"]] = replace(metadata,1,no_of_samples)
    
  }
  if (sampling_strategy == "Fixed Distance") {
    df[["sampling_strategy"]] = replace(metadata,1,"Fixed Distance")
    df[["distance_between_samples_m"]] = replace(metadata,1,dist_between_samples)
  }
  
  ## write distance from shore
  df[["distance_from_shore_km"]] = replace(metadata,1,dist_from_shore_km)
  
  ## write evo params
  parameters <- list(...)
  if (mode == "Random Walk"){
    sigma <- parameters[[1]]
    mu <- parameters[[2]]
    x0 <- parameters[[3]]
    df[["mode_of_evolution"]] = replace(metadata,1,"Random Walk")
    
    df[["variability"]] = replace(metadata,1,sigma)
    df[["drift"]] = replace(metadata,1,mu)
    df[["initial_trait_value"]] = replace(metadata,1,x0)
    
    
  }
  if (mode == "Stasis") {
    mean <- parameters[[4]]
    variance <- parameters[[5]]
    
    df[["mode_of_evolution"]] = replace(metadata,1,"Stasis")
    
    df[["mean_trait_value"]] = replace(metadata,1,mean)
    df[["variance"]] = replace(metadata,1,variance)
    
    
  }
  
  if (mode == "Ornstein-Uhlenbeck") {
    mu <- parameters[[6]]
    theta <- parameters[[7]]
    sigma <- parameters[[8]]
    x0 <- parameters[[9]]
    
    df[["mode_of_evolution"]] = replace(metadata,1,"Ornstein-Uhlenbeck")
    
    df[["long_term_mean"]] = replace(metadata,1,mu)
    df[["pressure_of_selection"]] = replace(metadata,1,theta)
    df[["volatility"]] = replace(metadata,1,sigma)
    
    df[["initial_trait_value"]] = replace(metadata,1,x0)
    
  }
  
  df[["citation"]]= replace(metadata, 1, citation_text)
  
  write.csv(df, file = file)
}