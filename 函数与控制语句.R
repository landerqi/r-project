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

