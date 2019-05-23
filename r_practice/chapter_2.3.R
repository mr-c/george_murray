wts <- c(38, 43, 48, 61, 47, 24, 29, 48, 59, 24, 40, 27)
sort(wts)
mean(wts)
devs <- wts - mean(wts)
mean(devs)
mean(wts, trim = 0.10)

#differences between mean and trimmed mean
exec.pay
mean(exec.pay)
mean(exec.pay, trim=0.10)


w <- Macdonell$frequency / sum(Macdonell$frequency) 
y <- Macdonell$height
sum(w*y)
median(wts)
n <- length(exec.pay); trim = 0.10
exec.pay
require(exec.pay)

rivers
n <- length(rivers); trim = 0.10
lo <- 1 + floor(n * trim)
hi <- n + 1 - lo
median(sort(rivers)[lo:hi])

x <- 0:5
length(x)
mean(sort(x)[3:4])
median(x)
quantile(x, 0.25)
quantile(x, seq(0, 1, by = 0.2))
quantile(x)
fivenum(x)
income_percentiles
require(UsingR)
income_percentiles
income <- c("90"=110651, "95"=155193, "99"=366623, "99.5"=544792, "99.9"=1557090, "99.99"=7969900)
income

table(wts)
table(wts) == max(table(wts))
which(table(wts) == max(table(wts)))
as.numeric(names(which(table(wts) == max(table(wts))) ))

#minimum and maximum values
range(wts)

#distance between min and max
diff(range(wts))
var(wts)
sum( (wts - mean(wts))^2) / (length(wts)-1)

#variability
hip_cost
hip_cost <- c(10500, 45000, 74100, NA, 83500, 86000, 38200, NA, 44300, 12500, 55700, 43900, 71900, NA, 62000)
range(hip_cost, na.rm = TRUE)
sd(hip_cost, na.rm = TRUE)

#z-score describes size of a value relative to the size of other values in the same set
z_score <- function(x) (x - mean(x))/sd(x)
z_score(wts)
#this reminds me of fold change in expression data

grades <- c(54, 50, 79, 79, 51, 69, 55, 62, 100, 99)
z_score_grades <- (grades - mean(grades))/sd(grades)
grades[z_score_grades >= 1.28]

mean(grades) + 1.28 * sd(grades)

require(UsingR)
require(exec.pay)
exec.pay

#computing a proportion
z <- (exec.pay - mean(exec.pay))/sd(exec.pay)
out <- abs(z) > 3
sum(out) / length(z)

#coefficient of variation
sd(exec.pay)/mean(exec.pay)
