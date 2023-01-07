makeTimeDomainPlot=function(evolutionarySimulations,ageDepthModel,plotSeaLevel,plotGaps){
  traitmin=sapply(evolutionarySimulations,min)
  traitmax=sapply(evolutionarySimulations,max)
  ymin=min(traitmin,0)
  ymax=max(traitmax,0)
  plot(NULL,
       xlim=c(0,2),
       ylim=c(ymin,ymax),
       xlab="Time [Ma]",
       ylab="")
  if (plotGaps==TRUE){
    for (i in 1:length(ageDepthModel$hiatusTimeList)){
      hiatusStart=ageDepthModel$hiatusTimeList[[i]]$hiatusStart
      hiatusEnd=ageDepthModel$hiatusTimeList[[i]]$hiatusEnd
      rect(xleft=hiatusStart,
           xright=hiatusEnd,
           ybottom=ymin,
           ytop=ymax,
           col=grey(0.5),
           lty=0)
    }
  }
  lines(x=range(t),y=c(0,0),lwd=0.5,lty=3)
  mtext("Trait Value", side=2)
  for (i in 1:length(evolutionarySimulations)){
    lines(t,evolutionarySimulations[[i]])
  }
  
  if (plotSeaLevel==TRUE){
    lines(t,seaLevel/max(seaLevel)*0.5*(ymax - ymin) + 0.5*(ymax + ymin),col="blue")
    mtext("Sea Level",side=4,col="blue")
    axis(side=4,at=c(ymin,0.5*(ymax + ymin),ymax),labels = c("Low","","High"))
  }
}