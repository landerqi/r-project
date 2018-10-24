# R语言向量化计算

Func <- function(x) {
  if (x %% 2 == 0) {
    ret <- TRUE
  } else {
    ret <- FALSE
  }
  
  return(ret)
}

Func(34)

vec <- round(runif(4) * 100)
vec

# 函数向量化
sapply(vec, Func)

# 函数向量化
FuncV <- Vectorize(Func)
FuncV(vec)

head(iris)
summary(iris)
# 变异系数
options(digits = 10) # 更改小数位数
sapply(iris[ ,1:4], function(x) sd(x) / mean(x))

mylist <- as.list(iris[ ,1:4])
class(mylist)
# 处理list 和sapply非常相似
lapply(mylist, mean)

MyFunc <- function(x) {
  ret <- c(mean(x), sd(x))
  return(ret)
}
result <- lapply(mylist, MyFunc)
result
result$Petal.Length[1]
result$Petal.Length[2]

t(as.data.frame(result))

# 矩阵计算的向量化
set.seed(1)
vec <- round(runif(12) * 100)
mat <- matrix(vec, 3, 4)
mat
apply(mat, 1, sum)
apply(mat, 2, function(x) max(x) - min(x))

# 向量分组计算
tapply(X = iris$Sepal.Length, INDEX = list(iris$Species), FUN = mean)
with(iris, tapply(Sepal.Length, list(Species) , mean))
# aggregate和tapply类似，不过出来的数据是'data.frame'数据框
with(iris, aggregate(Sepal.Length, list(Species) , mean))

# mapply可以看作是sapply的升级版， 可以处理多个以上参数的向量化计算问题。
vec1 <- vec2 <- 1:9
para <- expand.grid(vec1, vec2)
para
res <- mapply(FUN = prod, para[ ,1], para[ ,2])
res
# 如果只处理两个参数，可以使用 outer
outer(vec1, vec2, FUN = '*')
# 美化
MyFunc2 <- function(x, y) {
  left <- paste0(x, '*', y, '=')
  right <- x*y
  ret <- paste0(left, right)
  return(ret)
}
outer(vec1, vec2, FUN = MyFunc2)

# replicate函数能让某个函数重复调用多遍， 这在统计中非常有用。例如生成1000个服从正态分布的随机向量，
# 然后计算其均值， 并使这个过程重复100遍
res <- replicate(100, mean(rnorm(10000)))
res

