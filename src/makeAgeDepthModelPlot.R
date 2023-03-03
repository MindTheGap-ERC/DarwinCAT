makeAgeDepthModelPlot <- function(ageDepthModel, 
                                  plot_time_gaps = TRUE, 
                                  plot_hiatuses = TRUE) {
  #' Generate Age-Depth- model plot
  #' 
  #' @description Takes an age-depth model and plots it
  #' 
  #' @return nothing
  #' 
  #
  # Make plot
  plot(
    NULL,
    type = "l",
    xlab = "Time [Ma]",
    ylab = "Height [m]",
    xlim = range(t),
    ylim = range(ageDepthModel$heightMod, na.rm = TRUE, finite = TRUE)
  )
  
  # Plot time intervals that are not preserved
  if (plot_time_gaps) {
    for (i in seq_along(ageDepthModel$hiatusTimeList)) {
      hiatusStart <- ageDepthModel$hiatusTimeList[[i]]$hiatusStart
      hiatusEnd <- ageDepthModel$hiatusTimeList[[i]]$hiatusEnd
      rect(
        xleft = hiatusStart,
        xright = hiatusEnd,
        ybottom = 0,
        ytop = max(ageDepthModel$heightMod, na.rm = TRUE),
        col = removed_time_col,
        lty = 0
      )
    }
  }
  
  # plot adm
  lines(
    x = t, 
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
        x = range(t),
        col = hiatus_strat_col,
        lwd = hiatus_strat_lwd,
        lty = hiatus_strat_lty)
    }
  }
  
}
