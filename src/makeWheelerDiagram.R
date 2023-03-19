makeWheelerDiagram <- function(distanceFromShore) {
  
  dist_from_shore_km <- as.numeric(distanceFromShore)

  # create empty plot
  plot(
    NULL,
    ylim = range(time_myr),
    xlim = c(0, max_dist_from_shore_km),
    xlab = "Distance from Shore [km]",
    ylab = "Time [Myr]",
    main = "Wheeler Diagram"
  )

  # insert wheeler diagram as background
  rasterImage(
    image = wheeler_diagram,
    xleft = 0,
    xright = max_dist_from_shore_km,
    ybottom = 0,
    ytop = max(time_myr)
  )

  # mark position in basin
  lines(
    x = rep(dist_from_shore_km, 2),
    y = range(time_myr),
    lty = wheeler_diagram_lty,
    lwd = wheeler_diagram_lwd,
    col = wheeler_diagram_col
  )
}
