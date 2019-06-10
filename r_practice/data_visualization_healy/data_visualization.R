setwd("/Users/George1/Documents/github/george_murray/r_practice/data_visualization_healy/")

#installing necessary packages
my_packages <- c("tidyverse", "broom", "coefplot", "cowplot", "gapminder", 
                 "GGally", "ggrepel", "ggridges", "gridExtra", "here", 
                 "interplot", "margins", "maps", "mapproj", "mapdata", "MASS",
                 "quantreg", "rlang", "scales", "survey", "srvyr", "viridis",
                 "viridisLit", "devtools")
install.packages(my_packages, repos = "http://cran.rstudio.com")
devtools::install_github("kjhealy/socviz")
