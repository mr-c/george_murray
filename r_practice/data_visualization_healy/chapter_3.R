setwd("/Users/George1/Documents/github/george_murray/r_practice/data_visualization_healy/")

#installing necessary packages
my_packages <- c("tidyverse", "broom", "coefplot", "cowplot", "gapminder", 
                 "GGally", "ggrepel", "ggridges", "gridExtra", "here", 
                 "interplot", "margins", "maps", "mapproj", "mapdata", "MASS",
                 "quantreg", "rlang", "scales", "survey", "srvyr", "viridis",
                 "viridisLit", "devtools")
install.packages(my_packages, repos = "http://cran.rstudio.com")
devtools::install_github("kjhealy/socviz")
anscombe
library(tidyverse)
library(socviz)
library(gapminder)

gapminder
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point()
gapminder_gdpPercap_sort <- order(gapminder$gdpPercap)
as.matrix(gapminder_gdpPercap_sort)

# arguments passed to functions need not be named, but here they are for clarity
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point()

p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_smooth()

# if we want to see the data points and the line together we add geom_point() back in
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_smooth() + geom_smooth(method = "lm")

p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point() + 
    geom_smooth(method = "gam") + 
    scale_x_log10(labels = scales::dollar)

### 3.5 Mapping Aesthetics vs Setting Them ###
# mappings use the aes function, to change properties of a particular value, use something else
# ie) incorrect attempt to color points purple
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = "purple"))
p + geom_point() + geom_smooth(method = "loess") + scale_x_log10()

# how to correctly color points purple
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point(color = "purple") + geom_smooth(method = "loess") +
    scale_x_log10()


p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point(alpha = 0.3) + geom_smooth(color = "orange", se = FALSE, 
                                          size = 1.5, method = "lm") + scale_x_log10()
# se corresponds to the standard error ribbon, which is not shown above

# a more polished plot
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point(alpha = 0.3) +
    geom_smooth(method = "gam") +
    scale_x_log10(labels = scales::dollar) +
    labs(x = "GDP Per Capita", y = "Life Expectancy in Years", 
         title = "Economic Growth and Life Expectancy", 
         subtitle = "Data points are country-years", 
         caption = "Source: Gapminder")

# a more polished plot with geom_point & geom_smooth reversed
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_smooth(method = "gam") +
  geom_point(alpha = 0.3) +
  scale_x_log10(labels = scales::dollar) +
  labs(x = "GDP Per Capita", y = "Life Expectancy in Years", 
       title = "Economic Growth and Life Expectancy", 
       subtitle = "Data points are country-years", 
       caption = "Source: Gapminder")

# plotting life expectancy against population
p <- ggplot(data = gapminder, mapping = aes(x = pop, y = lifeExp))
p + geom_point(alpha = 0.3) +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::comma) +
  labs(x = "Population", y = "Life Expectancy in Years", 
       title = "Life Expectancy and Population", 
       subtitle = "Data points are country-years", 
       caption = "Source: Gapminder")

# plotting life expectancy against population with different scaling
p <- ggplot(data = gapminder, mapping = aes(x = pop, y = lifeExp))
p + geom_point(alpha = 0.3) +
  geom_smooth(method = "gam") +
  scale_x_sqrt(labels = scales::comma) +
  labs(x = "Population", y = "Life Expectancy in Years", 
       title = "Life Expectancy and Population", 
       subtitle = "Data points are country-years", 
       caption = "Source: Gapminder")

# mapping color to continent
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = continent))
p + geom_point() + geom_smooth(method = "loess") + scale_x_log10()

# coloring error ribbons
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, 
                                            color = continent, fill = continent))
p + geom_point() + geom_smooth(method = "loess") + scale_x_log10()

# color mapped to factor(year) instead of continent
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, 
                                            color = factor(year), fill = continent))
p + geom_point() + geom_smooth(method = "loess") + scale_x_log10()


### aesthetics can be mapped per geom ###
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point(mapping = aes(color = continent)) +
    geom_smooth(method = "loess") +
    scale_x_log10()

# mapping a continuous variable to color
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point(mapping = aes(color = log(pop))) + scale_x_log10()

### 3.7 Save Your Work ###
ggsave(filename = "my_figure.png")
ggsave(filename = "my_figure.pdf")
p_out <- p + geom_point() + geom_smooth(method = "loess") + scale_x_log10()
ggsave("my_figure.jpeg", plot = p_out)

#scale as you save
ggsave("my_figure_scaled.png", plot = p_out, height = 8, width = 10, units = "in")
