library(icesTAF)
taf.library(icesFO)

ICES_ecoregions <- icesFO::load_ecoregions()

icesTAF::write.taf(ecoregions)

