makeStratDomainPlot = function(ageDepthModel,evolutionarySimulations,plotSeaLevel,plotGaps){
  traitmin=sapply(evolutionarySimulations,min)
  traitmax=sapply(evolutionarySimulations,max)
  ymin=min(traitmin,0)
  ymax=max(traitmax,0)
  plot(NULL,
       xlim=range(ageDepthModel$heightRaw),
       ylim=c(ymin,ymax),
       xlab="Height [m]",
       ylab="")
  mtext("Trait Value",side = 2)
  lines(x=range(ageDepthModel$heightRaw),y=c(0,0),lwd=0.5,lty=3)
  for (i in 1:length(evolutionarySimulations)){
  lines(x=ageDepthModel$heightRaw,
       y=evolutionarySimulations[[i]],
       type="l")
  }
  if(plotGaps==TRUE){
    for (i in 1:length(ageDepthModel$hiatusHeights)){
      lines(x=rep(ageDepthModel$hiatusHeights[i],2),
            y=c(ymin-1,ymax+1))
    }
  }
  
  if (plotSeaLevel==TRUE){
    lines(x=ageDepthModel$heightRaw,
          y=seaLevel/max(seaLevel)*0.5*(ymax - ymin) + 0.5*(ymax + ymin),
          col="blue")
    
    mtext("Sea Level",side=4,col="blue")
    axis(side=4,at=c(ymin,0.5*(ymax + ymin),ymax),labels = c("Low","","High"))
    
  }
}