
# Initial formatting of the data


library(dplyr)
library(operators)
library(icesFO)

# 1: ICES official cath statistics

hist <- read.csv("bootstrap/data/ICES_nominal_catches/ICES_historical_catches.csv")
official <- read.csv("bootstrap/data/ICES_nominal_catches/ICES_2006_2017_catches.csv")
prelim <- read.csv("bootstrap/data/ICES_nominal_catches/ICES_preliminary_catches.csv")

catch_dat <- format_catches(2018, "Baltic Sea Ecoregion", hist, official, prelim)

# 2: STECF effort and landings

effort <- read.csv("bootstrap/data/STECF_effort.csv")
landings <- read.csv("bootstrap/data/STECF_landings.csv")

frmt_effort <- format_stecf_effort(effort)
frmt_landings <- format_stecf_landings(landings)


# 3: SAG
sag_sum <- read.csv("bootstrap/data/SAG_data/SAG_summary.csv")
sag_refpts <- read.csv("bootstrap/data/SAG_data/SAG_refpts.csv")
sag_status <- read.csv("bootstrap/data/SAG_data/SAG_status.csv")

Baltic_Out_stocks <-  c("sal.27.32", "sal.27.22-31", "ele.2737.nea", "trs.27.22-32", "her.27.30", "her.27.31")

clean_sag <- format_sag(sag_sum, sag_refpts, 2019, "Baltic")
clean_status <- format_sag_status(sag_status, 2019, "Baltic Sea")

library(operators)
clean_sag <- dplyr::filter(clean_sag, StockKeyLabel %!in% Baltic_Out_stocks)
clean_status <- dplyr::filter(clean_status, StockKeyLabel %!in% Baltic_Out_stocks)
detach("package:operators", unload=TRUE)


