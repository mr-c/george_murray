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
