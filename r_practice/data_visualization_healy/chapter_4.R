#installing necessary packages
#my_packages <- c("tidyverse", "broom", "coefplot", "cowplot", "gapminder", 
                 "GGally", "ggrepel", "ggridges", "gridExtra", "here", 
                 "interplot", "margins", "maps", "mapproj", "mapdata", "MASS",
                 "quantreg", "rlang", "scales", "survey", "srvyr", "viridis",
                 "viridisLit", "devtools")
library(tidyverse)
library(socviz)
library(gapminder)
                 
p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(aes(group = country))

# facet wrap - specify the variable you want the data broken up by
p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(aes(group = country)) + facet_wrap(~continent)

# enhancing this plot
p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(color = "gray70", aes(group = country)) +
    geom_smooth(size = 1.1, method = "loess", se = FALSE) +
    scale_y_log10(labels=scales::dollar) +
    facet_wrap(~ continent, ncol = 5) +
    labs(x = "Year",
         y = "GDP per capita", 
         title = "GDP per capita on Five Continents")

#  gss
p <- ggplot(data = gss_sm,
            mapping = aes(x = age, y = childs))
p + geom_point(alpha = 0.2) +
    geom_smooth() +
    facet_grid(sex ~ race)
head(gss_sm)

# 4.4 Geoms Can Transform Data
