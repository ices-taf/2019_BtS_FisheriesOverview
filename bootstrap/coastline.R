
require(rnaturalearth)
require(sf)

europe_shape <- rnaturalearth::ne_countries(scale = 10,
                                            type = "countries",
                                            continent = "europe",
                                            returnclass = "sf")[, c("iso_a3", "iso_n3",
                                                                    "admin", "geometry")]

sf::st_write(europe_shape, ".", "EUROPE_shape", driver="ESRI Shapefile")
