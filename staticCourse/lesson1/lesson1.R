# 1
x <- c(115, 120, 131, 115, 109, 115, 115, 105, 110)
### u似然估计 (A)
x.bar <- mean(x)
var(x) # 修正样本方差
s2 <- ((length(x) - 1)/length(x)) * var(x); s2 # 方差
sum((x - mean(x))^2) / length(x) # 方差
### (B)
s2star <- var(x); s2star
sstar <- sqrt(var(x)); sstar # 修正样本方差标准差
sd(x) # 修正样本方差标准差
qt(0.975, 8)
x.bar + sstar/sqrt(length(x))*qt(0.975, 8) #
x.bar - sstar/sqrt(length(x))*qt(0.975, 8) #
alpha <- 0.05
n <- length(x)
(n-1) * var(x) / qchisq(1 - alpha/2, n - 1) #
(n-1) * var(x) / qchisq(alpha/2, n - 1) #
### (C)
mean(x) - qnorm(1 - alpha/2) * sqrt(7^2/n)
mean(x) + qnorm(1 - alpha/2) * sqrt(7^2/n)
### (D)
T <- (mean(x) - 113) / sqrt(var(x) / n); T
qt(1 - 0.03, n - 1) # T < qt 所以不拒绝H0
### (E)
T <- (mean(x) - 114) / (7 / sqrt(n)); T
qnorm(1 - 0.05 / 2) # T < qnorm 所以不拒绝

t.test(x, conf = 0.95) # 置信区间, u已知
t.test(x, mu = 113, alt = 'greater', conf = 0.97)


# 9.2.26
x <- c(4.3, 3.4, 6.4, 7.6, 6.5, 3.5, 6.2)
y <- c(6.1, 7.3, 4.2, 4.1, 5.5)
m <- length(x)
n <- length(y)
alpha <- 0.05
### (1)
(1 / qf(1 - alpha / 2, m - 1, n - 1))*(var(x) / var(y))
(1 / qf(alpha / 2, m - 1, n - 1))*(var(x) / var(y))
var.test(x, y)
### (2)
sw <- sqrt(((m - 1) * var(x) +  (n - 1) * var(y)) / (m + n - 2)); sw
(mean(x) - mean(y)) + qt(1 - alpha / 2, m + n - 2) * sw * sqrt(1 / m + 1 / n) 
(mean(x) - mean(y)) - qt(1 - alpha / 2, m + n - 2) * sw * sqrt(1 / m + 1 / n) 
### (3)
var(x) / var(y)
qf(0.06 / 2, m - 1, n - 1)
qf(1 - 0.06 / 2, m - 1, n - 1)
### (4)
(mean(x) - mean(y) - 0.02) / (sqrt(1 / m + 1 / n) * sw)
qt(1 - 0.06, m + n - 2)
t.test(x, y, mu = 0.02, alt = 'greater')
t.test(x, y, mu = 0.02, alt = 'greater', var.equal = TRUE)
