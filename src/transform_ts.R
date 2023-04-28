transform_ts = function(
    ageDepthModel,
    ts_list,
    sampling_strategy,
    no_of_samples,
    dist_between_samples
) {
  
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
  
  transformed_ts = list()
  #### plot evolutionary  simulations ####
  for (i in seq_along(ts_list)) {
    # see Hohmann (2021) https://doi.org/10.2110/palo.2020.038 
    # for theoretical background
    trait_vals <- approx(
      x = ts_list[[i]]$time,
      y = ts_list[[i]]$val,
      xout = times_of_deposition,
      yleft = 0,
      yright = 0,
      na.rm = FALSE,
      ties = "ordered"
    )$y
    
    transformed_ts[[i]] = list(pos = sampling_locations,
                               time = times_of_deposition,
                               val = trait_vals)

  }
  
  return(transformed_ts)
  
}