library(jsonlite)
library(png)
library(dplyr)
library(ggplot2)
library(grid)


load(file="entry.Rda")

radiant <- old[old$side=="0",]
dire <- old[old$side=="1",]

set.seed("439823")
herocluster <- kmeans(dire[,3:4],8, nstart=25)
herocluster$cluster <- as.factor(herocluster$cluster)

minimap <- readPNG("C:/Users/jeckz/Downloads/minimap2.png")

myplot2 <- ggplot(dire, aes(x = hero_cellx, y = hero_celly, color=herocluster$cluster)) +
  annotation_custom(rasterGrob(minimap,
                               width = unit(1, "npc"),
                               height = unit(1, "npc")), 
                    Inf, -Inf, Inf, -Inf) +
  geom_point() +
  scale_y_continuous(limits = c(63, 190)) +
  scale_x_continuous(limits = c(68, 186)) +
  coord_cartesian(xlim = c(70, 183), ylim = c(63, 190))

myplot2

