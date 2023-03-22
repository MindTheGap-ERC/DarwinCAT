makeAgeDepthModelPlot <- function(ageDepthModel, 
                                  plot_time_gaps = TRUE, 
                                  plot_hiatuses = TRUE,
                                  dist_from_shore_km = NULL) {
  #' Generate Age-Depth- model plot
  #' 
  #' @description Takes an age-depth model and plots it
  #' 
  #' @return nothing
  #' 
  #
  # Make plot
  
  title_env = env_labels[which.min(abs(dist_from_shore_km-env_dist_from_shore_km))]
  plot(
    NULL,
    xlab = "Time [Ma]",
    ylab = "Height [m]",
    xlim = range(time_myr),
    ylim = range(ageDepthModel$heightRaw),
    type = "l",
    main = paste("Age-Depth Model ", dist_from_shore_km, " km from Shore (",title_env,")", sep = "")
  )
  
  # Plot time intervals that are not preserved
  if (plot_time_gaps) {
    for (i in seq_along(ageDepthModel$hiatusTimeList)) {
      rect(
        xleft = ageDepthModel$hiatusTimeList[[i]]$hiatusStart,
        xright = ageDepthModel$hiatusTimeList[[i]]$hiatusEnd,
        ybottom = 0,
        ytop = max(ageDepthModel$heightRaw),
        col = removed_time_col,
        lty = 0
      )
    }
  }
  
  # plot adm
  lines(
    x = time_myr, 
    y = ageDepthModel$heightMod,
    col = col_adm, 
    lwd = lwd_adm,
    lty = lty_adm
  )
  
  # plot hiatuses in strat domain
  if(plot_hiatuses){
    for (i in seq_along(ageDepthModel$hiatusHeights)){
      lines(
        y = rep(ageDepthModel$hiatusHeights[i],2),
        x = range(time_myr),
        col = hiatus_strat_col,
        lwd = hiatus_strat_lwd,
        lty = hiatus_strat_lty)
    }
  }
  
  
}
