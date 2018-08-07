
# Script to check that ggplot and ggmap are working

# Check that packages exist, if not, install them

if (require(ggplot2)==FALSE) install.packages("ggplot2")
if (require(ggmap)==FALSE) install.packages("ggmap")

# Load packages

library("ggplot2")
library("ggmap")

# Check that ggplot works for basic plots
# This should produce a plot with ten dots

df <- data.frame("x"=1:10, "y"=1:10)

ggplot(df, aes(x=x, y=y))+
  geom_point()

# Check that you can pull map data from ggplot
# This should produce a black map of the USA

usa<-map_data("usa")

ggplot(usa, aes(x=long, y=lat))+
  geom_polygon()+
  coord_map()

# Check that ggmap works
# This should produce a Google Earth map of Monterey Bay

mbay <- get_map("monterey bay", maptype="satellite")

ggmap(mbay)
