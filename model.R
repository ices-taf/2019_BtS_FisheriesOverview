
# Here we run a few intermediate formatting steps done on SAG. 
# STECF and catch statistics only need one formatting step already done in data.R

library(icesTAF)
require(dplyr)

mkdir("model")

#A. Trends by guild

trends <- stock_trends(clean_sag)


#B.Trends and current catches, landings and discards


catch_trends <- CLD_trends(clean_sag)
catch_current <- stockstatus_CLD_current(clean_sag)
