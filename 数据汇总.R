# 数据汇总：强大的plyr包
library(reshape2)
library(plyr)
ratio_fun <- function(x) {
  sum(x$tip) / sum(x$total_bill)
}
ddply(.data = tips,             # 拆分计算的对象
      .variables = 'sex',       # 按照什么变量来拆分
      .fun = ratio_fun)         # 计算的函数

ddply(tips, .(sex), ratio_fun)

# 更复杂的汇总
ddply(tips, sex~smoker, ratio_fun)

# adply函数示范
### Input: Array  Split by: margins
data <- as.matrix(iris[ ,-5])
head(data)
result <- adply(.data = data,
                .margins = 2, # 1: 表示按行计算，2：表示按列计算
                .fun = function(x) {
                  max <- max(x)
                  min <- min(x)
                  median <- median(x)
                  sd <- round(sd(x), 2)
                  return(c(max, min, median, sd))
                }
                )
result


#ldply 函数示范
### Input: list     Split by: element of list
model <- function(x) {
  lm(Sepal.Length~Sepal.Width, data = x) # 对两个变量作回归
}
### build three linear regression model in list
models <- dlply(.data = iris,
                .variables = 'Species', # 根据花的种类分组
                .fun = model)
models
result5 <- ldply(.data = models, # 提取系数
                 .fun = coef)
result5

# 特别函数：m*ply
### m*ply: multi-argument function (like mapply)