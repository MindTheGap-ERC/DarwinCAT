getAgeDepthModel = function(distanceFromShore){
  indexInList=10*distanceFromShore
  ageDepthModel=ageDepthModelList[[indexInList]]
  return(ageDepthModel)
}