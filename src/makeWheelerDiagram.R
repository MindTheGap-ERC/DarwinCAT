makeWheelerDiagram <- function(distanceFromShore) {
  
  dist_from_shore_km <- as.numeric(distanceFromShore)

  # create empty plot
  plot(
    NULL,
    ylim = c(min(time_myr), max(time_myr)+0.3),
    xlim = c(0, max_dist_from_shore_km),
    xlab = "Distance from Shore [km]",
    ylab = "Time [Myr]",
    main = "Wheeler Diagram",
    yaxt = "n"
  )

  # insert wheeler diagram as background
  rasterImage(
    image = wheeler_diagram,
    xleft = 0,
    xright = max_dist_from_shore_km,
    ybottom = 0,
    ytop = max(time_myr)
  )
  
  axis(
    side = 2,
    at = c(0, 0.5, 1, 1.5, 2),
    labels = TRUE
  )
  # mark position in basin
  lines(
    x = rep(dist_from_shore_km, 2),
    y = range(time_myr),
    lty = wheeler_diagram_lty,
    lwd = wheeler_diagram_lwd,
    col = wheeler_diagram_col
  )
  
  # plot labels
  for (env_ind in seq_along(env_labels)){
    text(
      x = env_dist_from_shore_km[env_ind],
      y = env_label_y_pos_wheeler,
      label = env_labels[env_ind]
    )
  }
  
}
