
# LOLLIPOP PLOT

library(ggplot2)
library(tidyverse)



data = data.frame(
  x = LETTERS,
  y = abs(rnorm(26))
)

ggplot(data = data, aes(x=x,y = y))+
  geom_segment( aes(x=x, xend=x, y= 0, yend=y), color='purple')+
  geom_point(size=5, color='purple', fill=alpha('black', 0.6),
             alpha= 0.9, shape=21, stroke=1)+
  labs(title = "Lollipop Guild Plot",
       x="Letters",
       y="Random Numbers")+
  coord_flip()+
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )




# Horizontal version
ggplot(data, aes(x=x, y=y)) +
  geom_segment( aes(x=x, xend=x, y=0, yend=y), color="skyblue") +
  geom_point( color="blue", size=4, alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )
