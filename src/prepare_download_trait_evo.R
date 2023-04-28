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
  metadata = rep("",length(trait_series[[1]]$time))
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