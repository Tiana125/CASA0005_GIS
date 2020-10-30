library(sp)
library(sf)
library(spData)        # load geographic data
library(spDataLarge)   # load larger geographic data

world_sp = as(world, Class = "Spatial")

plot(world["continent"], reset = FALSE)
cex = sqrt(world$pop) / 10000
world_cents = st_centroid(world, of_largest = TRUE)
plot(st_geometry(world_cents), add = TRUE, cex = cex)

world_asia = world[world$continent == "Asia", ]
india = world[world$name_long == "India", ]
plot(st_geometry(india), expandBB = c(0, 0.2, 0.1, 1), col = "gray", lwd = 3)
plot(world_asia[0], add = TRUE)

world_africa = world[world$continent == "Africa", ]
nigeria = world[world$name_long == "Nigeria", ]
#expandBB - bounding box; lwd - line width
plot(st_geometry(nigeria), expandBB = c(0.3, 0.5, 0.1, 1), col = "gray", lwd = 3)
plot(world_africa[0], add = TRUE)



plot(st_geometry(nigeria), col = "white", lwd = 3, main = "Nigeria in context", border = "lightgrey", expandBB = c(0.5, 0.2, 0.5, 0.2))

plot(st_geometry(world), lty = 3, add = TRUE, border = "grey")

plot(st_geometry(nigeria), col = "yellow", add = TRUE, border = "darkgrey")

a = world_africa[grepl("Niger", world_africa$name_long), ]
ncentre = st_centroid(a)
ncentre_num = st_coordinates(ncentre)
text(x = ncentre_num[, 1], y = ncentre_num[, 2], labels = a$name_long)
