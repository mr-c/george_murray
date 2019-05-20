whale <- c(74, 122, 235, 111, 292, 111, 211, 133, 156, 79)
length(whale)
sum(whale)
sum(whale)/length(whale)
mean(whale)
mean(whale, trim=0.1)
whale - mean(whale)
whale^2 / length(whale)
sqrt(whale)

hip_cost <- c(10500, 45000, 74100, NA, 83500, 86000, 38200, NA, 44300, 12500, 55700, 43900, 71900, NA, 62000)
sum(hip_cost)
sum(hip_cost, na.rm = TRUE)
mean(hip_cost, na.rm = TRUE)

head(precip)
head(sort(precip, decreasing = TRUE))
head(names(precip))

test_scores <- c(Alice = 87, Bob = 72, Shirley = 99)
#or
test_scores <- setNames(c(87, 82, 99), c("Alice", "Bob", "Shirley"))


test_scores <- c(87, 782, 99)
names(test_scores) <- c("Alice", "Bob", "Shirley")
test_scores

#data vectors
x <- c(1, "two", "III")
x
x
str(x)
x


#how to coerce back and forth between numbers and characters

as.numeric("1")
as.character(1)

scan()
#74 122 235 111 292 111 211 133 156 79
1:5
1:1000
1:100000
1:99000
1:length(whale)

0:(length(whale)-1)
seq(0, 100, by=10)

seq(0, 100, length.out=11)
seq(0, 100, length.out=14)

rep(5, times=10)
rep(1:3, times=4)
rep(c(1,2,3), times=c(3,2,1))

#indexes
whale
whale[1]
whale[2]
whale[11]
whale[c(1,3,5,7,9)]
 #negative indexing - returns all but the specified element(s)
whale[-1]
precip[c("Seattle Tacoma", "New York")]
match(c("Seattle Tacoma", "New York"), names(precip))


#assignment through indexing
x <- c(1,2,3)
x[1] <- 11
x
x[2:3] <- c(12, 13)
x
x[6] <-6
x
x <- 1:10
x[] <- 1:3
x

n<-10
x[1 + 0:(n-1) %% length(x)]

c(class(1), class(pi), class(seq(1, 5, by=1)))

sqrt(2)*sqrt(2)
sqrt(2)*sqrt(2)-2

c("Lincoln", "said", "\"Four score", "and seven years ago . . . \"")

help(string)
??string

sprintf("X%s", 1:10)
sprintf("%8d", c(1, 12, 123, 1234, 12345))
sprintf("%2.6f", c(1, 12, 123, 1234, 12345))

paste("X", 1:10, sep="")
paste("The", "quick", "brown", "fox", ". . . ", sep=" ")
paste(c("Four", "The"), c("Score", "quick"), c("and", "fox"), sep=" ")


x <- c(one=1, two=2, three=3)
out <- paste(names(x), x, sep=":", collapse=", ")
sprintf("[ %s ]", out)

x <- paste("X", rep(1:3, 4), sep="")
y <- factor(x)
y
levels(y) <- c(levels(y), "X4")
y[1] <- "X4"
y
levels(y) <- paste("label", 1:4, sep="")
y
y <- factor(state.name[1:5])
y
levels(y) <- c("South", "West", "West", "South", "West")
y

y <- factor(state.name)[1:5]
y
factor(y, levels=y)

r <- "red"; b <- "blue"; g <- "green"
factor(c(r,r,r,r,r,g,g,g,g,g,b,b,b,b,b))
gl(3, 5, labels=c("red", "green", "blue"))

require(lubridate)
current_time <- now()
class(current_time)
as.numeric(current_time)

month(current_time, label=TRUE)

x <- "15-Feb-2013 07:57:34"
y <- parse_date_time(x, "dbYHMS")
year(y)

now() - days(1)
now() - hours(24)

is.na(1)
is.numeric("one")
is.logical("false")
3 < pi
"one" ==1
sqrt(2) * sqrt(2) ==2

isTRUE(all.equal(sqrt(2) * sqrt(2), 2))

whale
whale > 100
whale == 111
whale < 100 | whale > 200
whale > 100 & whale < 200
any(whale > 300)
all(whale > 50)
which(whale < 100 | whale > 200)
292 %in% whale
any(292 == whale)
match(c(292, 293), whale)
sum(whale > 200)
whale[ whale > mean(whale)]
whale[whale < mean(whale)-sd(whale) | whale > mean(whale)+sd(whale)]
hip_cost
hip_cost[ !is.na(hip_cost)]
babies
x <- babies$dwt

#problems
p <- c(2, 3, 5, 7, 11, 13, 17, 19)
length(p)

gas <- c(65311, 65624, 65908, 66219, 66499, 66821, 67145, 67447)
mean(gas)
mean(diff(gas))

x <- c(2, 5, 4, 10, 8)
sqrt(x)
x-6
(x-9^2)


rep(c(1,2,3), times=c(3,2,1))
c(1:5, 4:1)

#2.5
seq(2, 19, by=(n-1))

#2.6
rivers
(sum(rivers) - mean(rivers)) / length(rivers)
