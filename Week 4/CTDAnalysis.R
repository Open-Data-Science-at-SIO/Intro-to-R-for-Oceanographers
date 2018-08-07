
# Script for analyzing CTD cast data

# Set working directory to folder which contains your data folder
setwd("~/Desktop/IntroR/Week 4")

# Source the CTD binning function
source("binCTD.R")

# Run the CTD binning function 
# CTDProfiles is the folder containing your .csv files
binned.data <- binCTD("./CTDProfiles/", 5)

# Bonus! Let's make a couple of quick plots
# You'll need to install the ggplot2 and reshape2 packages for this to work

library(ggplot2)
library(reshape2)

# melt the data so one row = one observation
long.ctd <- melt(binned.data, 
                 id.vars=c("Cast.ID", "Depth.Bin"))

# plot!
ggplot(data=long.ctd) +
  geom_point(aes(x=value, y=-Depth.Bin, color=Cast.ID)) +
  facet_wrap(~variable, scales="free_x")
