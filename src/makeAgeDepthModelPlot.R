makeAgeDepthModelPlot <- function(ageDepthModel) {
  #' Generate Age-Depth- model plot
  #' 
  #' @description Takes an age-depth model and plots it
  #' 
  #' @return nothing
  #' 
  plot(x = t,
       y = ageDepthModel$heightMod,
       type = "l",
       xlab = "Time [Ma]",
       ylab = "Height [m]",
       lwd = 3)
}
