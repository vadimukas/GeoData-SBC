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

# this script is  for annual potential evaporation (PET) for catchments of Central Asia 
setwd("D:/R/CRU/")

# extract the data from CRU using brick () function 
p_1<-brick("D:/R/CRU/Data/cru_ts4.03.1981.1990.pet.dat.nc",varname="pet")
p_2<-brick("D:/R/CRU/Data/cru_ts4.03.1991.2000.pet.dat.nc",varname="pet")
p_3<-brick("D:/R/CRU/Data/cru_ts4.03.2001.2010.pet.dat.nc",varname="pet")

# each layer here is where PET is in mm a day for a month, so we multiply each layer iteratively by 30 days
# for all three layers (in this case) iteratively using loop
p_total<-30*p_1
n<-nlayers(p_total)
for(i in 1:nlayers(p_2))
{
  p_total[[n+i]]<-30*p_2[[i]]
}
n<-nlayers(p_total)
for(i in 1:nlayers(p_3))
{
  p_total[[n+i]]<-30*p_3[[i]]
}
nlayers(p_total)

# final big chunk of the code constructs a plot of mean annul total PET from 1981 to 2010 (30 years)
#NB: it shoudl be run in one go in Jupyter 
f_plot<-function(p,nm){
  #colors<-c(c('white'), rainbow(100))
  #c("brown2","white","cornflowerblue")
  #c('white','yellow','lightsteelblue3','lightsteelblue4','blue')
  #brewer.pal(n = 40, name = "RdYlBu")
  colors<-brewer.pal(n=15, name="RdYlBu")
  
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
  png("PET_Y_catchment.png", width = 13.8, height = 8, units = 'in', res = 500)
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
    xlim = c(55, 100), 
    ylim = c(33, 50),
    zlim= c(0, 1800),
    #xlab="longitude",
    #ylab="latitude",
    col=colors,
    #scales=list(0,25,50,75,100,125,150,175,200,225,250),
    #zlim =c(0,300),
    #col = heat.colors(50)
    #scale=c(0,250)
    #col=colorRampPalette(rev(colors))(1000)
  )
  # ggsave("test.png", units="in", dpi=300, compression = 'lzw')
  
  #world_map<-readShapePoly("D:/R/CRU/SHP/TM_WORLD_BORDERS-0.2")
  #plot(world_map, add=T,
  #xlim = c(45, 88), 
  #ylim = c(35, 57)
  #)
  Alakol<-readShapePoly("D:/R/CRU/SHP/Alakol_basin_HS")
  plot(Alakol, add=T)
  Amu_darya<-readShapePoly("D:/R/CRU/SHP/amu_darya_basin")
  plot(Amu_darya, add=T)
  #Chu<-readShapePoly("D:/R/CRU/SHP/chu_river_basin_HS")
  #plot(Chu, add=T)
  Chu_talas<-readShapePoly("D:/R/CRU/SHP/chu_talas_river_basins_HS")
  plot(Chu_talas, add=T)
  #Helmand<-readShapePoly("D:/R/CRU/SHP/CRU_data/Helmand_HS")
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

# here come the plot
f_plot(p_total,"")

