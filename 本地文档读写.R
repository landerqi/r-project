# 数据获取
### 本地文档读写
### 连接数据库
### web数据抓取
### API数据源
### 其他数据资源

# 控制台输出
### print 或只输入对象名。如果对输出格式有要求，则利用format函数进行调整 
set.seed(1)
out <- data.frame(x1 = runif(3) * 10, x2 = c('a', 'b', 'c'))
out <- format(out, digits = 3)
out
cat(paste(out$x2, out$x1, sep = '='), sep = '\n')

# 控制台输入
x <- readline() # 输入单个字符串数据
x <- scan() #输入多个数值, 如果就是一个向量了，不输入，直接回车，结束

# 本地文本输出
output <- file('output.txt') # 建立一个连接
cat(1:100, sep = '\t', file = output) # cat可以直接将对象输出到文件连接中, 如果文件中已经有内容，可以在cat中设置append参数为真，即表示是新增在文件尾部。
close(output)

output <- file('output.txt')
input <- scan(file = output) # scan读入的内容应该是一致的类型，不可能同时读入字符和数值
close(output)
input

# 字符串的输入与输出
output <- file('output.txt')
writeLines(as.character(1:12), con = output)
input <- readLines(output)
input

# 小练习
### 读取用户r语言已经安装的每个扩展包的DESCRIPTION文件。
path <- .libPaths()[1]
path
doc.names <- dir(path)
doc.names
doc.path <- sapply(doc.names, function(names) paste(path, names, 'DESCRIPTION', sep = '/'))
doc.path
doc <- sapply(doc.path, function(doc) readLines(doc))
doc


# 数据表的读写
head(iris)
write.table(iris, file = 'iris.csv', sep = ',')
data <- read.table(file = 'iris.csv', sep = ',')
data
data <- read.table(file = file.choose(), sep = ',') # file.choose：打开文件选择框
data <- read.table('clipboard') # windows下可用， 复制剪贴板上的内容

# 数据库读写
## R语言和关系型数据库的两种配合方式：
### 用SQL来提取需要的数据，存为文本再由R来读入
### 将R与外部数据库连接，直接在R中操作数据库
## 连接方式的两种选择：
### ODBC方式，需要安装RODBC包并安装ODBC驱动, windows下用比较方便
### DBI方式，可以根据已经安装的数据库类型来安装相应的驱动, 非windows下用

## windows下连接准备
