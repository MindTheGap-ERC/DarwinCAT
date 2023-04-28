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
    df[["Mode of Evolution"]] = replace(metadata,1,"Random Walk")
  
    df[["Variability"]] = replace(metadata,1,sigma)
    df[["Drift"]] = replace(metadata,1,mu)
    df[["Initial Trait Value"]] = replace(metadata,1,x0)

    
  }
  if (mode == "Stasis") {
    mean <- parameters[[4]]
    variance <- parameters[[5]]
    
    df[["Mode of Evolution"]] = replace(metadata,1,"Stasis")
    
    df[["Mean Trait Value"]] = replace(metadata,1,mean)
    df[["Variance"]] = replace(metadata,1,variance)

    
  }
  
  if (mode == "Ornstein-Uhlenbeck") {
    mu <- parameters[[6]]
    theta <- parameters[[7]]
    sigma <- parameters[[8]]
    x0 <- parameters[[9]]
    
    df[["Mode of Evolution"]] = replace(metadata,1,"Ornstein-Uhlenbeck")
    
    df[["Long term mean"]] = replace(metadata,1,mu)
    df[["Pressure of Selection"]] = replace(metadata,1,theta)
    df[["Volatility"]] = replace(metadata,1,sigma)

    df[["Initial Trait Value"]] = replace(metadata,1,x0)
    
  }
  
  df[["citation"]]= replace(metadata, 1, "Please use the citation given under https://doi.org/10.5281/zenodo.7851988")

  write.csv(df, file = file)
}