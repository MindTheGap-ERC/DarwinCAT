makeStratDomainPlot <- function(ageDepthModel,
                                evolutionarySimulations,
                                axis_limits = c(-1,1),
                                trait_name = "",
                                plotSeaLevel = TRUE,
                                plot_hiatuses = TRUE,
                                sampling_strategy = "Constant Distance",
                                no_of_samples = 10,
                                dist_between_samples = 1) {
  
  if (sampling_strategy == "Constant Distance") {
    sampling_locations = seq(
      from = min(ageDepthModel$heightRaw) + dist_between_samples,
      to = max(ageDepthModel$heightRaw),
      by = dist_between_samples
    )
  } else if (sampling_strategy == "Constant Number") {
    sampling_locations = seq(
      from = min(ageDepthModel$heightRaw),
      to = max(ageDepthModel$heightRaw),
      length.out = no_of_samples
    )
  } else {
    stop("Something went Wrong")
  }
  
  ymin = min(axis_limits)
  ymax = max(axis_limits)
  if (ymin == ymax){
    ymin = -1
    ymax = 1
  }
  

  
  # plot framwework
  plot(
    NULL,
    ylim = range(ageDepthModel$heightRaw),
    xlim = c(ymin, ymax),
    ylab = "Height [m]",
    xlab = "",
    type = "l"
  )

  mtext(
    text = trait_name,
    side = 1
  )

  # zero line
  lines(
    y = range(ageDepthModel$heightRaw),
    x = c(0, 0),
    lwd = zero_axis_lwd,
    lty = zero_axis_lty,
    col = zero_axis_col
  )

  # plot evo sims in strat
  for (i in seq_along(evolutionarySimulations)) {
    trait_vals = approx(x = ageDepthModel$heightRaw,
                        y = evolutionarySimulations[[i]],
                        xout = sampling_locations)
    lines(
      y = trait_vals$x,
      x = trait_vals$y,
      col = trait_cols[i],
      lwd = trait_cols[i],
      lty = trait_ltys[i]
    )
  }

  # plot hiatuses in strat
  if (plot_hiatuses) {
    for (i in seq_along(ageDepthModel$hiatusHeights)) {
      lines(
        y = rep(ageDepthModel$hiatusHeights[i], 2),
        x = c(ymin, ymax),
        col = hiatus_strat_col,
        lwd = hiatus_strat_lwd,
        lty = hiatus_strat_lty
      )
    }
  }

  if (plotSeaLevel) {
    lines(
      y = ageDepthModel$heightRaw,
      x = seaLevel / max(seaLevel) * 0.5 * (ymax - ymin) + 0.5 * (ymax + ymin),
      col = sl_col,
      lwd = sl_lwd,
      lty = sl_lty
    )

    mtext(
      text = "Sea Level",
      side = 3,
      col = sl_col
    )

    axis(
      side = 3,
      at = c(ymin, 0.5 * (ymax + ymin), ymax),
      labels = c("Low", "", "High")
    )
  }
}
