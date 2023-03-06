load(file = "data/age_depth_models_for_shiny_app.Rdata")

# max depth for basin transect plot
max_depth_basin_transect <- -max(sapply(
  ageDepthModelList,
  function(x) max(x$heightRaw)
))

# cut off for sliders & adms
max_dist_from_shore_km <- 12 # maximum: 13 km

# load background images
wheeler_diagram <- readPNG("www/geology/wheeler_diagram.png")
basin_transect <- readPNG("www/geology/basin_transect.png")

# plot options: wheeler diagram
wheeler_diagram_lty <- 1
wheeler_diagram_lwd <- 1
wheeler_diagram_col <- "black"

# plot options: basin transect
basin_transect_lty <- 1
basin_transect_lwd <- 1
basin_transect_col <- "black"

# plot options: adm
col_adm <- "black"
lwd_adm <- 3
lty_adm <- 1

# plot options: removed time interval
removed_time_col <- grey(0.7)

# plot options: hiatus in strat domain
hiatus_strat_col <- grey(0.9)
hiatus_strat_lwd <- 3
hiatus_strat_lty <- 1

# plot options: sea level
sl_col <- "blue"
sl_lty <- 1
sl_lwd <- 3

# plot options: trait values
trait_cols <- c("seagreen", "sienna", "lightblue4")
trait_lwds <- rep(2, 3)
trait_ltys <- rep(1, 3)

# zero axis: plot options
zero_axis_col <- grey(0.2)
zero_axis_lty <- 3
zero_axis_lwd <- 1
