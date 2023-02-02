makeStratDomainPlot = function(ageDepthModel,evolutionarySimulations,plotSeaLevel,plotGaps){
  traitmin=sapply(evolutionarySimulations,min)
  traitmax=sapply(evolutionarySimulations,max)
  ymin=min(traitmin,0)
  ymax=max(traitmax,0)
  cols=c("seagreen","sienna","lightblue4")
  plot(NULL,
       ylim=range(ageDepthModel$heightRaw),
       xlim=c(ymin,ymax),
       ylab="Height [m]",
       xlab="")
  mtext("Trait Value",side = 1)
  lines(y=range(ageDepthModel$heightRaw),x=c(0,0),lwd=0.5,lty=3)
  for (i in 1:length(evolutionarySimulations)){
  lines(y=ageDepthModel$heightRaw,
       x=evolutionarySimulations[[i]],
       type="l",
       col=cols[i],
       lwd=2)
  }
  if(plotGaps==TRUE){
    for (i in 1:length(ageDepthModel$hiatusHeights)){
      lines(y=rep(ageDepthModel$hiatusHeights[i],2),
            x=c(ymin-1,ymax+1),
            col=grey(0.3))
    }
  }
  
  if (plotSeaLevel==TRUE){
    lines(y=ageDepthModel$heightRaw,
          x=seaLevel/max(seaLevel)*0.5*(ymax - ymin) + 0.5*(ymax + ymin),
          col="blue",
          lwd=2)
    
    mtext("Sea Level",side=3,col="blue")
    axis(side=3,at=c(ymin,0.5*(ymax + ymin),ymax),labels = c("Low","","High"))
    
  }
}