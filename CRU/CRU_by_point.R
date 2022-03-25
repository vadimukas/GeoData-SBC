library(rgdal)
library(raster)
library(maptools)


setwd("C:/Users/zarin/Desktop/Map_for_paper_L/CRU/cru_data")
cru_pre1<-brick("cru_ts4.03.1991.2000.pre.dat.nc")
cru_pre2<-brick("cru_ts4.03.2001.2010.pre.dat.nc")

Location<-SpatialPoints(cbind(69.25, 53.25)) 
pre1_by_Location<-extract(cru_pre1,SpatialPoints(cbind(69.25, 53.25)))
pre2_by_Location<-extract(cru_pre2,SpatialPoints(cbind(69.25, 53.25)))

pre1_by_Location_text = as.data.frame(pre1_by_Location, xy=TRUE)
write.table(pre1_by_Location_text, file = 'pre1_1991_2000.txt', sep = ',')
