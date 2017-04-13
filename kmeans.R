library(png)
library(ggplot2)
library(grid)


load(file="entry.Rda")


radiant <- old[old$side=="0",]
dire <- old[old$side=="1",]

set.seed("439823") ## TO be able to reproduce the same plots

# column 3 and 4 are x and y cordinates for heroes. Currently trying 8 clusters (positions). 
# nstart=25 is standard for kmeans don't ask why.
herocluster <- kmeans(dire[,3:4],8, nstart=25) 
herocluster$cluster <- as.factor(herocluster$cluster)


## ggplot background

minimap <- readPNG("minimap2.png")

myplot <- ggplot(dire, aes(x = hero_cellx, y = hero_celly, color=herocluster$cluster)) +
  annotation_custom(rasterGrob(minimap,
                               width = unit(1, "npc"),
                               height = unit(1, "npc")), 
                    Inf, -Inf, Inf, -Inf) +
  geom_point() +
  scale_y_continuous(limits = c(63, 190)) +
  scale_x_continuous(limits = c(68, 186)) +
  coord_cartesian(xlim = c(70, 183), ylim = c(63, 190))

myplot

