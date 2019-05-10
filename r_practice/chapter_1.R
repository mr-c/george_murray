setwd("/Users/George1/Documents/GitHub/george_murray/r_practice")
#finding distance between two points: (1,3) and (2,1)
((2-1)^2 + (1-3)^2)^(1/2)

#assigning variables
x <- 2
y <- x^2 - 2*x + 1
y

x <- pi
sin(x)
cos(x)

sqrt(x)
log(x)
log(x, 10)
log(x, 2)

#combine
x <- c(74, 122, 235, 111, 292)

mean(x)

sum(x)/length(x)
head(x); tail(x)
head(x, 1)
head(x, 3)
tail(x, 2)

x+x
sqrt(x)
x - mean(x)


#median
mean(x, trim=0.5)
median(x)
x
y<- c(TRUE, FALSE, TRUE, TRUE)
summary(x)
summary(y)
