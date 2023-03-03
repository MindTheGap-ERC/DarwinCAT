makeStratDomainPlot <- function(ageDepthModel,
                                evolutionarySimulations,
                                ymin = -1,
                                ymax = 1,
                                trait_name = "",
                                plotSeaLevel = TRUE,
                                plot_hiatuses = TRUE) {
  

  
  # plot framwework
  plot(NULL,
    ylim = range(
      ageDepthModel$heightRaw,
      na.rm = TRUE,
      finite = TRUE
    ),
    xlim = c(ymin, ymax),
    ylab = "Height [m]",
    xlab = ""
  )

  mtext(
    text = trait_name,
    side = 1
  )

  # zero line
  lines(
    y = range(
      ageDepthModel$heightRaw,
      na.rm = TRUE,
      finite = TRUE
    ),
    x = c(0, 0),
    lwd = zero_axis_lwd,
    lty = zero_axis_lty,
    col = zero_axis_col
  )

  # plot evo sims in strat
  for (i in seq_along(evolutionarySimulations)) {
    lines(
      y = ageDepthModel$heightRaw,
      x = evolutionarySimulations[[i]],
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
