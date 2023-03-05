load(file = "data/age_depth_models_for_shiny_app.Rdata")

max_dist_from_shore_km = 12

wheeler_diagram = readPNG("www/geology/wheeler_diagram.png")
basin_transect = readPNG("www/geology/basin_transect.png")

wheeler_diagram_lty = 1
wheeler_diagram_lwd = 1
wheeler_diagram_col = "black"
  
basin_transect_lty = 1
basin_transect_lwd = 1
basin_transect_col = "black"

# Age-depth model plot options
col_adm <- "black"
lwd_adm <- 3
lty_adm <- 1

# removed time interval plot options
removed_time_col <- grey(0.7)

# hiatus strat plot options
hiatus_strat_col <- grey(0.9)
hiatus_strat_lwd <- 3
hiatus_strat_lty <- 1

# sea level plot options
sl_col <- "blue"
sl_lty <- 1
sl_lwd <- 3

# trait simulation plotting options
trait_cols <- c("seagreen", "sienna", "lightblue4")
trait_lwds <- rep(2, 3)
trait_ltys <- rep(1, 3)

# plot option zero axis
zero_axis_col <- grey(0.2)
zero_axis_lty <- 3
zero_axis_lwd <- 1
