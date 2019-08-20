library(sf)
library(rgdal)

get_map <- function(URL) {
        tmp_file <- tempfile(fileext = ".zip")
        download.file(url = URL,
                      destfile = tmp_file,
                      mode = "wb", quiet = TRUE)
        unzip(tmp_file, exdir = tmp_path)
}

tmp_path <- tempdir()
get_map("http://gis.ices.dk/shapefiles/ICES_areas.zip")
layer_name <- grep("ICES_Areas", gsub("\\..*", "", list.files(tmp_path)), value = TRUE)[1]
ices_shape <- sf::st_read(dsn = tmp_path, layer = layer_name, quiet = FALSE)

writeOGR(ices_shape, ".", "ICES_shape", driver="ESRI Shapefile")

tmp_path <- tempdir()
get_map("http://gis.ices.dk/shapefiles/ICES_ecoregions.zip")
layer_name <- grep("ICES_ecoregions", gsub("\\..*", "", list.files(tmp_path)), value = TRUE)[1]
eco_shape <- sf::st_read(dsn = tmp_path, layer = layer_name, quiet = FALSE)

rgdal::writeOGR(eco_shape, ".", "ECOREGIONS_shape", driver="ESRI Shapefile")

europe_shape <- rnaturalearth::ne_countries(scale = 10,
                                            type = "countries",
                                            continent = "europe",
                                            returnclass = "sf")[, c("iso_a3", "iso_n3",
                                                                    "admin", "geometry")]

rgdal::writeOGR(europe_shape, ".", "EUROPE_shape", driver="ESRI Shapefile")

