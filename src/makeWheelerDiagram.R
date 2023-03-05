makeWheelerDiagram = function(distanceFromShore) {
  dist_from_shore_km = as.numeric(distanceFromShore)
  
  plot(
    NULL,
       ylim = range(t),
       xlim = c(0,max_dist_from_shore_km),
       xlab = "Distance from Shore [km]",
       ylab = "Time [Myr]"
    )
  
  rasterImage(
    wheeler_diagram,
              xleft = 0,
              xright = max_dist_from_shore_km,
              ybottom = 0, 
              ytop = max(t)
    )
  
  lines(
    x = rep(dist_from_shore_km,2),
    y = range(t),
    lty = wheeler_diagram_lty,
    lwd = wheeler_diagram_lwd,
    col = wheeler_diagram_col
  )
       
}
