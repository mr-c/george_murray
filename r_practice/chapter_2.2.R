function(x){
  sum(x)/length(x)
}

function(x) {
  total <- sum(x)
  n <- length(x)
  total / n
}

our_mean <- function(x) {
  sum(x)/length(x)
}

our_mean(c(1,2,4,6,8,0))

f <- mean((x^2)-(mean(x)^2))
x <- c(1:10)
f
