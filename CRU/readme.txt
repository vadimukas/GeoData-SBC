this project contains the R scripts, shapefiles for creation of climatological maps for Central Asia (CA), temperature, precipitation, potential evaporation (PET)
the project is organized in the structre
 - /Data - contains source ncdf files not on github due to the size must be downloaded in eg. https://crudata.uea.ac.uk/cru/data/hrg/cru_ts_4.04/cruts.2004151855.v4.04/
 the scripts are based on CRU TS version 4.03
 - /SHP - shapefile of the CA catchements, countries
 - /Data - netcdf files (not on github)
 - /plots - example plots from running the scripts
 
 Please pay attention to correction of the source directories 
 the scripts are in the root directory they differ in the following
 
 - temperature.R: this script is for climatological maps for air temperature for each season - e.g. Winter (DJF) etc # using CRU data from 1981 to 2010
 - temperature_catchment.R:  temperature_catchment.R: this script for mean seasonal ait temp for each seasone.g. Winter (DJF) etc # using CRU data from 1981 to 2010
 - precipitation.R : is for climatological maps for precipitation for each season - e.g. Winter (DJF) etc using CRU data from 1981 to 2010 for seasons - CA country perspective 
 - precipitation_annual.R  -  is for for climatological maps for annual mean precipitation for Central Asia in country perspective
 - precipitation_annual_catchment.R: - is for for climatological maps for precipitation for each season - e.g. Winter (DJF) etc using CRU data from 1981 to 2010 for glacierized catchments
 - PET_cathment.R: this script is  for annual potential evaporation (PET) for catchments of Central Asia using CRU data from 1981 to 2010

use gc() command to free memory in R studio

Jupyter notebook files 

Temperature.ipynb : as temperature.R
precipitation_annual_catchment.ipynb
PET_cathment.ipynb - PET_cathment.R  - bugs in rendering