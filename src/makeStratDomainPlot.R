makeStratDomainPlot = function(ageDepthModel, 
                               evolutionarySimulations, 
                               ymin, 
                               ymax, 
                               trait_name,
                               plotSeaLevel = TRUE, 
                               plot_hiatuses = TRUE){

  
  # plot framwework
  plot(NULL,
       ylim=range(ageDepthModel$heightRaw),
       xlim=c(ymin,ymax),
       ylab="Height [m]",
       xlab="")
  
  mtext(trait_name,side = 1)
  
  lines(
    y=range(ageDepthModel$heightRaw), 
    x=c(0,0), 
    lwd=0.5, 
    lty=3)
  
  # plot evo sims in strat
  for (i in 1:length(evolutionarySimulations)){
    lines(
      y=ageDepthModel$heightRaw,
      x=evolutionarySimulations[[i]],
      type="l",
      col=trait_cols[i],
      lwd=trait_cols[i],
      lty = trait_ltys[i])
  }
  
  # plot hiatuses in strat
  if(plot_hiatuses){
    for (i in 1:length(ageDepthModel$hiatusHeights)){
      lines(y=rep(ageDepthModel$hiatusHeights[i],2),
            x=c(ymin-1,ymax+1),
            col=hiatus_strat_col,
            lwd = hiatus_strat_lwd,
            lty = hiatus_strat_lty)
    }
  }
  
  if (plotSeaLevel){
    lines(
      y=ageDepthModel$heightRaw,
      x=seaLevel/max(seaLevel)*0.5*(ymax - ymin) + 0.5*(ymax + ymin),
      col = sl_col,
      lwd = sl_lwd, 
      lty = sl_lty)
    
    mtext(
      text = "Sea Level", 
      side = 3, 
      col = sl_col)
    
    axis(
      side = 3, 
      at = c(ymin,0.5*(ymax + ymin),ymax),
      labels = c("Low","","High"))
    
  }
}