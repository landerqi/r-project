# 例
x1 <- c(0.236, 0.238, 0.248, 0.245, 0.243)
x2 <- c(0.257, 0.253, 0.255, 0.254, 0.261)
x3 <- c(0.258, 0.264, 0.259, 0.267, 0.262)
n1 <- length(x1); n2 <- length(x2); n3 <- length(x3)
x <- c(x1, x2, x3); x
a <- rep(1:3, c(n1, n2, n3)); a
A <- factor(a); A # 要因子化
qqq <- aov(x~A); qqq 
summary(qqq) # 方差分析 Residuals Sum Sq 对应Se = 0.000192,  A Df = (r - 1) , 
             # residuals Df = n -r, A Sum Sq 对应SA = 0.001053
             # p-value = 1.34e-05, 阿尔伐 = 0.05, p-value < 阿尔伐，拒绝原假设。

# p123, 5.1
### (1)
x1 <- c(1600, 1650, 1680, 1800, 1720, 1690)
x2 <- c(1580, 1640, 1740, 1700, 1680)
x3 <- c(1640, 1730, 1550, 1700)
x4 <- c(1510, 1570, 1680, 1600)
n1 <- length(x1); n2 <- length(x2); n3 <- length(x3); n4 <- length(x4)
x <- c(x1, x2, x3, x4);x
a <- rep(1:4, c(n1, n2, n3, n4));a
A <- factor(a)
qqq <- aov(x~A);qqq
summary(qqq)
### (2), 无偏估计就是他们分别每一组的平均值
mean(x1)
mean(x2)
mean(x3)
mean(x4)
