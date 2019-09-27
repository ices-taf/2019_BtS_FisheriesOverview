library(icesTAF)
taf.library(icesFO)

ICES_areas <- icesFO::load_areas()

icesTAF::write.taf(areas)

