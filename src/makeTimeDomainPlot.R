makeTimeDomainPlot <- function(evolutionarySimulations, 
                               ageDepthModel, 
                               axis_limits = c(-1,1),
                               trait_name = "", 
                               plotSeaLevel = FALSE, 
                               plot_time_gaps = FALSE) {
  ymin = min(axis_limits)
  ymax = max(axis_limits)
  if (ymin == ymax){
    ymin = -1
    ymax = 1
  }

  # plotting framework
  plot(
    NULL,
    xlim = range(time_myr),
    ylim = c(ymin, ymax),
    xlab = "Time [Ma]",
    ylab = "",
    type = "l",
    main = "Trait Evolution in Time Domain"
  )
  
  # plot 0 axis
  lines(
    x = range(time_myr),
    y = c(0, 0),
    col = zero_axis_col,
    lty = zero_axis_lty,
    lwd = zero_axis_lwd
  )
  
  # plot removed time intervals
  if (plot_time_gaps) {
    for (i in seq_along(ageDepthModel$hiatusTimeList)) {
      rect(
        xleft = ageDepthModel$hiatusTimeList[[i]]$hiatusStart,
        xright = ageDepthModel$hiatusTimeList[[i]]$hiatusEnd,
        ybottom = ymin,
        ytop = ymax,
        col = removed_time_col,
        lty = 0
      )
    }
  }
  
  
  mtext(
    text = trait_name,
    side = 2,
    line = 2.5
  )
  
  for (i in seq_along(evolutionarySimulations)) {
    lines(
      x = time_myr,
      y = evolutionarySimulations[[i]],
      col = trait_cols[i],
      lwd = trait_lwds[i],
      lty = trait_ltys[i]
    )
  }

  if (plotSeaLevel) {
    lines(
      x = time_myr, 
      y = seaLevel / max(seaLevel) * 0.5 * (ymax - ymin) + 0.5 * (ymax + ymin),
      col = sl_col,
      lwd = sl_lwd,
      lty = sl_lty
    )
    mtext(
      text = "Sea Level",
      side = 4,
      col = sl_col,
      line = 1
    )
    axis(
      side = 4,
      at = c(ymin, 0.5 * (ymax + ymin), ymax),
      labels = c("Low", "", "High"),
      col.ticks = sl_col,
      col.axis = sl_col
    )
  }
}
