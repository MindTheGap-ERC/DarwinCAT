getEvolutionarySimulations <- function(noOfSims, mode, ...) {
  
  #' @title simulate trait evolution
  #' 
  #' @description
    #' Simulates evolution of traits along lineages according to different modes
    #' of evolution
  #' 
  #' @param noOfSims Integer, expressed as charcter (e.g. "2"). No of lineages
  #' simulated
  #' @param mode Character string, either "Random Walk", "Stasis", 
  #' or "Ornstein-Uhlenbeck". Specifies mode of evolution
  #' @param ... mumeric. parameters handed over to the simulation.
  #'  Entries 1-3 specify random walk. 
  #'  Entries 4-5 specify stasis
  #'  Entries 6-9 specify Ornstein-Uhlenbeck
  #'  
  #'  @returns a list with noOfSims entries. Every entry is a numeric vector of 
  #'  length(time_myr) and contains trait values at the times in the vector 
  #'  time_myr
  
  #### Transform input types ####
  noOfSims <- as.numeric(noOfSims)
  parameters <- list(...)
  
  #### pre-allocate return list ####
  evolutionarySimulationList <- vector("list",noOfSims)
  
  #### Simulate Random Walk ####
  if (mode == "Random Walk") {
    
    # simulation as a Wiener process with drift, see
    # https://en.wikipedia.org/w/index.php?title=Wiener_process&oldid=1142070662
    # see section "Characterization ..." or "Covariance..."
    sigma <- parameters[[1]]
    mu <- parameters[[2]]
    x0 <- parameters[[3]]
    standardDeviations <- sqrt(diff(time_myr))
   
    for (i in 1:noOfSims) {
      increments <- rnorm( #increments are normally  distributed
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
  
  #### Simulate Stasis ####
  if (mode == "Stasis") {
    #  simulation as independent, identically & normally distributed random 
    # variables with specified mean and variance
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
  
  #### Simulate Ornstein-Uhlenbeck ####
  if (mode == "Ornstein-Uhlenbeck") {
    # simulation via EUler-Maruyama method, see 
    # https://en.wikipedia.org/w/index.php?title=Euler%E2%80%93Maruyama_method&oldid=1135099937
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
  
  #### Throw error if incorrect mode is provided ####
  stop("Incorrect mode of evolution! Use \"Random Walk\", \"Stasis\", 
  or \"Ornstein-Uhlenbeck\".")
  
}
