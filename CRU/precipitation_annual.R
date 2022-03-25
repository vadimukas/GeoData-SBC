library(rgdal)
library(raster)
library(maptools)
library(ncdf4)
#library(ncdf.tools)
library(RColorBrewer)
library(maps)
library(lattice)
library(latticeExtra)
library(sf) 
library(rasterVis)
library(viridisLite)
library(viridis) 

# this script is  for annual precipitation 
setwd("D:/R/CRU/")

p_1<-brick("D:/R/CRU/Data/cru_ts4.03.1981.1990.pre.dat.nc",varname="pre")
p_2<-brick("D:/R/CRU/Data/cru_ts4.03.1991.2000.pre.dat.nc",varname="pre")
p_3<-brick("D:/R/CRU/Data/cru_ts4.03.2001.2010.pre.dat.nc",varname="pre")


p_total<-p_1

n<-nlayers(p_total)
for(i in 1:nlayers(p_2))
{
  p_total[[n+i]]<-p_2[[i]]
}
n<-nlayers(p_total)
for(i in 1:nlayers(p_3))
{
  p_total[[n+i]]<-p_3[[i]]
}

nlayers(p_total)



f_plot<-function(p,nm){
  colors<-c(c('white'),rev(viridis(100)))
    #c("brown2","white","cornflowerblue")
    c('white','yellow','lightsteelblue3','lightsteelblue4','blue')
  #brewer.pal(n = 40, name = "RdYlBu")
  
  
  year<-as.numeric(substr(names(p),2,5))
  length(year)
  month<-as.numeric(substr(names(p),7,8))
  length(month)
  date<-ISOdate(year, month,1)
  p<-setZ(p, date)
  
  #for(i in 1:length(season))
   # season[i]<-paste(substr(season[i],2,5),f_season(as.numeric(substr(season[i],7,8))))
  #length(season)
  
  p<-setZ(p,year, name='year')
  p_year<-zApply(p, by=year,fun = sum)
  #y_year<-as.character(names(p_year)) 
  #for(i in 1:length(y_year))
  #  y_year[i]<-substr(season[i],6,11)
  # print(y_season)
  
  print(p_year)
  
  pp_year<-zApply(p_year, by=0,fun = mean)
  #plot(pp_year,
   #    xlim = c(40, 95),
    #   ylim = c(30, 60),
     #  col=colors
       #zlim=c(0,300),
       #col=colorRampPalette(c('lightsteelblue4','lightsteelblue3','lightsteelblue2','lightsteelblue', 'white', 'tomato', 'tomato2', 'tomato3', 'tomato4'))(1000)
  #)
  
  #for(s in 1:nlayers(pp_year))
   
  #{
    png("PRE_Y.png", width = 13.1, height = 10, units = 'in', res = 500)
    par(
        cex=1.4,
        mar=c(4.7,4.1,4.7,7)
        #mgp=c(5,1,3)
        )
    plot(
      pp_year,
      main=nm,
      #ann=FALSE,
      #type='n',
      #xaxt='n',
      #yaxt='n',
      xlim = c(45, 88), 
      ylim = c(35, 57),
      xlab="longitude",
      ylab="latitude",
      col=colors,
      #scales=list(0,25,50,75,100,125,150,175,200,225,250),
      #zlim =c(0,300),
      #col = heat.colors(50)
      #scale=c(0,250)
      #col=colorRampPalette(rev(colors))(1000)
    )
    # ggsave("test.png", units="in", dpi=300, compression = 'lzw')
    world_map<-readShapePoly("D:/R/CRU/SHP/TM_WORLD_BORDERS-0.2")
    plot(world_map, add=T,
         #xlim = c(45, 88), 
         #ylim = c(35, 57)
    )
    
    
    dev.off()
  #}
  
}


f_plot(p_total,"")



