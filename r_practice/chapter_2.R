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
