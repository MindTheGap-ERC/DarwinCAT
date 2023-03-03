makeTimeDomainPlot <- function(evolutionarySimulations, 
                               ageDepthModel, 
                               ymin,
                               ymax,
                               trait_name, 
                               plotSeaLevel = FALSE, plot_time_gaps = FALSE) {

  
  
  # plotting framework
  plot(NULL,
    xlim = range(t),
    ylim = c(ymin, ymax),
    xlab = "Time [Ma]",
    ylab = ""
  )
  
  # plot 0 axis
  lines(
    x = range(t),
    y = c(0, 0),
    col = zero_axis_col,
    lty = zero_axis_lty,
    lwd = zero_axis_lwd
    
  )
  
  # plot removed time intervals
  if (plot_time_gaps) {
    for (i in seq_along(ageDepthModel$hiatusTimeList)) {
      hiatusStart <- ageDepthModel$hiatusTimeList[[i]]$hiatusStart
      hiatusEnd <- ageDepthModel$hiatusTimeList[[i]]$hiatusEnd
      rect(
        xleft = hiatusStart,
        xright = hiatusEnd,
        ybottom = ymin,
        ytop = ymax,
        col = removed_time_col,
        lty = 0
      )
    }
  }
  
  
  
  mtext(
    text = trait_name,
    side = 2
  )
  
  for (i in seq_along(evolutionarySimulations)) {
    lines(
      x = t,
      y = evolutionarySimulations[[i]],
      col = trait_cols[i],
      lwd = trait_lwds[i],
      lty = trait_ltys[i]
    )
  }

  if (plotSeaLevel == TRUE) {
    lines(t, seaLevel / max(seaLevel) * 0.5 * (ymax - ymin) + 0.5 * (ymax + ymin),
      col = sl_col,
      lwd = sl_lwd,
      lty = sl_lty
    )
    mtext("Sea Level",
      side = 4,
      col = sl_col
    )
    axis(
      side = 4,
      at = c(ymin, 0.5 * (ymax + ymin), ymax),
      labels = c("Low", "", "High")
    )
  }
}
