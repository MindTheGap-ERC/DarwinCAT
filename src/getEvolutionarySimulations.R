getEvolutionarySimulations <- function(noOfSims, mode, ...) {
  noOfSims <- as.numeric(noOfSims)
  parameters <- list(...)
  
  # pre-allocate 
  evolutionarySimulationList <- vector("list",noOfSims)
  
  if (mode == "Random Walk") {
    sigma <- parameters[[1]]
    mu <- parameters[[2]]
    x0 <- parameters[[3]]
    standardDeviations <- sqrt(diff(time_myr))
   
    for (i in 1:noOfSims) {
      increments <- rnorm(
        n = length(time_myr) - 1,
        mean = 0,
        sd = standardDeviations
      )
      brownianMotionPath <- cumsum(c(0, increments))
      brownianDriftPath <- sigma * brownianMotionPath + mu * time_myr + x0
      evolutionarySimulationList[[i]] <- brownianDriftPath
    }
    return(evolutionarySimulationList)
  }
  if (mode == "Stasis") {
    mean <- parameters[[4]]
    variance <- parameters[[5]]
    for (i in 1:noOfSims) {
      stasisValues <- rnorm(
        n = length(time_myr),
        mean = mean,
        sd = sqrt(variance)
      )
      evolutionarySimulationList[[i]] <- stasisValues
    }
    return(evolutionarySimulationList)
  }
  if (mode == "Ornstein-Uhlenbeck") {
    mu <- parameters[[6]]
    theta <- parameters[[7]]
    sigma <- parameters[[8]]
    x0 <- parameters[[9]]
    for (i in 1:noOfSims) {
      noiseIncrements <- rnorm(
        n = length(time_myr) - 1,
        mean = 0,
        sd = sqrt(diff(time_myr))
      )
      ouval <- rep(NA, length(time_myr))
      ouval[1] <- x0
      for (j in 2:length(time_myr)) {
        ouval[j] <- ouval[j - 1] + 0.001 * (theta * (mu - ouval[j - 1])) +
          sigma * noiseIncrements[j - 1]
      }
      evolutionarySimulationList[[i]] <- ouval
    }
    return(evolutionarySimulationList)
  }
  stop("something went wrong with the evolutionary simulations")
  
}
