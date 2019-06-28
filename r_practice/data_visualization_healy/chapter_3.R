library(tidyverse)
library(socviz)
library(gapminder)
gapminder

# arguments passed to functions need not be named, but here they are for clarity
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point()
