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

ls()
str(x)

head(rivers)
data(rivers)
str(rivers)
tail(rivers)

#Cavendish data set.
require("HistData")
head(Cavendish)
str(Cavendish)
head(Cavendish$density2)
summary(Cavendish$density2)
1+2*(3+4)
4^3 + 3^(2+1)
sqrt((4+3)*(2+1))
((1+2)/(3+4))^2
a<-2
b<-3
c<-4
d<-5

a*b*c*d
rivers
exec.pay
max(exec.pay)

mean(exec.pay, trim=0.1)
mean(exec.pay, trim=0.1) - mean(exec.pay)
mean(exec.pay)

orange

require("orange")
orange
str(Orange)
Orange

mean(Orange$age)
max(Orange$circumference)
