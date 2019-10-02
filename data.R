
# Initial formatting of the data

taf.library(icesFO)
require(dplyr)
mkdir("data")

# 1: ICES official cath statistics

hist <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_historical_catches.csv")
official <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_2006_2017_catches.csv")
prelim <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_preliminary_catches.csv")

catch_dat <- icesFO::format_catches(2019, "Baltic Sea Ecoregion", hist, official, prelim)

write.taf(catch_dat, file = "data/catch_dat.csv", quote = TRUE)

# 2: STECF effort and landings

effort <- read.taf("bootstrap/data/STECF_effort.csv")
library(readr)
landings <- read_csv("bootstrap/initial/data/STECF_landings.csv")

frmt_effort <- format_stecf_effort(effort)
effort <- dplyr::rename(effort,
                 regulated.area = `regulated area`,
                 regulated.gear = `regulated gear`)
frmt_effort <- format_stecf_effort(effort)
frmt_landings <- format_stecf_landings(landings)
names(landings)
landings <- dplyr::rename(landings,
                        regulated.area = `regulated area`,
                        regulated.gear = `regulated gear`)
frmt_landings <- format_stecf_landings(landings)

write.taf(frmt_effort, file = "data/frmt_effort.csv", quote = TRUE)
write.taf(frmt_landings, file = "data/frmt_landings.csv")

# 3: SAG
sag_sum <- read.taf("bootstrap/data/SAG_data/SAG_summary.csv")
sag_refpts <- read.taf("bootstrap/data/SAG_data/SAG_refpts.csv")
sag_status <- read.taf("bootstrap/data/SAG_data/SAG_status.csv")

Baltic_Out_stocks <-  c("sal.27.32", "sal.27.22-31", "ele.2737.nea", "trs.27.22-32", "her.27.30", "her.27.31")

clean_sag <- format_sag(sag_sum, sag_refpts, 2019, "Baltic")
clean_status <- format_sag_status(sag_status, 2019, "Baltic Sea")

library(operators)
clean_sag <- dplyr::filter(clean_sag, StockKeyLabel %!in% Baltic_Out_stocks)
clean_status <- dplyr::filter(clean_status, StockKeyLabel %!in% Baltic_Out_stocks)
detach("package:operators", unload=TRUE)

write.taf(clean_sag, file = "data/clean_sag.csv")
write.taf(clean_status, file = "data/clean_status.csv")
