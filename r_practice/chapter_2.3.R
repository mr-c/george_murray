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
