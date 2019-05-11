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
