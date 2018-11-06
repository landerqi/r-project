# 取数据子集
data_sub <- subset(iris, Species == 'setosa', 3:5)
data_sub <- with(iris, iris[Species == 'setosa', 3:5])

# 编码转换
iris_tr <- transform(iris, v1 = log(Sepal.Length))

# 变量离散化
### 将v1变量根据数值大小分为四组，而且要求每组的样本数大体一样。
q25 <- quantile(iris_tr$v1, 0.25)
q50 <- quantile(iris_tr$v1, 0.50)
q75 <- quantile(iris_tr$v1, 0.75)
groupvec <- c(min(iris_tr$v1), q25, q50, q75, max(iris_tr$v1))
labels <- c('A', 'B', 'C', 'D')
iris_tr$v2 <- with(iris_tr, cut(v1, breaks = groupvec, labels = labels, include.lowest = TRUE))
iris_tr$v2
a <- subset(iris_tr, v2 == 'A')
a[order(a$v1), ] # 升序
a[order(-a$v1), ] # 降序

# 数据类型转换
vec <- rep(c(0, 1), c(4, 6))
vec_fac <- factor(vec, labels = c('male', 'femal'))
levels(vec_fac)
vec_fac

# 因子合并
vec <- rep(c(0, 1, 3), c(4, 6, 2))
vec_fac <- factor(vec)
levels(vec_fac) <- c('male', 'femal', 'male')

# 因子重设
vec <- rep(c('b', 'a'), c(4, 6))
vec_fac <- factor(vec)
levels(vec_fac)
relevel(vec_fac, ref = 'b')

# 数据重塑
### 长型数据（堆叠数据），长型数据是各变量取值在一列中，而对应的变量名在另一列。
### 宽型数据（非堆叠数据），宽型数据一般是各变量取值类型一致，而变量以不同的形式构成。
data_w <- iris[ ,1:4] # 宽型数据
data_w  
data_l <- stack(data_w) # 长型数据
data_l
data_w <- unstack(data_l) # 宽型数据
dim(data_l)
dim(data_w)

subdata <- iris[, 4:5] # 这其实可以看作是长型数据
data_w <- unstack(subdata)
head(data_w)
head(subdata)

# 数据重塑计算
library(reshape2)
dcast(data = subdata,                  # 分析对象
      formula = Species~.,             # 数据分组方式
      value.var = 'Petal.Width',       # 要计算的数值对象
      fun = mean)                      # 计算用函数名

dcast(data = iris_tr,                  # 分析对象
      formula = v2~.,             # 数据分组方式
      value.var = 'Petal.Width',       # 要计算的数值对象
      fun = mean)                      # 计算用函数名

### 融合计算
iris_long <- melt(data = iris, # 要融合的对象
                  id = 'Species') # 哪些变量不参与到融合中
iris_long
### dcast函数的使用前提
##### 数据中已经存在分类变量，例如sex或者smoke
##### 根据分类变量划分数据
##### 再计算某个数值变量的指标

# 数据的拆分合并
### 合并数据框
datax <- data.frame(id = c(1, 2, 3), gender = c(23, 34, 41))
datay <- data.frame(id = c(3, 1, 2), name = c('tom', 'john', 'ken'))
merge(datax, datay, by = 'id')

# 数据按变量拆分
iris_splited <- split(iris, f = iris$Species)
iris_splited
class(iris_splited) # 拆出来的数据不是数据框了，而是列表

# 数据按变量合并
iris_upsplited <- unsplit(iris_splited , f = iris$Species)
class(iris_upsplited)
iris_upsplited

# 小练习
### tips 数据集练习, 它是一个餐厅侍者收集的关于小费的数据
head(tips)
dcast(tips,  sex~., value.var = 'tip', fun = mean) # 按se变量划分
dcast(tips, sex~size, value.var = 'tip', fun = mean) # 按sex和size划分
### 更复杂的需求
tips_melt <- melt(data = tips, id.vars = c('sex', 'smoker', 'time', 'size', 'day'))
head(tips_melt)
tail(tips_melt)
dcast(data = tips_melt, sex ~ variable, value.var = 'value', fun = mean)

ratio_fun <- function(x) {
  sum(x$tip) / sum(x$total_bill)
}
pieces <- split(tips, tips$sex) # 拆分数据
result <- lapply(pieces, ratio_fun) # 计算
result
do.call('rbind', result) # 结果合并
