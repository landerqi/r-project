# 自定义函数
# 一个求圆面积的函数
MyFunc <- function(r) {
  area <- pi*r^2
  return(area)
}
print(MyFunc(4))

# 函数在调用时会新建一个特殊的子环境，用以处理函数中涉及到的变量，例如上面函数中的area变量, 这种变量称为局部变量，因为不会在全局环境中出现而影响其它函数，使用起来非常安全。但函数内部可以调用全局变量，例如上面的pi。

#条件判断---顺序执行
num <- 5
if (num %% 2 != 0) {
  cat(num, 'is odd')
} else {
  cat(num, 'is even')
}

if (num %% 3 == 1) {
  cat('mode is', 1)
} else if (num %% 3 == 2) {
  cat('mode is', 2)
} else {
  cat('mode is', 0)
}

# 二元判断函数
num <- 1:6
ifelse (num %% 2 == 0, yes = 'even', no = 'odd')

num <- sample(20: 70, 20, replace = TRUE)
res <- ifelse(num > 50, 'old people', ifelse(num < 30, '青年', '中年'))
res

# 多重分支的条件判断
switch(2, 'banana', 'apple', 'other')
num <- 10
Mode <- num %% 3
cat('mode is', switch (Mode + 1, 0, 1, 2 ))
fruits <- c('apple', 'orange', 'grape', 'grape', 'other')
price <- function(fruit) {
  switch(fruit, 
         apple = 10,
         orange = 12,
         grape = 16,
         banana = 8,
         0
         )
}
price('apple')
sapply(fruits, price)

# 循环
### for
x <- 0
for (i in 1:100) {
  if (i %% 2 != 0) {
    x <- x + i
  }
}
x
sum(seq(1, 100, by = 2))
### while 
x <- 0
i <- 1
while (i < 100) {
  if (i %% 2 != 0) {
    x <- x + i
  }
  i <- i +1
}
x
### repeat
x <- 0
i <- 1
repeat {
  if (i %% 2 != 0) {
    x <- x + i
  }
  i <- i + 1
  if (i > 100) break
}
x
x <- 0
i <- 0
repeat {
  i <- i + 1
  if (i > 100) break
  if (i %% 2 == 0) next
  x <- x + i
}
x

### 因为在R语言中，所有涉及到修改变量的情况，都会将变量重新复制一份，这样会
### 消耗内存和计算时间，因此在循环中修改变量会比较慢，我们用一个判断质数的例子来比较如下三种编程方法的速度
findprime <- function(x) {
  if (x %in% c(2, 3, 5, 7)) return(TRUE)
  if (x %% 2 == 0 | x == 1) return(FALSE)
  xsqrt <-  round(sqrt(x))
  xseq <- seq(from = 3, to = xsqrt, by = 2)
  print(xsqrt)
  print(xseq)
  if (all(x %% xseq != 0)) return(TRUE)
  else return(FALSE)
}
system.time({
  x <- logical()
  for (i in 1:1e5) {
    y <- findprime(i)
    x <- c(x, y)
  }
})
system.time({
  x <- logical(1e5)
  for (i in 1:1e5) {
    y <- findprime(i)
    x[i] <- y
  }
})
### 避免使用循环，尽量使用向量化计算方式
system.time({
   x <- sapply(1: 1e5, findprime)  
})

#函数深入
fibonaci <- function(n) {
  i <- 2
  x <- 1:2
  while(x[i] < n) {
    x[i + 1] <- x[i - 1] + x[i]
    i <- i + 1
  }
  x <- x[-i]
  return(x)
}
SeqFi <- fibonaci(1e3)
SeqFi
plot(SeqFi)
# 函数内部是局部变量, 如果要修改全局变量<<-：
x <- 10 
tempfunc <- function(n) {
  x <<- 1 # x <- 1 则是局部变量，赋值不会改变外部的全局变量
  return(x + n)
}
tempfunc(2)
# 可以给函数设置缺省值, 其实就类似js的默认参数, ...类似于扩展运算符：
SdFunc <- function(x, type = 'sample', ...) {
  # 参数检查
  stopifnot(is.numeric(x),
            length(x) > 0,
            type %in% c('sample', 'population'))
  x <- x[!is.na(x)]
  n <- length(x)
  m <- mean(x, ...)
  if (type == 'sample') {
    sd <- sqrt(sum((x - m)^2)/(n - 1))
  }
  if (type == 'population') {
    sd <- sqrt(sum((x - m)^2)/(n))
  }
  return(sd)
}
SdFunc(1:10)
SdFunc(1:10, type = 'population')
y <- c(1:10, 50)
SdFunc(y)
SdFunc(y, type = 'sample', trim = 0.1) # trim是mean()函数里的参数，用来去掉极值

# 函数递归
Fac1 <- function(n) {
  if (n == 0) return(1)
  return(n * Fac1(n - 1))
}
Fac1(10)
# 递归也可以用循环来处理
Fac2 <- function(n) {
  if (n == 0) return(1)
  else {
    res <- n
    while (n > 1) {
      res <- res * (n - 1) 
      n <- n - 1
    }
  }
  return(res)
}
Fac2(10)
# 另一个使用递归来解决的常见的例子就是计算fabonaci数列：
system.time({
  fabonaci <- function(n) {
    if (n == 0) return(0)
    if (n == 1) return(1)
    return(fabonaci(n - 1) + fabonaci(n - 2))
  }
  fabonaci(30)
})

# 二元运算符--- 其实他也是个函数：
Prod <- 1:4 * 4:1
Prod
Prod <- '*'(1:4, 4:1) # 当成一个函数
Prod
### 二元运算符也可以自定义。例如定义一个集合运算的运算符，找出两个集合的交集：
a <- c('apple', 'banana', 'orange')
b <- c('grape', 'banana', 'orange')
'%it%' <- function(x, y) {
  intersect(x, y) # 内置求交集的函数
}
a %it% b

# 函数式编程
### R语言是一种函数式编程语言，其本质可归纳为一句话，即函数和其它对象一样是“一等公民”。也就是说：
### 可以有名字
### 可以没名字
### 作为函数的输出
### 作为函数的输入
FuncList <- list(base = function(x) mean(x), 
                 med = function(x) median(x), 
                 manual = function(x) {
                   n <- length(x)
                   x <- sort(x)[c(-1, -n)] # 排序x, 并去掉第一个，和最后一个元素
                   print(x)
                   mean(x)
                 })
set.seed(1)
x <- sample(100, 10)
FuncList$base(x)
FuncList$manual(x)
# 如果要将三个函数都对x进行计算, 可以使用for循环， 或者更好的是用向量化计算
for (f in FuncList) {
  print(f(x))
}
sapply(FuncList, function(f) f(x)) # 向量化计算
