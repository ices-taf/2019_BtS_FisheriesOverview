library(icesTAF)
taf.library(icesFO)

ecoregions <- icesFO::load_ecoregions("Baltic Sea")

sf::st_write(ecoregions, "ecoregions.csv", layer_options = "GEOMETRY=AS_WKT")
