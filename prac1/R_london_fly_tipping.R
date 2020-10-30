library(rgdal)

library(sf)
shape <- st_read("/Users/tian/Desktop/CASA/0005 GIS/week1/statistical-gis-boundaries-london/ESRI/London_Borough_Excluding_MHW.shp")

summary(shape)

plot(shape)

shape %>% 
  st_geometry() %>%
  plot()


library(tidyverse)
mycsv <-  read_csv("/Users/tian/Desktop/CASA/0005 GIS/week1/pivot_table.csv",skip = 1)  
mycsv

shape <- shape%>%
  merge(.,
        mycsv,
        by.x="GSS_CODE", 
        by.y="行标签")

shape%>%
  head(., n=10)



library(tmap)
tmap_mode("plot")

shape %>%
  qtm(.,fill = "2011-12")



shape %>%
  st_write(.,"r_wk1.gpkg",
           "r_london_boroughs_fly_tipping",
           delete_layer=TRUE)



library(readr)
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(),dbname="r_wk1.gpkg")

con %>%
  dbListTables()

con %>%
  dbWriteTable(.,
               "original_csv",
               mycsv,
               overwrite=TRUE)

con %>% 
  dbDisconnect()