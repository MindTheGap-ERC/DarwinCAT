getAgeDepthModel <- function(distanceFromShore) {
  #' @title get age-depth models
  #' 
  #' @description loads the age-depth models from the work space
  #' 
  #' @param distanceFromShore numeric, km. location of the age-depth model
  #' 
  #' @return A list containing age depth model data
  #' 
  
  # convert distance from shore to list indices
  indexInList <- 10 * distanceFromShore
  
  ageDepthModel <- ageDepthModelList[[indexInList]]
  
  return(ageDepthModel)
}
