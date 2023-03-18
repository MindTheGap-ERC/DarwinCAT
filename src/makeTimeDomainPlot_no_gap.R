makeTimeDomainPlot_no_gap <- function(evolutionarySimulations,
                                      axis_limits = c(-1, 1),
                                      trait_name = "") {
  # determine y axis limits
  ymin <- min(axis_limits)
  ymax <- max(axis_limits)
  if (ymin == ymax) {
    ymin <- -1
    ymax <- 1
  }

  # make empty plot
  plot(
    NULL,
    xlim = range(time_myr),
    ylim = c(ymin, ymax),
    xlab = "Time [Ma]",
    ylab = "",
    type = "l",
    main = "Trait Evolution"
  )

  # plot 0 line
  lines(
    x = range(time_myr),
    y = c(0, 0),
    col = zero_axis_col,
    lty = zero_axis_lty,
    lwd = zero_axis_lwd
  )

  # plot trait name
  mtext(
    text = trait_name,
    side = 2,
    line = 2.5
  )

  # plot traits
  for (i in seq_along(evolutionarySimulations)) {
    lines(
      x = time_myr,
      y = evolutionarySimulations[[i]],
      col = trait_cols[i],
      lwd = trait_lwds[i],
      lty = trait_ltys[i]
    )
  }
}
