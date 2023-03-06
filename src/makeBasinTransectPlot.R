makeBasinTransectPlot <- function(distanceFromShore) {
  dist_from_shore_km <- as.numeric(distanceFromShore)

  # make empty plot
  plot(
    NULL,
    ylim = c(max_depth_basin_transect, 0), # max height,
    xlim = c(0, max_dist_from_shore_km),
    xlab = "Distance from Shore [km]",
    ylab = "Depth [m]"
  )

  # insert empty image as background
  rasterImage(
    image = basin_transect,
    xleft = 0,
    xright = max_dist_from_shore_km,
    ybottom = max_depth_basin_transect,
    ytop = 0
  )

  # mark position in basin
  lines(
    x = rep(dist_from_shore_km, 2),
    y = c(max_depth_basin_transect, 0),
    lty = basin_transect_lty,
    lwd = basin_transect_lwd,
    col = basin_transect_col
  )
}
