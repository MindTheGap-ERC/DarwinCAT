getAgeDepthModel <- function(distanceFromShore) {
  #' Load age-depth models from data
  #' 
  #' @description  This function loads the age-depth models from the work space
  #' 
  #' @param distanceFromShore numeric, km. location of the age-depth model
  #' 
  #' @return A list with fields "heightMod" and "time
  #' 
  indexInList <- 10 * distanceFromShore
  ageDepthModel <- ageDepthModelList[[indexInList]]
  return(ageDepthModel)
}
