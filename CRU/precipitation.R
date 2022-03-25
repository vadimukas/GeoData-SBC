library(rgdal)
library(raster)
library(maptools)
library(ncdf4)
library(RColorBrewer)
library(maps)
library(lattice)
library(latticeExtra)
library(sf) 
library(rasterVis)
library(viridisLite)
library(viridis) 


# this script is for climatological maps for precipitation for each season - e.g. Winter (DJF) etc 
# using CRU data from 1981 to 2010
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

f_season<-function (m){
  if (m<3 | m==12) {return("1_DJF") }
  if (m>2 & m<6) {return ("2_MAM") }
  if (m>5 & m<9) {return ("3_JJA") }
  if (m>8 & m<12) {return ("4_SON")} 
  return ("X")
}



f_plot<-function(p,nm){
  colors<-c(c('white'),rev(viridis(100)))
  #c('white','yellow','lightsteelblue3','lightsteelblue4','blue')
   #brewer.pal(n = 40, name = "RdYlBu")
  
  
  year<-as.numeric(substr(names(p),2,5))
  length(year)
  month<-as.numeric(substr(names(p),7,8))
  length(month)
  season<-as.character(names(p))
  date<-ISOdate(year, month,1)
  p<-setZ(p, date)
  
  for(i in 1:length(season))
    season[i]<-paste(substr(season[i],2,5),f_season(as.numeric(substr(season[i],7,8))))
  length(season)
  
  p<-setZ(p,season, name='season')
  p_season<-zApply(p, by=season,fun = sum)
  y_season<-as.character(names(p_season)) 
  for(i in 1:length(y_season))
    y_season[i]<-substr(season[i],6,11)
 # print(y_season)
  
  p_season<-setZ(p_season,y_season, name='y_season')
  pp_season<-zApply(p_season, by=y_season,fun = mean)
  
  #ff_test(pp_season)
  
  #p_total<-setZ(p_total,month, name='month')
  #pp_season<-zApply(p_total, by=month,fun = mean)
   
  #plt + layer(sp.lines(world_outline, col="black", lwd=1.0))
  #plot(pp_season,
     # xlim = c(40, 95),
     # ylim = c(30, 60),
      #col=colors
      #zlim=c(0,300),
      #col=colorRampPalette(c('lightsteelblue4','lightsteelblue3','lightsteelblue2','lightsteelblue', 'white', 'tomato', 'tomato2', 'tomato3', 'tomato4'))(1000)
      # )
  #world_map<-readShapePoly("C:/Users/zarin/Desktop/CRU_data/TM_WORLD_BORDERS-0.2")
  #plot(world_map, add=T,
       #xlim = c(45, 88), 
       #ylim = c(35, 57)
  #)
  for(s in 1:nlayers(pp_season))
  #if (s>0 & s<nlayers(t_season)+1)
  {
    # z <- if(names(t_season[[s]])=="X1_DJF" | names(t_season[[s]])=="X4_SON" ) c(-20,20) else c(0,40)
    
    #/par(col.lab="red") 
   
    #image(pp_season[[s]], col = topo.colors(10), main = "topo.colors()")
    
    png(paste("PRE",as.character(s),".png"), width = 13.1, height = 10, units = 'in', res = 500)
    par(
      cex=1.4,
      mar=c(4.7,4.1,4.7,7)
      #mgp=c(5,1,3)
    )
    plot(
      pp_season[[s]],
      main=paste(nm,substr(names(pp_season[[s]]),4,6)),
      xlim = c(45, 88), 
      ylim = c(35, 57),
      zlim = c(0, 300),
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
  }
  
}

#f_plot(t_1,"1981-1990",1)
#f_plot(t_2,"1991-2000",3)
#f_plot(t_3,"2001-2010",3)
#f_plot(p_total,"TOTAL",1)

#for (i in 1:4)
#{
 f_plot(p_total,"")#,i)
#}

 warnings()

