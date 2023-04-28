prepare_download_strat_pal = function(file, 
                                      trait_series,
                                      ageDepthModel,
                                      dist_from_shore_km,
                                      sampling_strategy,
                                      no_of_samples,
                                      dist_between_samples,
                                      trait_name, 
                                      mode, 
                                      ...)
{
  if (sampling_strategy == "Fixed Distance") {
    sampling_locations <- seq(
      from = min(ageDepthModel$heightRaw) + dist_between_samples,
      to = max(ageDepthModel$heightRaw),
      by = dist_between_samples
    )
  } else if (sampling_strategy == "Fixed Number") {
    sampling_locations <- seq(
      from = min(ageDepthModel$heightRaw),
      to = max(ageDepthModel$heightRaw),
      length.out = no_of_samples
    )
  } else {
    stop("Unrecognized input value for parameter \"sampling strategy\".")
  }
  # times when the sampling locations are deposited
  times_of_deposition = approx(
    x = ageDepthModel$heightRaw,
    y = time_myr,
    xout = sampling_locations,
    yleft = 0,
    yright = 0,
    ties = "ordered"
  )$y
  
  df = data.frame(strat_pos_m = sampling_locations, time_myr = times_of_deposition)
  for (i in seq_along(trait_series)){
    df[[paste("lineage_",i,"_",trait_name, sep = "")]]=    approx(
      x = trait_series[[i]]$time,
      y = trait_series[[i]]$val,
      xout = times_of_deposition,
      yleft = 0,
      yright = 0,
      na.rm = FALSE,
      ties = "ordered"
    )$y
  }
  
  
  
  metadata = rep("",length(sampling_locations))
  
  
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