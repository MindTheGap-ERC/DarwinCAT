getEvolutionarySimulations <- function(noOfSims, mode, ...) {
  noOfSims <- as.character(noOfSims)
  parameters <- list(...)
  if (mode == "Random Walk") {
    sigma <- parameters[[1]]
    mu <- parameters[[2]]
    x0 <- parameters[[3]]
    standardDeviations <- sqrt(diff(t))
    evolutionarySimulationList <- list()
    for (i in 1:noOfSims) {
      increments <- rnorm(
        n = length(t) - 1,
        mean = 0,
        sd = standardDeviations
      )
      brownianMotionPath <- cumsum(c(x0, increments))
      brownianDriftPath <- sigma * brownianMotionPath + mu * t
      evolutionarySimulationList[[i]] <- brownianDriftPath
    }
    return(evolutionarySimulationList)
  }
  if (mode == "Stasis") {
    mean <- parameters[[4]]
    variance <- parameters[[5]]
    evolutionarySimulationList <- list()
    for (i in 1:noOfSims) {
      stasisValues <- rnorm(
        n = length(t),
        mean = mean,
        sd = sqrt(variance)
      )
      evolutionarySimulationList[[i]] <- stasisValues
    }
    return(evolutionarySimulationList)
  }
  if (mode == "Ornstein-Uhlenbeck") {
    evolutionarySimulationList <- list()
    mu <- parameters[[6]]
    theta <- parameters[[7]]
    sigma <- parameters[[8]]
    x0 <- parameters[[9]]
    for (i in 1:noOfSims) {
      noiseIncrements <- rnorm(
        n = length(t) - 1,
        mean = 0,
        sd = sqrt(diff(t))
      )
      ouval <- rep(NA, length(t))
      ouval[1] <- x0
      for (j in 2:length(t)) {
        ouval[j] <- ouval[j - 1] + 0.001 * (theta * (mu - ouval[j - 1])) +
          sigma * noiseIncrements[j - 1]
      }
      evolutionarySimulationList[[i]] <- ouval
    }
    return(evolutionarySimulationList)
  }
  stop("something went wrong with the evolutionary simulations")
}
