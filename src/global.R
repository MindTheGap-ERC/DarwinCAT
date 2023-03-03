load(file = "data/ageDepthModelsForShinyApp.RData")

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
zero_axis_lwd <- 0.5
