# All plots and data outputs are produced here 


library(icesTAF)

mkdir("report")
#################################################
##1: ICES nominal catches and historical catches#
#################################################

#~~~~~~~~~~~~~~~#
# By common name
#~~~~~~~~~~~~~~~#
        #Plot
plot_catch_trends(catch_dat, type = "COMMON_NAME", line_count = 5, plot_type = "line")
ggplot2::ggsave("2019_BtS_FO_Figure5.png", path = "./report", width = 170, height = 100.5, units = "mm", dpi = 300)

        #data
BtS_catchby_commonname <- plot_catch_trends(catch_dat, type = "COMMON_NAME", line_count = 5, plot_type = "line", return_data = T)
write.taf(BtS_catchby_commonname, dir = "report")


#~~~~~~~~~~~~~~~#
# By country
#~~~~~~~~~~~~~~~#
        #Plot
plot_catch_trends(catch_dat, type = "COUNTRY", line_count = 9, plot_type = "area")
ggplot2::ggsave("BtS_CatchCountry.png", path = "~/", width = 178, height = 130, units = "mm", dpi = 300)

        #data
plot_dat<-plot_catch_trends(catch_dat, type = "COUNTRY", line_count = 9, plot_type = "area", return_data = T)
write.csv(plot_dat, file= "BtS_catchby_country.csv")

#~~~~~~~~~~~~~~~#
# By guild
#~~~~~~~~~~~~~~~#
# I remove Crustacean and Elasmobranch because they were not there last year and 
# create a new line "other" which is almost zero

catch_dat2 <-dplyr::filter(catch_dat, GUILD != "Crustacean")
catch_dat2 <-dplyr::filter(catch_dat2, GUILD != "Elasmobranch")

        #Plot
plot_catch_trends(catch_dat2, type = "GUILD", line_count = 4, plot_type = "line")
ggplot2::ggsave("BtS_CatchGuild_v2.png", path = "~/", width = 178, height = 130, units = "mm", dpi = 300)
        
        #data
plot_dat <- plot_catch_trends(catch_dat, type = "GUILD", line_count = 4, plot_type = "line", return_data = T)
write.csv(plot_dat, file= "BtS_catchby_guild.csv")

################################
## 2: STECF effort and landings#
################################

#~~~~~~~~~~~~~~~#
# Effort by country
#~~~~~~~~~~~~~~~#
        #Plot
plot_stecf(frmt_effort,"effort","COUNTRY", "2019","August", 9, "15-23")

        #data
plot_dat <- plot_stecf(frmt_effort,"effort","COUNTRY", "2018","November", 9, "15-23", return_data = TRUE)
write.csv(plot_dat, file= "BtS_stecf_effort_country.csv")


#~~~~~~~~~~~~~~~#
#Effort by gear
#~~~~~~~~~~~~~~~#
        #Plot
plot_stecf(frmt_effort,"effort","GEAR", "2019","August", 9, "15-23")
        
        #data
plot_dat<-plot_stecf(frmt_effort,"effort","GEAR", "2019","August", 9, "15-23", return_data = TRUE)
write.csv(plot_dat, file= "BtS_stecf_effort_gear.csv")

#~~~~~~~~~~~~~~~#
#Landings by country
#~~~~~~~~~~~~~~~#
        #Plot

        #dat
plot_dat<- plot_stecf(frmt_landings,"landings", variable, "2019","August", 9, "15-23", return_data = TRUE)
write.csv(plot_dat, file= "BtS_stecf_landings.csv")

###########
## 3: SAG #
###########

#~~~~~~~~~~~~~~~#
# A. Trends by guild
#~~~~~~~~~~~~~~~#
# 1. Demersal
#~~~~~~~~~~~
plot_stock_trends(trends, guild="demersal", cap_year = 2019, cap_month = "August", return_data = FALSE)
ggplot2::ggsave("BtS_DemersalStatusTrends.png", path = "~/", width = 178, height = 130, units = "mm", dpi = 300)

plot_dat <- plot_stock_trends(trends, guild="demersal", cap_year = 2019, cap_month = "August", return_data = TRUE)
write.csv(plot_dat, file ="../HTML_FO/data/BtS_DemersalStatusTrends.csv" )

# 2. Pelagic
#~~~~~~~~~~~
plot_stock_trends(trends, guild="pelagic", cap_year = 2019, cap_month = "August", return_data = FALSE)
ggplot2::ggsave("BtS_PelagicStatusTrends.png", path = "~/", width = 178, height = 130, units = "mm", dpi = 300)

plot_dat <- plot_stock_trends(trends, guild="pelagic", cap_year = 2018, cap_month = "November", return_data = T)
write.csv(plot_dat,file ="../HTML_FO/data/BtS_PelagicStatusTrends.csv" )

# 3. Benthic
#~~~~~~~~~~~
plot_stock_trends(trends, guild="benthic", cap_year = 2019, cap_month = "August",return_data = FALSE )
ggplot2::ggsave("BtS_BenthicStatusTrends.png", path = "~/", width = 178, height = 130, units = "mm", dpi = 300)

plot_dat <- plot_stock_trends(trends, guild="benthic", cap_year = 2018, cap_month = "November", return_data = TRUE)
write.csv(plot_dat, file ="../HTML_FO/data/BtS_benthicStatusTrends.csv" )


#~~~~~~~~~~~~~~~#
# B.Current catches
#~~~~~~~~~~~~~~~#

# 1. Demersal
#~~~~~~~~~~~
bar <- plot_CLD_bar(catch_current, guild = "demersal", caption = T, cap_year = 2019, cap_month = "August", return_data = F)

bar_dat <- plot_CLD_bar(catch_current, guild = "demersal", caption = T, cap_year = 2019, cap_month = "August", return_data = T)
write.csv(bar_dat, file ="../HTML_FO/data/BtS_demersalKobeBar.csv" )

kobe <- plot_kobe(catch_current, guild = "demersal", caption = T, cap_year = 2019, cap_month = "August", return_data = F)
#kobe_dat is just like bar_dat with one less variable
#kobe_dat <- plot_kobe(catch_current, guild = "Demersal", caption = T, cap_year = 2018, cap_month = "November", return_data = T)

png(paste0(output_path, "BtS_Demersal_Bar+kobe", ".png"),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(kobe,
                                 bar, ncol = 2,
                                 respect = TRUE, top = "demersal")
dev.off()

# 2. Pelagic
#~~~~~~~~~~~
bar <- plot_CLD_bar(catch_current, guild = "pelagic", caption = T, cap_year = 2019, cap_month = "August", return_data = F)

bar_dat <- plot_CLD_bar(catch_current, guild = "pelagic", caption = T, cap_year = 2019, cap_month = "August", return_data = T)
write.csv(bar_dat, file ="../HTML_FO/data/BtS_pelagicKobeBar.csv" )

kobe <- plot_kobe(catch_current, guild = "pelagic", caption = T, cap_year = 2019, cap_month = "August", return_data = F)
png(paste0(output_path, "BtS_Pelagic_Bar+kobe", ".png"),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(kobe,
                                 bar, ncol = 2,
                                 respect = TRUE, top = "pelagic")
dev.off()


# 3. Benthic
#~~~~~~~~~~~
bar <- plot_CLD_bar(catch_current, guild = "benthic", caption = T, cap_year = 2019, cap_month = "August", return_data = F)

bar_dat <- plot_CLD_bar(catch_current, guild = "benthic", caption = T, cap_year = 2019, cap_month = "August", return_data = T)
write.csv(bar_dat, file ="../HTML_FO/data/BtS_benthicKobeBar.csv" )

kobe <- plot_kobe(catch_current, guild = "benthic", caption = T, cap_year = 2018, cap_month = "August", return_data = F)
png(paste0(output_path, "BtS_Benthic_Bar+kobe", ".png"),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(kobe,
                                 bar, ncol = 2,
                                 respect = TRUE, top = "benthic")
dev.off()


# 4. All
#~~~~~~~~~~~
bar <- plot_CLD_bar(catch_current, guild = "All", caption = T, cap_year = 2019, cap_month = "August", return_data = F)

bar_dat <- plot_CLD_bar(catch_current, guild = "All", caption = T, cap_year = 2019, cap_month = "August", return_data = T)
write.csv(bar_dat, file ="../HTML_FO/data/BtS_AllKobeBar.csv" )

kobe <- plot_kobe(catch_current, guild = "All", caption = T, cap_year = 2018, cap_month = "August", return_data = F)
png(paste0(output_path, "BtS_All_Bar+kobe", ".png"),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(kobe,
                                 bar, ncol = 2,
                                 respect = TRUE, top = "All stocks")
dev.off()


#~~~~~~~~~~~~~~~#
# C. Discards
#~~~~~~~~~~~~~~~#
discardsA <- plot_discard_trends(catch_trends, 2019, cap_year = 2019, cap_month = "August")

plot_dat<- plot_discard_trends(catch_trends, 2019, cap_year = 2019, cap_month = "August", return_data = T)
write.csv(plot_dat, file ="../HTML_FO/data/BtS_DiscardTrends.csv" )

#Need to change order?
discardsB <- plot_discard_current(catch_trends, 2019, cap_year = 2019, cap_month = "August")

plot_dat <- discardsB <- plot_discard_current(catch_trends, 2019, cap_year = 2018, cap_month = "August", return_data = T)
write.csv(plot_dat, file ="../HTML_FO/data/BtS_DiscardCurrent.csv" )

png(paste0(output_path, "BtS_Discards", ".png"),
    width = 131.32,
    height = 88.9,
    units = "mm",
    res = 300)
p1_plot<-gridExtra::grid.arrange(discardsA,
                                 discardsB, ncol = 2,
                                 respect = TRUE)
dev.off()

#~~~~~~~~~~~~~~~#
#D. ICES pies
#~~~~~~~~~~~~~~~#

plot_status_prop_pies(frmt_status, "August", "2019")
ggplot2::ggsave("BtS_ICESpies.png", path = "~/", width = 178, height = 178, units = "mm", dpi = 300)

plot_dat <- plot_status_prop_pies(frmt_status, "November", "2018", return_data = T)
write.csv(plot_dat, file= "../HTML_FO/data/BtS_ICESpies_data.csv")

#~~~~~~~~~~~~~~~#
#E. GES pies
#~~~~~~~~~~~~~~~#
#Need to change order and fix numbers
plot_GES_pies(frmt_status, catch_current, "August", "2019")
ggplot2::ggsave("../HTML_FO/Figures/BtS/BtS_GESpies.png", path = "~/", width = 178, height = 178, units = "mm", dpi = 300)

plot_dat <- plot_GES_pies(frmt_status, catch_current, "November", "2018", return_data = T)
write.csv(plot_dat, file= "../HTML_FO/data/BtS_GESpies_data.csv")

#~~~~~~~~~~~~~~~#
#F. ANNEX TABLE 
#~~~~~~~~~~~~~~~#
doc <- format_annex_table(frmt_status, 2019, return_data = F)
print(doc, target = paste0("~/", "annex_table", ".docx"))

dat <- format_annex_table(frmt_status, 2019, return_data = T)



