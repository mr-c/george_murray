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

#interquartile range
median(rivers)
IQR(rivers)
IQR(rivers) / sd(rivers)
sort(rivers)

#median absolute deviation (mad)
mad(rivers)/sd(rivers)
kids.weight
(UsingR)
require(UsingR)

ht <- kid.weights$height
mad(ht)/sd(ht)

#skewness

skew <- function(x) {
  n <- length(x)
  z <- (x - mean(x))/sd(x)
  sum(z^3) / n
}

skew(exec.pay)

four_year_hts <- kid.weights[kid.weights$age %in% 48:59, "height"]
skew(four_year_hts)

#sample excess kurtosis - a measure of the tails in a dataset
kurtosis <- function(x) {
  n <- length(x)
  z <- (x - mean(x)) / sd(x)
  sum(z^4)/n - 3
}
kurtosis(galton$parent)

stripchart(exec.pay)
stripchart(rivers)
stem(exec.pay)

stem(bumpers)

hist(faithful$waiting)

bins <- seq(40, 100, by=5)
x <- faithful$waiting
out <- cut(x, breaks=bins)
head(out)
table(out)

?colors

mypalette <- brewer.pal(7,"Greens")
brewer.pal(n, name)
require(brewer.pal)
require(RColorBrewer)
mypalette<-brewer.pal(7, "Greens")
image(1:7,1,as.matrix(1:7),col=mypalette,xlab="Greens (sequential)", 
      ylab="",xaxt="n",bty="n")

plot( density(bumpers))

#layer a density plot over a histrogram 

b_hist <- hist(bumpers, plot=FALSE)
b_dens <- density(bumpers)

hist(bumpers, probability = TRUE,
     xlim = range(c(b_hist$breaks, b_dens$x)),
     ylim = range(c(b_hist$density, b_dens$y)))
lines(b_dens, lwd=2)

boxplot(bumpers, horizontal=TRUE, main="Bumpers")

#producing quantile-nroaml plots to represent distribution, relatively straight line indicates a normal distribution
x <- rep(Macdonell$finger, Macdonell$frequency)
qqnorm(x)

x <- jitter(HistData::Galton$child, factor=5)
qqnorm(x)

beatles
require(LearnEDA)
require(beatles)
LearnEDA
DDT

mean(as.numeric(ChestSizes, na.rm = TRUE))
table(ChestSizes)
table(ChestSizes) 

new_mean <- function(x) {
  sum(x)/length(x)
}
new_mean(ChestSizes)

hist(firstchi, probability = TRUE,
     xlim = range(c(b_hist$breaks, b_dens$x)),
     ylim = range(c(b_hist$density, b_dens$y)))

firstchi


