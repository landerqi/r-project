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
  for (i in 1:10000) {
    y <- findprime(i)
    x <- c(x, y)
  }
})
system.time({
  x <- logical(10000)
  for (i in 1:10000) {
    y <- findprime(i)
    x[i] <- y
  }
})
system.time({
   x <- sapply(1: 1e5, findprime)  
})
