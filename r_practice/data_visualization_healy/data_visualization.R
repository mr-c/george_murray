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

# c function means "combine" or "concatenate"
c(1, 2, 3, 1, 3, 5, 25)
my_numbers <- c(1, 2, 3, 1, 3, 5, 25)
your_numbers <- c(5, 31, 71, 1, 3, 21, 6)
my_numbers

# Option + minus mac to type the assignment operator
mean(my_numbers)
mean(your_numbers)

my_summary <- summary(my_numbers)
my_summary

table(my_numbers)
sd(my_numbers)
my_numbers*5
my_numbers+1
my_numbers + my_numbers
class(my_numbers)
class(my_summary)
class(summary)

# certain actions you take may change an object's class
my_new_vector <- c(my_numbers, "Apple")
my_new_vector
class(my_new_vector)


titanic
class(titanic)
titanic$percent

#tibbles
titanic_tb <- as_tibble(titanic)
titanic_tb


str(my_numbers)
str(my_summary)
