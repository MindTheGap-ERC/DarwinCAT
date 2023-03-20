makeBasinTransectPlot <- function(distanceFromShore) {
  dist_from_shore_km <- as.numeric(distanceFromShore)

  # make empty plot
  plot(
    NULL,
    ylim = c(max_depth_basin_transect, 40), # max height,
    xlim = c(0, max_dist_from_shore_km),
    xlab = "Distance from Shore [km]",
    ylab = "Depth [m]",
    main = "Basin Transect",
    yaxt = "n"
  )
  
  # add y axis
  axis(
    side = 2,
    at = c(-200, -150, -100, -50, 0),
    labels = c(200, 150, 100, 50, 0))

  # insert empty image as background
  rasterImage(
    image = basin_transect,
    xleft = 0,
    xright = max_dist_from_shore_km,
    ybottom = max_depth_basin_transect,
    ytop = 0
  )
  
  # plot labels
  for (env_ind in seq_along(env_labels)){
    text(
      x = env_dist_from_shore_km[env_ind],
      y = env_label_y_pos_basin_transect,
      label = env_labels[env_ind]
    )
  }
  

  # mark position in basin
  lines(
    x = rep(dist_from_shore_km, 2),
    y = c(max_depth_basin_transect, 0),
    lty = basin_transect_lty,
    lwd = basin_transect_lwd,
    col = basin_transect_col
  )
}
