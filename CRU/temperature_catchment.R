library(rgdal)
library(raster)
library(maptools)
library(ncdf4)
#library(ncdf.tools)
library(RColorBrewer)

# temperature_catchment.R: this script for mean seasonal ait temp for each seasone.g. Winter (DJF) etc # using CRU data from 1981 to 2010

setwd("D:/R/CRU/")

#Open netcdf files using brick function
t_1<-brick("D:/R/CRU/Data/cru_ts4.03.1981.1990.tmp.dat.nc",varname="tmp")
t_2<-brick("D:/R/CRU/Data/cru_ts4.03.1991.2000.tmp.dat.nc",varname="tmp")
t_3<-brick("D:/R/CRU/Data/cru_ts4.03.2001.2010.tmp.dat.nc",varname="tmp")

t_total<-t_1
n<-nlayers(t_total)
for(i in 1:nlayers(t_2))
{
  t_total[[n+i]]<-t_2[[i]]
}
n<-nlayers(t_total)
for(i in 1:nlayers(t_3))
{
  t_total[[n+i]]<-t_3[[i]]
}

nlayers(t_total)

f_season<-function (m){
  if (m<3 | m==12) {return("1_DJF") }
  if (m>2 & m<6) {return ("2_MAM") }
  if (m>5 & m<9) {return ("3_JJA") }
  if (m>8 & m<12) {return ("4_SON")} 
  return ("X")
}

# the start of big plot chunk 
f_plot<-function(t,nm){
  colors<-c("brown2","white","cornflowerblue")
  #c('lightsteelblue4','lightsteelblue3','lightsteelblue2','lightsteelblue', 'white', 'tomato', 'tomato2', 'tomato3', 'tomato4')
  # brewer.pal(n = 40, name = "RdYlBu")
  
  
  year<-as.numeric(substr(names(t),2,5))
  length(year)
  month<-as.numeric(substr(names(t),7,8))
  length(month)
  season<-as.character(substr(names(t),7,8))
  date<-ISOdate(year, month,1)
  t<-setZ(t, date)
  
  for(i in 1:length(season))
    season[i]<-f_season(as.numeric(season[i]))
  length(season)
  
  #t<-setZ(t,month, name='month')
  #t_month<-zApply(t, by=month,fun=mean)
  #t<-setZ(t,year, name='year')
  #t_year<-zApply(t, by=year,fun=mean)
  t<-setZ(t,season, name='season')
  t_season<-zApply(t, by=season,fun = mean)
  
  #plot(t_season, xlim = c(40, 95), ylim = c(30, 60),col=colorRampPalette(c('lightsteelblue4','lightsteelblue3','lightsteelblue2','lightsteelblue', 'white', 'tomato', 'tomato2', 'tomato3', 'tomato4'))(1000))
  for(s in 1:nlayers(t_season))
    #if (s>0 & s<nlayers(t_season)+1)
  {
    # z <- if(names(t_season[[s]])=="X1_DJF" | names(t_season[[s]])=="X4_SON" ) c(-20,20) else c(0,40)
    
    #/par(col.lab="red") 
    png(paste("TMP_catchment",as.character(s),".png"), width = 13.8, height = 8, units = 'in', res = 500)
    par(
      cex=1.4,
      mar=c(4.7,4.1,4.7,7)
      #mgp=c(5,1,3)
    )
    plot(
      t_season[[s]],
      
      main=paste(nm,substr(names(t_season[[s]]),4,6)),
      xlim = c(55, 100), 
      ylim = c(33, 50),
      zlim= c(-30, 40),
      xlab="longitude",
      ylab="latitude",
      col=colorRampPalette(rev(colors))(1000)
    )
    #world_map<-readShapePoly("D:/R/CRU/SHP/TM_WORLD_BORDERS-0.2")
    #plot(world_map, add=T,
         #xlim = c(45, 88), 
         #ylim = c(35, 57)
    #)
    Alakol<-readShapePoly("D:/R/CRU/SHP/Alakol_basin_HS")
    plot(Alakol, add=T)
    Amu_darya<-readShapePoly("D:/R/CRU/SHP/amu_darya_basin")
    plot(Amu_darya, add=T)
    #Chu<-readShapePoly("D:/R/CRU/SHP//chu_river_basin_HS")
    #plot(Chu, add=T)
    Chu_talas<-readShapePoly("D:/R/CRU/SHP/chu_talas_river_basins_HS")
    plot(Chu_talas, add=T)
    #Helmand<-readShapePoly("D:/R/CRU/SHP/Helmand_HS")
    #plot(Helmand, add=T)
    Ile_b_a<-readShapePoly("D:/R/CRU/SHP/Ili-Balkhash_Alakol_HS")
    plot(Ile_b_a, add=T)
    Ile_b<-readShapePoly("D:/R/CRU/SHP/Ili-Balkhash_HS")
    plot(Ile_b, add=T)
    #Issyk_kul<-readShapePoly("D:/R/CRU/SHP/Issyk-Kul_basin_HS")
    #plot(Issyk_kul, add=T)
    syr_darya<-readShapePoly("D:/R/CRU/SHP/syr_darya_basin")
    plot(syr_darya, add=T)
    Tarim<-readShapePoly("D:/R/CRU/SHP/Tarim_HS")
    plot(Tarim, add=T)
    
    dev.off()
    
  }
  
}

#f_plot(t_1,"1981-1990",1)
#f_plot(t_2,"1991-2000",3)
#f_plot(t_3,"2001-2010",3)

f_plot(t_total,"")#,1)

#for (i in 1:4)
#{
# f_plot(t_total,"TT",i)
#}

warnings()
