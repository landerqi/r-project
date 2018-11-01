# 取数据子集
data_sub <- subset(iris, Species == 'setosa', 3:5)
data_sub <- with(iris, iris[Species == 'setosa', 3:5])

# 编码转换
iris_tr <- transform(iris, v1 = log(Sepal.Length))

# 变量离散化
### 将v1变量根据数值大小分为四组，而且要求每组的样本数大体一样。
q25 <- quantile(iris_tr$v1, 0.25)
