makeAgeDepthModelPlot <- function(ageDepthModel) {
  plot(x = t,
       y = ageDepthModel$heightMod,
       type = "l",
       xlab = "Time [Ma]",
       ylab = "Height [m]",
       lwd = 3)
}
